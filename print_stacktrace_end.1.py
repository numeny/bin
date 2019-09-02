#!/usr/bin/env python
# Copyright (c) 2011 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Reports binary size and static initializer metrics for an APK.

More information at //docs/speed/binary_size/metrics.md.
"""

import argparse
import json
import logging
import os
import re
import sys

filter_str = "libsogouwebview.so+"
out_tmp_file = "/tmp/out_tmp_file"
out_tmp_file_address_only = "/tmp/out_tmp_file_address_only"

def filter_lib_sogou_webview(input_file):
  global filter_str
  cmd = "cat " + input_file + " | grep " + filter_str + " > " + out_tmp_file
  os.system(cmd)
  output_func_address_only()

def output_func_address_only():
  if not os.path.exists(out_tmp_file):
    print("[Error] no stacktrace exists : %s" % out_tmp_file)
    exit(-1)
  pattern = re.compile(r'.*libsogouwebview.so\+(.*)')
  with open(out_tmp_file, 'r') as f:
    lines = f.readlines()
    for line in lines:
      ret = pattern.match(line)
      print("\naddress: %s" % ret.group(1))
      cmd = "print_coredump.sh " + ret.group(1)
      os.system(cmd)

def main():
  argparser = argparse.ArgumentParser(description='Print APK size metrics.')
  argparser.add_argument('--input-file',
                         dest='input_file',
                         help='Input log file from logcat.')
  argparser.add_argument('--output-file',
                         dest='output_file',
                         help='Output file that save parsed stack trace.')

  args = argparser.parse_args()

  if not args.input_file:
    argparser.error("require input logcat file with opt : --input-file !")
  print("input logcat file: %s" % args.input_file)
  print("output stack trace file: %s" % args.output_file)
  if not os.path.exists(args.input_file):
    print("[Error] input logcat file does not exist : %s" % args.input_file)
    exit(-1)
  filter_lib_sogou_webview(args.input_file)

if __name__ == '__main__':
  sys.exit(main())
