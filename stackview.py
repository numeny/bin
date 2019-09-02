#!/usr/bin/python3
#coding=utf-8

# Author: qiyanpeng <ypqi@gmail.com>
# This script filters adb logcat output and capture native stack traces
# Then it parsed the stack into man read code.

# Thanks:
# Alexandre Courbot <acourbot@nvidia.com>
# project source: https://github.com/Gnurou/logcatresolve
# provide the parse frame, though changed a lot.
#
# Repolho
# sample code: https://repolinux.wordpress.com/2012/10/09/non-blocking-read-from-stdin-in-python/
# give a frame of thread monitor stdin.

# Usage;
# $ adb logcat |python stackview.py

# The script needs some config shows in dict config. the config
# will be passed as json to parser instance.

"""Store input in a queue as soon as it arrives, and work on
it as soon as possible. Do something with untreated input if
the user interrupts. Do other stuff if idle waiting for
input."""

import sys, os, os.path, signal
import time, re, json
import queue
import select
import threading, subprocess

class StackSucker:
    pattern = None
    addr2line_cmd = None
    lib_location = ''
    config = {}
    # 将重复的栈移除，避免多次解析，占用时间和资源。
    stack_pool = {}
    stack_list = []
    stack_raw_line = []
    addr2_service = None
    stack_hash = set([])
    pc_num = 0
    def __init__(self, json_text):
        config = json.loads(json_text)
        self.pattern = re.compile(config['stack_format'])

        abs_path = re.compile('^/.*')
        self.lib_location = config['lib_location']
        if not abs_path.search(self.lib_location):
            self.lib_location = os.path.join(config['project_root'], self.lib_location)

        tool_path = config['parser_path']
        if not abs_path.search(tool_path):
            tool_path =os.path.join(config['project_root'], tool_path)

        for bin in config['parser_name']:
            tmp = os.path.join(tool_path, bin)
            if os.path.isfile(tmp):
                self.addr2line_cmd = tmp
                break

        if not self.addr2line_cmd:
            print("Cannot find addr2line binary!")
            sys.exit(1)
        self.config = config
        cmd = [self.addr2line_cmd, "-C", "-f", "-e", self.lib_location]
        #print(cmd)
        self.addr2_service = subprocess.Popen(cmd, stdin=subprocess.PIPE,stdout=subprocess.PIPE)

    #必须清理掉生成的子进程，否则造成系统变慢
    def __del__(self):
        if self.addr2_service:
            os.kill(self.addr2_service.pid, signal.SIGINT)

    #删除不符合需要的行信息，保留需要的栈信息，主要指一些前缀。
    def removePrefix(self, line):
       start = line.find("#")
       return line[start - 1:]

    def OutputStack(self):
        ret_real = 'StackID: ' + str(self.pc_num) + '\n'
        for idx in range(len(self.stack_list)):
            r_line = self.stack_raw_line[idx]
            pc = self.stack_list[idx]
            ret = self.stack_pool[pc]

            if self.config['raw_msg']:
                r_line = self.removePrefix(r_line)

            m = self.pattern.search(r_line)
            if ret:
                temp = r_line[:m.start(2)] + ret[0].decode('UTF-8') + "  @  " + ret[1][len(self.config['project_root']) + 1:].decode('UTF-8') + '\n'
                ret_real = ret_real + temp

        # 这个是最后结果，交给主线程去输出
        if ret_real:
            ret_real  = ret_real + '\n'
            input_queue.put(ret_real)
        self.stack_list = []
        self.stack_raw_line = []

    # 将符合条件的行过滤出来
    def collectStackFromeStream(self, line):
        m = self.pattern.search(line)
        if m:
            stack_seq = m.group(1)
            #新的栈来了，发送旧的栈给主线程，并清空临时栈列表
            if stack_seq == '00' and len(self.stack_list) > 0:
                if self.pc_num in self.stack_hash:
                    print("same stack %s will not output!", self.pc_num)
                else:
                    self.stack_hash.add(self.pc_num)
                    self.OutputStack()
                self.pc_num = 0

            stack_pc = m.group(self.config['target_pc'])
            self.pc_num += int(stack_pc.upper(), 16)
            self.stack_raw_line.append(line)

            if stack_pc not in self.stack_pool:
                self.stack_pool[stack_pc] = self.handleStack(stack_pc)

            self.stack_list.append(stack_pc)

    def handleStack(self, pc):
       #print addr2line_cmd + " -C -f -e " + shllib +addr
       pc = pc + '\n'
       self.addr2_service.stdin.write(bytes(pc,"UTF-8"))
       self.addr2_service.stdin.flush()
       # 输入是分为两行的，第一行是函数信息，第二行是文件行号信息
       response = self.addr2_service.stdout.readline().splitlines()
       response += self.addr2_service.stdout.readline().splitlines()
       return response
       #return subprocess.check_output([self.addr2line_cmd, "-C", "-f", "-e", self.lib_location, pc]).splitlines()

