# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vi='vim'

export PAD_LIB_PATH=out/target/product/nusmart3_pad/system/lib
export PAD_SYM_PATH=out/target/product/nusmart3_pad/symbols/system/lib
export PAD_IMG_PATH=out/target/product/nusmart3_pad

export EMULATOR_LIB_PATH=out/target/product/generic/system/lib
export EMULATOR_SYM_PATH=out/target/product/generic/symbols/system/lib
export EMULATOR_IMG_PATH=out/target/product/generic

export WEBKIT_PATH=external/webkit/Source
export NUFRONT_WEBKIT_PATH=external/nufront_webkit/Source

############### this section should be changed for platform ################
export ANDROID_LIB_PATH=${PAD_LIB_PATH}
export ANDROID_SYM_PATH=${PAD_SYM_PATH}
export ANDROID_IMG_PATH=${PAD_IMG_PATH}
#export ANDROID_PATH=/home/bdg/android/IceCreamSandwich
#export ANDROID_PATH=~/android/google_android403r1/google_android403r1
export ANDROID403_PATH=/home/bdg/android/android4.0.3
export ANDROID404_PATH=/home/bdg/android/android4.0.4
export ANDROID420_PATH=~/android/jellybean

export ANDROID403_PAD_PATH=/home/bdg/android/android4.0.3
export ANDROID420_PAD_PATH=~/android/jellybean

export ANDROID_PATH=${ANDROID403_PAD_PATH}

export NFS_PATH=/home/bdg/mnt
export SMB_PATH=/home/bdg/server
export UBUNTU_PATH=~/ubuntu

############### this section should be changed for platform ################

#ubuntu 32/64 disk
alias cdudisk="cd ${UBUNTU_PATH}"
alias cduhome="cd ${UBUNTU_PATH}/home/bdg"

#NFS PATH
export NFS_403PAD_PATH=${NFS_PATH}/android403/android403r1_ns115_new
export NFS_404PAD_PATH=${NFS_PATH}/android4.0.4/android-404
export NFS_410PAD_PATH=${NFS_PATH}/android403/android403r1_ns115_new
export NFS_420PAD_PATH=${NFS_PATH}/android420/android4.2

export NFS_ANDROID403_PATH=${NFS_PATH}/android403/google_android403r1
export NFS_ANDROID404_PATH=${NFS_PATH}/android403/google_android403r1
export NFS_ANDROID410_PATH=${NFS_PATH}/android403/google_android403r1
export NFS_ANDROID420_PATH=${NFS_PATH}/android420/google.4.2/source

export NFS_ANDROID_PATH=${NFS_PAD403_PATH}
export NFS_LIB_PATH=${PAD_LIB_PATH}
export NFS_SYM_PATH=${PAD_SYM_PATH}
export NFS_IMG_PATH=${PAD_IMG_PATH}

export NFS_PAD_PATH=${NFS_PAD403_PATH}
###############################

# svn path
export SVN_PATH=~/svn
export SVN_SRC_PATH=${SVN_PATH}/branch_key
export SVN_BRANCH_PATH=${SVN_PATH}/branch_key
export SVN_TRUNK_PATH=${SVN_PATH}/webkit_403_trunk

# other's path set
export WORKSPACE_PATH=~/workspace/workspace
export PROJECT_PATH=${WORKSPACE_PATH}/BinFenTVBrowser
export PROJECT420_PATH=~/workspace/android4.2/BinFenTVBrowser
export APACHE2_PATH=/var/www/
export OTHER_BROWSER_PATH=/home/bdg/other_browser
export APKTOOL_PATH=~/downloads/apktool1.5.2/apktool-install-linux-r05-ibot


# flash
alias viflash="vi ${SVN_PATH}/Doc/烧系统流程-android4.0.3.txt"
# svn path
alias cdsvn="cd ${SVN_PATH}"

alias cdsvnnufrontwebkit="cd ${SVN_SRC_PATH}/nufront_webkit/Source"
alias cdsvnwebkit="cd ${SVN_SRC_PATH}/webkit/Source"
alias cdsvnv8="cd ${SVN_SRC_PATH}/nufront_v8"
alias cdsvnchrome="cd ${SVN_SRC_PATH}/nufront_chromium"

alias cdsvntrunkwebkit="cd ${SVN_TRUNK_PATH}/nufront_webkit/Source"
alias cdsvntrunkv8="cd ${SVN_TRUNK_PATH}/nufront_v8"
alias cdsvntrunkchrome="cd ${SVN_TRUNK_PATH}/nufront_chromium"


alias cdhome="cd ~"
alias cddownload='cd ~/downloads'
alias cdtest='cd ~/test'
alias cdwork='cd ~/work/4.2.webkit.port'
alias cdbuild='cd ~/build'
alias cdstudy='cd ~/study/'
alias cdsdk="cd ~/android-sdk-linux"
alias cdtmp="cd ~/tmp"
alias cdbin="cd ~/bin"
alias cdworkspace="cd ${WORKSPACE_PATH}"
alias cdproject="cd ${PROJECT_PATH}"
alias cdproject420="cd ${PROJECT420_PATH}"

