set tabstop=4
set expandtab
set hlsearch
set ruler
set encoding=gb2312
set showcmd

syntax enable
syntax on
colorscheme desert

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set ignorecase "忽略大小写

"##################
"set tags+=/home/bdg/svn/webkit_403.tags/nufront_webkit/Source/tags
"cs add /home/bdg/svn/webkit_403.tags/nufront_webkit/Source/cscope.out
"set tags+=~/svn/webkit_403.tags/NuBrowserPad$/tags
"cs add ~/svn/webkit_403.tags/NuBrowserPad$/cscope.out
"##################

"set tags+=/home/bdg/work/key/4.1/webkit/tags
"cs add /home/bdg/work/key/4.1/webkit/cscope.out

"set tags+=/home/bdg/work/key/4.1/java/tags
"cs add /home/bdg/work/key/4.1/java/cscope.out

set tags+=~/svn/branch_key/nufront_webkit/Source/tags
cs add ~/svn/branch_key/nufront_webkit/Source/cscope.out

set tags+=/home/bdg/workspace/workspace/BinFenTVBrowser/tags
cs add /home/bdg/workspace/workspace/BinFenTVBrowser/cscope.out

"set tags+=/home/bdg/svn/webkit_420_trunk/nufront_webkit/Source/tags
"cs add /home/bdg/svn/webkit_420_trunk/nufront_webkit/Source/cscope.out

"set tags+=/home/bdg/svn/webkit_420_trunk/nufront_webkit/tags
"cs add /home/bdg/svn/webkit_420_trunk/nufront_webkit/cscope.out

"set tags+=/home/bdg/other_browser/webkit/WebKit-r151833/Source/tags
"cs add /home/bdg/other_browser/webkit/WebKit-r151833/Source/cscope.out

"set tags+=~/other_browser/samsung/GT-B9062_CHN_Platform/external/webkit/Source/tags
"cs add ~/other_browser/samsung/GT-B9062_CHN_Platform/external/webkit/Source/cscope.out


"set tags+=~/workspace/workspace/NuBrowserPad/tags
"cs add ~/workspace/workspace/NuBrowserPad/cscope.out
"let g:LookupFile_TagExpr='"/home/bdg/svn/java/BrowserActivity/filenametags"'

"set tags+=~/android/google_android403r1/google_android403r1/external/chromium/tags
"cs add ~/android/google_android403r1/google_android403r1/external/chromium/cscope.out
"let g:LookupFile_TagExpr='"/home/bdg/android/google_android403r1/google_android403r1/external/chromium/filenametags"'

let mapleader=","
map <leader>e :edit ~/.vimrc<Esc>
map <leader>s :source ~/.vimrc<Esc>
syntax on

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
" set cscopetag


if has("cscope")
set csprg=/usr/bin/cscope
" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=1
set cst
set nocsverb
" add any database in current directory
if filereadable("cscope.out")
cs add cscope.out
" else add database pointed to by environment
elseif $CSCOPE_DB != ""
cs add $CSCOPE_DB
endif
set csverb
endif

map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 0


"map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
" 字符集
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1

set cindent

" 设置vimdiff上下文可见
set diffopt=filler,context:1000

""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"映射LookupFile为,lk
nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>

    " lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
let _tags = &tags
try
let &tags = eval(g:LookupFile_TagExpr)
let newpattern = '\c' . a:pattern
let tags = taglist(newpattern)
catch
echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
return ""
finally
let &tags = _tags
endtry

" Show the matches for what is typed so far.
let files = map(tags, 'v:val["filename"]')
return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc' 