#re = re.compile("#\\d+ 0x([\\da-f]+) +([\/\\\.\\-\\w]+)")
#re.compile("#\\d+ 0x([\\da-f]+) +(.*\.so)")
#re = re.compile("#\\d+ (0x[\\da-f]+) +.*/(.*view.so)\\+(.*)")
#re = re.compile("#\\d+ +(pc +)([\\da-f]+) +([\/\\\.\\w]+)")

config = {
   'stack_format' : "#(\\d+) (0x[\\da-f]+) +.*/(.*view.so)\\+(.*)",
   'addr2line_cmd' : None,
   'parser_name' : ["arm-eabi-addr2line", "arm-linux-androideabi-addr2line"],
   'project_root' : "/home/bdg/ssd/chromium/src",
   'lib_location' : 'out/Release/lib/libsogou_content_shell_content_view.so',
   'parser_path' : 'third_party/android_tools/ndk/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin',
   'raw_msg' : True,
   'target_pc' : 4
}

# files monitored for input
read_list = [sys.stdin]
# select() should wait for this many seconds for input.
timeout = 0.1 # seconds
last_work_time = time.time()

def treat_input(linein):
  global last_work_time
  #print("Workin' it!", linein, end='')
  print(linein)
  if linein:
      print('\n')
  time.sleep(1) # working takes time
  #print('Done')
  last_work_time = time.time()

def idle_work():
  global last_work_time
  now = time.time()
  # do some other stuff every 2 seconds of idleness
  if now - last_work_time > 2:
    #print('Idle for too long; doing some other stuff.')
    last_work_time = now

# some sort of cleanup that involves the input
def cleanup():
  print()
  while not input_queue.empty():
    line = input_queue.get()
    #print("Didn't get to work on this line:", line, end='')

# will hold input
input_queue = queue.Queue()

# will signal to the input thread that it should exit:
# the main thread acquires it and releases on exit
interrupted = threading.Lock()
interrupted.acquire()

# input thread's work: stuff input in the queue until
# there's either no more input, or the main thread exits
def read_input():
  text = json.dumps(config)
  sucker = StackSucker(text)
  print(">>>>>>> sucker start working... >>>>>>>>>>>>>>>>>>>>>>>>>")

  while (read_list and not interrupted.acquire(blocking=False)):
    ready = select.select(read_list, [], [], timeout)[0]
    for file in ready:
      line = file.readline()
      if not line: # EOF, remove file from input list
        print("reache eof")
        #sucker.OutputStack()
        read_list.remove(file)
      elif line.rstrip(): # optional: skipping empty lines
        #input_queue.put(line)
        sucker.collectStackFromeStream(line)
  del sucker
  print('Input thread is done.')

input_thread = threading.Thread(target=read_input)
input_thread.start()

try:
  while True:
    # if finished reading input and all the work is done,
    # exit
    if input_queue.empty() and not input_thread.is_alive():
      break
    else:
      try:
        treat_input(input_queue.get(timeout=timeout))
      except queue.Empty:
        idle_work()
except KeyboardInterrupt:
  cleanup()

# make input thread exit as well, if still running
interrupted.release()
print('Main thread is done.')