alias cdother-browser="cd ${OTHER_BROWSER_PATH}/"
alias cdnew-webkit="cd ${OTHER_BROWSER_PATH}/webkit/WebKit-r134433/Source"
alias cdold-webkit="cd ${OTHER_BROWSER_PATH}/webkit/WebKit-r112532/Source"
alias cdother-browser="cd ${OTHER_BROWSER_PATH}/"
alias cdqt-webkit="cd ${OTHER_BROWSER_PATH}/qt/WebKit-r112532/Source"
alias cdchrome="cd ${OTHER_BROWSER_PATH}/chrome/chromium.r157924/src"
alias cdchrome-webkit="cd ${OTHER_BROWSER_PATH}/chrome/chromium.r157924/src/third_party/WebKit/Source"
alias cdchrome-debug="cd ${OTHER_BROWSER_PATH}/chrome/chromium.r157924/src/out/Debug/"
alias cdchrome-new="cd ${OTHER_BROWSER_PATH}/chrome/chromium.r157924.update/src"
alias cdchrome-new-webkit="cd ${OTHER_BROWSER_PATH}/chrome/chromium.r157924.update/src/third_party/WebKit/Source"

alias cdapache2="cd ${APACHE2_PATH}"
alias cdhtml5test="cd ${APACHE2_PATH}/html5test-simple"

alias cdapktool="cd ${APKTOOL_PATH}"

alias cdandroid="cd ${ANDROID_PATH}"
alias cdwebkit="cd ${ANDROID_PATH}/${WEBKIT_PATH}"
alias cdnufront="cd ${ANDROID_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cdimg="cd ${ANDROID_PATH}/${ANDROID_IMG_PATH}"
alias cdlib="cd ${ANDROID_PATH}/${ANDROID_LIB_PATH}"
alias cdsym="cd ${ANDROID_PATH}/${ANDROID_SYM_PATH}"
alias cdframe="cd ${ANDROID_PATH}/frameworks/base/core/java/android"

alias cd403pad="cd ${ANDROID403_PAD_PATH}"
alias cd403padwebkit="cd ${ANDROID403_PAD_PATH}/${WEBKIT_PATH}"
alias cd403padnufront="cd ${ANDROID403_PAD_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cd403padlib="cd ${ANDROID403_PAD_PATH}/${PAD_LIB_PATH}"
alias cd403padsym="cd ${ANDROID403_PAD_PATH}/${PAD_SYM_PATH}"
alias cd403padchrome="cd ${ANDROID403_PAD_PATH}/external/chrome"

alias cd420pad="cd ${ANDROID420_PAD_PATH}"
alias cd420padwebkit="cd ${ANDROID420_PAD_PATH}/${WEBKIT_PATH}"
alias cd420padnufront="cd ${ANDROID420_PAD_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cd420padlib="cd ${ANDROID420_PAD_PATH}/${PAD_LIB_PATH}"
alias cd420padsym="cd ${ANDROID420_PAD_PATH}/${PAD_SYM_PATH}"

alias cd403="cd ${ANDROID403_PATH}"
alias cd403nufront="cd ${ANDROID403_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cd403webkit="cd ${ANDROID403_PATH}/${WEBKIT_PATH}"
alias cd403img="cd ${ANDROID403_PATH}/${ANDROID_IMG_PATH}"
alias cd403lib="cd ${ANDROID403_PATH}/${ANDROID_LIB_PATH}"
alias cd403sym="cd ${ANDROID403_PATH}/${ANDROID_SYM_PATH}"

alias cd404="cd ${ANDROID404_PATH}"
alias cd404nufront="cd ${ANDROID404_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cd404webkit="cd ${ANDROID404_PATH}/${WEBKIT_PATH}"
alias cd404img="cd ${ANDROID404_PATH}/${ANDROID_IMG_PATH}"
alias cd404lib="cd ${ANDROID404_PATH}/${ANDROID_LIB_PATH}"
alias cd404sym="cd ${ANDROID404_PATH}/${ANDROID_SYM_PATH}"

alias cd410="cd ${ANDROID410_PATH}"
alias cd410nufront="cd ${ANDROID410_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cd410webkit="cd ${ANDROID410_PATH}/${WEBKIT_PATH}"
alias cd410img="cd ${ANDROID410_PATH}/${ANDROID_IMG_PATH}"
alias cd410lib="cd ${ANDROID410_PATH}/${ANDROID_LIB_PATH}"
alias cd410sym="cd ${ANDROID410_PATH}/${ANDROID_SYM_PATH}"

