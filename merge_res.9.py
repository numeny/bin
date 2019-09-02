#!/usr/bin/env python
# coding=utf8

import os
import sys
import re

supports_lang_list = []

translate_base = {}

def peek_data():
    print 'peek collected data......'
    for k in translate_base.iterkeys():
        print k + "  ->\n" + ''.join(translate_base[k])

def write_to_output(output_to):
    # es-419 is Spanish lang, android not support
    # fil/no will have lint warnings for misstranslate, avoid handle.
    no_handle_list = ['es-419', 'fil', 'no']
    for k in translate_base.iterkeys():
        if k in no_handle_list:
            continue

        lang_part = k.split('-')
        new_lang = k
        if len(lang_part) > 1:
            new_lang =  lang_part[0] + '-r' + lang_part[1]

        # Make values-id to values-in to avoid Lint error
        if new_lang == 'id':
            new_lang = 'in'

        dir_name = 'values-' + new_lang
        output = os.path.join(output_to, dir_name)
        if not os.path.exists(output):
            os.mkdir(output)
        output = os.path.join(output, 'strings.xml')
        lines = []
        if os.path.exists(output):
            with open(output, 'r') as f:
                lines = f.readlines()

        with open(output, 'w') as f:
            if len(lines) > 3:
                last_line = lines.pop()
                lines.extend(translate_base[k])
                lines.append(last_line)
            else:
                lines = []
                lines.append('<?xml version="1.0" encoding="utf-8"?>\n')
                lines.append('<resources xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2">\n')
                lines = lines + translate_base[k]
                lines.append('</resources>')

            f.writelines(lines)

def do_merge(root, t_id, name):
    r = re.compile(r'.*(_[a-z]{2}.).*')
    global supports_lang_list
    text_value = re.compile(r'.*<.*id="(.*)".*>(.*)<.*>.*')
    for lang in supports_lang_list:
        for fl in os.listdir(root):
            if fl.find("_" + lang +'.xtb') > 0:
                with open(os.path.join(root, fl), 'r') as f:
                    lines = f.readlines()
                    for l in lines:
                        ret = text_value.match(l)
                        if ret and ret.group(1) == t_id:
                            txt = ret.group(2)
                            if txt.startswith('"'):
                                txt = txt[1:]
                            if txt.endswith('"'):
                                txt = txt[0:-1]
                            new_t = '    <string name=\"' + name + '\">\"' + txt + '\"</string>\n'
                            translate_base[lang].append(new_t)
                            # print new_t

def fetch_supported_lang(root):
    global supports_lang_list
    for file_name in os.listdir(root):
        if not file_name.endswith('.xtb'):
            continue
        last_dot = file_name.rfind('.')
        last_hor = file_name.rfind('_', 0, last_dot)
        lang = file_name[(last_hor + 1):last_dot]
        supports_lang_list.append(lang)
        translate_base[lang] = []

def do_merge_from_android(root, t_id, name):
    r = re.compile(r'.*(_[a-z]{2}.).*')
    global supports_lang_list
    text_value = re.compile(r'.*<.*id="(.*)".*>(.*)<.*>.*')
    for lang in supports_lang_list:
        lang_part = lang.split('-')
        new_lang = lang
        if len(lang_part) > 1:
            new_lang =  lang_part[0] + '-r' + lang_part[1]
        # print new_lang
        for fl in os.listdir(root):
            if fl.endswith('values-' + new_lang):
                with open(os.path.join(root, fl + '/strings.xml'), 'r') as f:
                    lines = f.readlines()
                    for l in lines:
                        ret = text_value.match(l)
                        if ret and ret.group(1) == t_id:
                            txt = ret.group(2)
                            if txt.startswith('"'):
                                txt = txt[1:]
                            if txt.endswith('"'):
                                txt = txt[0:-1]
                            new_t = '    <string name=\"' + name + '\">\"' + txt + '\"</string>\n'
                            translate_base[lang].append(new_t)
                            # print new_t

