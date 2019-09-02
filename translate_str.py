#!/usr/bin/env python
# coding=utf8

import optparse
import os
import sys
import shutil
import re

import translate_str_impl

sys.path.append(os.path.join(os.path.dirname(__file__), '../../build/android/gyp'))
# from util import build_utils

def ParseArgs():
    usage  = '[Usage] '
    parser = optparse.OptionParser(usage)
    parser.add_option('-t', '--type',
            help='type for translation, 1 - manual')
    parser.add_option('-o', '--out-file', default='',
            help='')
    parser.add_option('-i', '--in-file',
            help='')
    parser.add_option('-n', '--str-name', default='',
            help='destination string name if out, and following string name if in')

    options, args = parser.parse_args()

    # Check that required options have been provided.
    # required_options = ['in_file']
    # build_utils.CheckOptions(options, parser, required=required_options)
    return options, args

def manualTransGenerateFile(str_name, out_file, lang_list):
    print 'str_name: ' + str_name + ', out_file: ' + out_file
    with open(out_file, 'w') as f:
        f.write('{\'name\': \'' + str_name + '\', \n\'lan\': {\n')
        for lang in lang_list:
            f.write('\'' + lang + '\' : \'\',\n')
        f.write('}}\n')

def manualTransToRes(in_file, before_name):
    print 'manualTransToRes ... in_file: ' + in_file
    with open(in_file, 'r') as f:
        all_str = f.read()
    all_str = all_str.replace("\n", "")
    print "all_str: " + all_str
    values = eval(all_str)
    lan_list = values['lan']
    translate_str_impl.do_manual_translate(values['name'], lan_list)
    print translate_str_impl.translate_base
    translate_str_impl.write_to_res_output(before_name)

def manualTrans(opt, args):
    print 'manualTrans'
    if len(opt.str_name.strip()) == 0:
        print '[Usage] input string name or before_name please!'
        return
    if len(opt.out_file.strip()) > 0:
        print 'manualTrans - outputing file... ' + opt.out_file
        print opt.out_file
        manualTransGenerateFile(opt.str_name, opt.out_file, translate_str_impl.supports_lang_list)
        return
    if len(opt.in_file.strip()) > 0:
        manualTransToRes(opt.in_file, opt.str_name)

def main(argv):
    options, args = ParseArgs()
    print(options.type)
    print(options.in_file)
    print(options.out_file)

    translate_str_impl.init()
    print translate_str_impl.supports_lang_list

    if options.type == '1':
        manualTrans(options, args);
    else:
        print "[Error] This type (-t) is Not Support now!"

if __name__ == '__main__':
    sys.exit(main(sys.argv))
