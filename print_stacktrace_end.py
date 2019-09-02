#!/usr/bin/env python
#
# Copyright 2017 The Sogou Inc. All rights reserved.
# Author: fanjinsong@sogou-inc.com.

"""Archives a set of files.
"""

import ast
import optparse
import os
import os.path
import sys

REPOSITORY_ROOT = os.path.abspath(os.path.join(
    os.path.dirname(__file__), '..', '..'))

""" Compress list of files by lzma.
def DoLzma(inputs, output, enable_ota, ota_dir):

  Args:
    inputs: A list of files to compress by lzma.
    output: Destination .lzma file.
  output = os.path.abspath(output)

  print " Compress resources and libraries by lzma, move them to dest dir. "
  for tup in inputs:
    tup = os.path.abspath(tup)
    cmd = "lzma -f " + tup
    if tup.endswith(".so.origin"):
      file_name = tup + ".lzma"
      new_name = tup.replace(".origin", "")
      cmd = cmd + "; mv -f " + file_name + " " + new_name

    if bool(cmd and cmd.strip()):
        print cmd
        os.system(cmd)

  if enable_ota and ota_dir:
    cmd = "mv -f " + output + "/libsogouwebview.so" + " " + ota_dir + "ota/"
    os.system(cmd)
"""

def main():
  parser = optparse.OptionParser()

  parser.add_option('--input', help='Log file from logcat.')
  parser.add_option('--output', help='Path to output file.')

  options, _ = parser.parse_args()

  print options.input
  print options.output
  '''
  inputs = ast.literal_eval(options.inputs)
  DoLzma(inputs, options.output_dir, options.enable_ota, options.ota_dir)
  '''


if __name__ == '__main__':
  sys.exit(main())
