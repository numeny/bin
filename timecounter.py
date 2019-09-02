#!/usr/bin/python
# _*_coding=utf-8-*-
import sys
import re
import json
import getopt

# 数据域的名称
# 全局数据收集桶, 数据格式url:[{},...]
global_template  = {}
template = 'template.json'
data_files = []
store_path = ''
ruler = []
stastic_result = {
    'invalid_lines': 0,
    'exception_lines': 0,
    'input_lines':0
}

class DataItem:
    def __init__(self, v, t):
        self.value = float(v)
        self.times = int(t)
        if t == 0:
           self.avg = 0
        else:
           self.avg = float(v)/int(t)
        self.min = float(v)
        self.max = float(v)

    def exception(self, v):
        if self.avg == 0.0:
            return True

        return abs(float(v) - self.avg)/self.avg >= global_template[u'torlerance_range']

    def __add__(self, item):
       self.value += item.value
       self.times += item.times
       self.avg = (self.avg + item.avg)/2
       if item.value > self.max:
           self.max = item.value
       elif item.value < self.min:
           self.min = item.value
       return self

    def avg_value(self):
       return round(self.avg, 3)

class BucketItem:
    def __init__(self, line):
        self.data = []
        for l in line:
            c, d = l.strip().split('/')
            self.data.append(DataItem(float(c),int(d)))

    def __add__(self, line):
        for i in range(0, len(line)):
            c, d = line[i].strip().split('/')
            self.data[i] = self.data[i] + DataItem(float(c), int(d))
        return self

    def __len__(self):
        return len(self.data)
    def __getitem__(self, i):
        return self.data[i]
    def printItem(self):
        global ruler
        line = []
        for idx in ruler:
            line.append(str(self.data[idx].avg_value()))

        #for d in self.data:
        #    line.append(str(d.avg_value())+'ms')
        return ' '.join(line)

class Bucket:
    input_count = 0
    exception_count = 0
    bucket = {}

    def __init__(self):
        self.url_count = 0
        self.item_count = 0
        pass

    #判断输入数据是否在有效范围内.
    def validate(self, item_list, line):
        return True
        for i in range(0, len(item_list)):
            v, t = line[i].strip().split('/')
            if not item_list[i].exception(v):
                return False

    def get_url(self, url):
        if not self.bucket.has_key(url):
            return None
        return self.bucket[url]

    def get_kind_in_url(self, url, kind):
        url_item =  self.get_url(url)
        if url_item and url_item.has_key(kind):
            return url_item[kind]

        return None

    def append(self, line, kind, url):
        stastic_result['input_lines'] += 1
        url_item = self.get_url(url)
        kind_item = self.get_kind_in_url(url,kind)
        if kind_item and not self.validate(kind_item, line):
            stastic_result['exception_lines'] += 1
            pass

        if not url_item:
            self.bucket[url] = {}
            self.url_count += 1
            print 'full create %s, %s'%(url,kind)

        if not kind_item:
            print 'half create %s, %s'%(url,kind)
            self.bucket[url][kind] = BucketItem(line)
            self.item_count +=1
        else:
            print 'append %s, %s'%(url,kind)
            self.bucket[url][kind] = self.bucket[url][kind] + line

    def printBucket(self):
        line = ''
        for b in self.bucket:
            if self.bucket[b]['first_shot']:
                line += ' '.join([b, "  first_shot ", self.bucket[b]["first_shot"].printItem()])
                line += '\n'
            if self.bucket[b]['fully_load']:
                line += ' '.join([b, "  fully_load  ", self.bucket[b]["fully_load"].printItem()])
                line += '\n'
        return line

global_bucket = Bucket()

# 利用模板来过滤行中的无用信息,模板需要手动编写,在配置文件中指定,模块初始化时会读取它.
def LineFilte(line):
    pattern = re.compile('^.*\:\s(.*)')
    c = pattern.match(line)
    if c:
        return c.group(1)
    return None

# 验证数据行的长度.
def validateDataLength(data):
   return len(data) == len(global_template[u'data_format'])

# 处理每一个数据文件
def consume_file(f):
    global global_template
    lines = f.readlines()
    invalid_line = 0
    for line in lines:
       line = LineFilte(line)
       #过滤非pattern格式的数据行
       if not line:
           stastic_result['invalid_lines'] += 1
           continue
       line_data = []
       try:
          line_data = line.strip().split(' ')
       except:
           continue
       #检验数据项类型和url是否为合法内容.
       kind = line_data[0].strip()
       url = line_data[1].strip()
       if kind not in global_template[u'data_items']:
           stastic_result['invalid_lines'] += 1
           continue

       if not url.find('http:') == 0 and not url.find('https:') == 0:
           stastic_result['invalid_lines'] += 1
           continue

       #检查数据长度
       if not validateDataLength(line_data):
           stastic_result['invalid_lines'] += 1
           continue
       #添加到数据桶中
       global_bucket.append(line_data[2:], kind, url)

# 高级数据处理代码区

# 以下为主流程处理代码区
def suck_data_files(files):
    for file in files:
        f = open(file, "r");
        consume_file(f)
        f.close()

def load_template(file_name):
    global global_template
    with open(file_name, mode='r') as f:
        global_template = json.load(f)

def compute_report_rule():
    global global_template
    global ruler
    ruler = []
    data_format = global_template['data_format']
    for v in global_template['report_format']:
        ruler.append(data_format.index(v) - 2)
    print ruler

def print_report():
    global global_bucket
    print 'input %d, invalid %d, exceptions %d'%(stastic_result['input_lines'],stastic_result['invalid_lines'],stastic_result['exception_lines'])
    print global_bucket.printBucket()

def store_json(path):
    global global_bucket
    content = global_bucket.printBucket()
    with open(path, mode='w') as f:
        json.dump(content, f)

def store_report(path):
    if path == '':
        print_report()
    else:
        store_json(path)

# 以下为参数处理代码
def print_help():
    print '''
    [Usage]  TimeCounter Stastics
        -h show This usage.
        -t path of template file, template.json by default.
        -d files contains raw data to stastic.
        -s file to store the result, just show by default.
    '''
def handle_params():
    global template
    global data_files
    global store_path
    if len(sys.argv) <= 1:
        print_help()
        return None

    opts, args = getopt.getopt(sys.argv[1:], 'ht:d:s:')
    for o,g in opts:
        if o == '-h':
            print_help()
            return None
        elif o == '-t':
            if g:
                template = g
        elif o == '-d':
            data_files  = g.split()
            print data_files
        elif o == '-s':
            store_path = g
        else:
            print_help()
            return None
    return True


if __name__ == '__main__':
    if handle_params():
        load_template(template)
        compute_report_rule()
        print data_files
        suck_data_files(data_files)
        store_report(store_path)