def do_bigbang_translate(lang, text, name):
    fenchi_list = {
        'en-GB':'Participle',
        'iw':'פילוח מילים',
        'no':'Ordssegmentering',
        'it':'Segmentazione di parole',
        'th':'การแบ่งส่วนคำ',
        'de':'Wortsegmentierung',
        'ja':'ワードセグメンテーション',
        'pt-BR':'Segmentação de palavras',
        'bg':'Сегментиране на думи',
        'es':'Segmentación de palabras',
        'sr':'Сегментација ријечи',
        'tr':'Kelime Segmentasyonu',
        'nl':'Woordsegmentatie',
        'am':'የቃል ማካፈል',
        'sk':'Segmentácia slov',
        'hu':'Szó szerinti szegmentálás',
        'sv':'Ordsegmentering',
        'zh-CN':'智能选词',
        'fr':'Segmentation de mots',
        'pt-PT': 'Segmentação de palavras',
        'ro': 'Segmentarea cuvintelor',
        'el': 'Τμηματοποίηση λέξεων',
        'hr': 'Segmentacija riječi',
        'lt': 'Žodžių segmentavimas',
        'lv': 'Vārda segmentācija',
        'fil': 'Bigbang',
        'pl': 'Segmentacja słów',
        'ko': '단어 세분화',
        'fi': 'Word Segmentaatio',
        'sw': 'Sehemu ya Neno',
        'hi': 'शब्द विभाजन',
        'fa': 'تقسیم کلمه',
        'id': 'Segmentasi Kata',
        'cs': 'Segmentace slov',
        'ar': 'تقسيم الكلمة',
        'da': 'Word Segmentation',
        'zh-TW': '分詞',
        'ca': 'Segmentació de paraules',
        'ru': 'Сегментация слов',
        'vi': 'Phân đoạn từ',
        'es-419': 'Segmentación de palabras',
        'sl': 'Segmentacija besedil',
        'uk': 'Сегментація слів',
    }
    for lang in supports_lang_list:
        new_t = '    <string name=\"' + name + '\">\"' + fenchi_list[lang] + '\"</string>\n'
        translate_base[lang].append(new_t)

def do_merge_work_for_select():
    chromium_root = '/home/qiyanpeng/ssd/sogou_chromium/src/'
    content_res_path = chromium_root + 'content/public/android/java/strings/translations/'
    chrome_res_path = chromium_root + 'chrome/android/java/strings/translations/'
    do_merge(chrome_res_path, '6831043979455480757', 'sw_translate') #翻译
    do_merge(content_res_path, '1542044944667958430', 'sw_websearch') # 网页搜索
    do_merge(content_res_path, '6527303717912515753', 'sw_share') # 分享

    aosp_path = '/home/qiyanpeng/ssd/aosp/'
    framework_res_path = aosp_path + 'frameworks/base/core/res/res/'
    # 从aosp中提取对应的语言.
    do_merge_from_android(framework_res_path, '2681946229533511987', 'sw_copy') #复制
    do_merge_from_android(framework_res_path, '3092569408438626261', 'sw_cut') #剪切
    do_merge_from_android(framework_res_path, '5629880836805036433', 'sw_paste') #粘贴
    do_merge_from_android(framework_res_path, '6876518925844129331', 'sw_selectall') #全选
    do_merge_from_android(framework_res_path, '5229115638567440675', 'sw_dial') #电话
    do_merge_from_android(framework_res_path, '8322172381028546087', 'sw_gotowebsite') #浏览

    # 从翻译接口提取对应的语言.
    do_bigbang_translate('zh', '智能选词', 'sw_bigbang') #智能选词
    peek_data()
    write_to_output('/home/qiyanpeng/work_benche/code_read/sogou_chromium/src/sogou_webview/java/res/')

if __name__ == '__main__':
    fetch_supported_lang('/home/qiyanpeng/ssd/sogou_chromium/src/chrome/android/java/strings/translations/')
    print supports_lang_list
    do_merge_work_for_select()

