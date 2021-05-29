# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ld='ls -l'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[[ -s /home/carson/.autojump/etc/profile.d/autojump.sh ]] && source /home/carson/.autojump/etc/profile.d/autojump.sh

export PATH=$PATH:/your_stm_gcc_dir/gcc-arm-none-eabi-4_8-2013q4/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/home/carson/synopsys/synopsys_install/installer"
export PATH="$PATH:/opt/xtensa-esp32-elf/bin"

# openc connect stm32f4x
alias link_f4x='openocd -f interface/stlink-v2.cfg -f target/stm32f4x.cfg -c init -c "reset halt"'
alias link_f1x='openocd -f interface/stlink-v2.cfg -f target/stm32f1x.cfg -c init -c "reset halt"'
alias link_gd_f1='~/.openocd/openocd/bin/openocd -f ~/.openocd/openocd_gd32vf103.cfg'
alias link_fpga='~/.openocd/openocd/bin/openocd -f ~/.openocd/fpga.cfg'
alias link_hbird='~/.openocd/openocd/bin/openocd -f ~/.openocd/openocd_hbirdv2.cfg'

alias ptag='find . -name \*.py -print |xargs /usr/bin/ptags.py'
alias ctag='ctags -R --C-kinds=+p --fields=+aS --extra=+q'
alias vpn='proxychains4'
alias scf='find ./ -name $1'
alias scc='grep -rn $1'
alias pwc='pwd|tr -d "\r\n"|xsel -b'

alias env_vivado='source /tools/Xilinx/Vivado/2019.1/settings64.sh'

# python version
alias get_py='sudo update-alternatives --config python'

# register search.
export REG_SEARCH_BIN="/home/carson/Desktop/python/codewarrior/example/register_search.py"
export REG_SRC_PATH='/home/carson/Desktop/python/codewarrior/table/regmap.yaml'
export REG_TOP_PATH='/home/carson/Desktop/python/codewarrior/table/regmapper.yaml'

alias sc='register_search(){ python $REG_SEARCH_BIN $REG_SRC_PATH $REG_TOP_PATH $*;};register_search'

#export TERM=linux
export TERMINFO=/etc/terminfo

#进制python 生成 '__pycache__'
export PYTHONDONTWRITEBYTECODE=1

# vcs verdi
#dve
export PATH=$PATH:/home/carson/SoftWare/synopsys/vcs-L-2016.06/gui/dve/bin
alias dve="dve -full64"

#vcs
export PATH=$PATH:/home/carson/SoftWare/synopsys/vcs-L-2016.06/bin
alias vcs="vcs -full64 -cpp g++-4.8.5 -cc gcc-4.8.5 -LDFLAGS -Wl,--no-as-needed"

#verdi
export PATH=$PATH:/home/carson/SoftWare/synopsys/Verdi3_L-2016.06-1/bin
export VCS_HOME=/home/carson/SoftWare/synopsys/vcs-L-2016.06
export VERDI_HOME=/home/carson/SoftWare/synopsys/Verdi3_L-2016.06-1
export NOVAS_HOME=/home/carson/SoftWare/synopsys/Verdi3_L-2016.06-1

#licence
export LM_LICENSE_FILE=27000@ubuntu
alias lmg_vcs="lmgrd -c /home/carson/SoftWare/synopsys/vcs-L-2016.06/license/Synopsys.dat"

#scl
export PATH=$PATH:/home/carson/SoftWare/synopsys/11.9/amd64/bin
export VCS_ARCH_OVERRIDE=linux

#qt
export QTDIR=/opt/Qt5.12.3/5.12.3/gcc_64/
export PKG_CONFIG_PATH=$QTDIR/lib/pkgconfig
export PATH=$QTDIR/bin:$PATH
export LD_LIBRARY_PATH=$QTDIR/lib