alias cd420="cd ${ANDROID420_PATH}"
alias cd420nufront="cd ${ANDROID420_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cd420webkit="cd ${ANDROID420_PATH}/${WEBKIT_PATH}"
alias cd420img="cd ${ANDROID420_PATH}/${ANDROID_IMG_PATH}"
alias cd420lib="cd ${ANDROID420_PATH}/${ANDROID_LIB_PATH}"
alias cd420sym="cd ${ANDROID420_PATH}/${ANDROID_SYM_PATH}"

# NFS server
alias cdmserver="cd ${NFS_PATH}"
alias cdmtmp="cd ${NFS_PATH}/tmp"

alias cdmandroid="cd ${NFS_ANDROID_PATH}"
alias cdmnufront="cd ${NFS_ANDROID_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cdmwebkit="cd ${NFS_ANDROID_PATH}/${WEBKIT_PATH}"
alias cdmlib="cd ${NFS_ANDROID_PATH}/${NFS_LIB_PATH}"
alias cdmsym="cd ${NFS_ANDROID_PATH}/${NFS_SYM_PATH}"
alias cdmimg="cd ${NFS_ANDROID_PATH}/${NFS_IMG_PATH}"

alias cdmpad="cd ${NFS_PAD_PATH}"
alias cdmpadnufront="cd ${NFS_PAD_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cdmpadwebkit="cd ${NFS_PAD_PATH}/${WEBKIT_PATH}"
alias cdmpadlib="cd ${NFS_PAD_PATH}/${PAD_LIB_PATH}"
alias cdmpadsym="cd ${NFS_PAD_PATH}/${PAD_SYM_PATH}"

alias cdm403pad="cd ${NFS_403PAD_PATH}"
alias cdm403padnufront="cd ${NFS_403PAD_PATH}/${NUFRONT_WEBKIT_PATH}"
alias cdm403padwebkit="cd ${NFS_403PAD_PATH}/${WEBKIT_PATH}"
alias cdm403padlib="cd ${NFS_403PAD_PATH}/${PAD_LIB_PATH}"
alias cdm403padsym="cd ${NFS_403PAD_PATH}/${PAD_SYM_PATH}"

alias cdm420pad="cd ${NFS_420PAD_PATH}"
alias cdm420padlib="cd ${NFS_420PAD_PATH}/${PAD_LIB_PATH}"
alias cdm420padsym="cd ${NFS_420PAD_PATH}/${PAD_SYM_PATH}"
alias cdm420padwebkit="cd ${NFS_420PAD_PATH}/${WEBKIT_PATH}"
alias cdm420padnufront="cd ${NFS_420PAD_PATH}/${NUFRONT_WEBKIT_PATH}"

# SMB server
alias cdsmb="cd ${SMB_PATH}"
alias cdsmbapache="cd ${SMB_PATH}/apache"
alias cdsmbshare="cd ${SMB_PATH}/share"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export USE_CCACHE=1
export CCACHE_DIR=/home/bdg/ccache
export JAVA_HOME=/usr/lib/jvm/jdk1.6.0_31
export JRE_HOME=${JAVA_HOME}/jre
export ANDROID_JAVA_HOME=$JAVA_HOME
export CLASSPATH=.:${JAVA_HOME}/lib:$JRE_HOME/lib:$CLASSPATH
export JAVA_PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin
export JAVA_HOME;
export JRE_HOME;
export CLASSPATH;
HOME_BIN=~/bin/

export ANDROID_PRODUCT_OUT=${ANDROID_PATH}/out/target/product/generic
export ANDROID_SDK_PATH=~/android-sdk-linux
ANDROID_PRODUCT_OUT_BIN=${ANDROID_PATH}/out/host/linux-x86/bin 
ANDROID_GDBCLIENT=${ANDROID_PATH}/prebuilt/linux-x86/toolchain/arm-eabi-4.4.0/bin/arm-eabi-gdb

export  PATH=$PATH:/home/bdg/bin:$QTDIR/bin:$JAVA_HOME/bin:${ANDROID_GDBCLIENT}:${ANDROID_PRODUCT_OUT_BIN}:${ANDROID_PRODUCT_OUT}:${ECLIPSE_PATH}
export  PATH+=$PATH:${ANDROID_SDK_PATH}/platform-tools:${ANDROID_SDK_PATH}/tools
export PATH+=$PATH:/opt/qq2011/bin


#for qt webkit build
#export  QTDIR=/home/bdg/other_browser/qt/qt-everywhere-opensource-src-4.8.0/inst
#export  PATH=$QTDIR/bin:/usr/bin:$PATH
#export  MANPATH=$QTDIR/man:$MANPATH
#export  LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH

export  QTDIR=/home/bdg/other_browser/qt/qt-everywhere-opensource-src-5.0.0-beta2/inst
export  PATH=$QTDIR/bin:/usr/bin:$PATH
export  MANPATH=$QTDIR/man:$MANPATH
export  LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
