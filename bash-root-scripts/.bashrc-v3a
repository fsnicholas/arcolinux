# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# FSN v3 - 2020-June-14
# FSN v3a - 2020-June-25
# 

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
[[ $- != *i* ]] && return

# All these has to be in this order
# See http://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history/18443#18443
# Ignore duplicates, ls without options and builtin commands
# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="&:ls:ll:[bf]g:exit:reboot"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# Save and reload the history after each command finishes
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Combine multiline commands into one in history
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s dotglob
shopt -s expand_aliases # expand aliases

# Locale and editor
export EDITOR=nano

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R'


# colour manpages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w >\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w > '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1=${PS1%?}
    PS1=${PS1%?}\n'\[\033[01;34m\]$ \[\033[00m\]'
#    PS1=${PS1%?}\n'$ '
    ;;
*)
    ;;
esac


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.bin" ] ;
	then PATH="$HOME/.bin:$PATH"
fi

# Added 2020-06-25
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

## FSN some functions to manage history
## https://stackoverflow.com/questions/338285/prevent-duplicates-from-being-saved-in-bash-history


# remove duplicates while preserving input order
function dedup {
   awk '! x[$0]++' $@
}

# removes $HISTIGNORE commands from input
function remove_histignore {
   if [ -n "$HISTIGNORE" ]; then
      # replace : with |, then * with .*
      local IGNORE_PAT=`echo "$HISTIGNORE" | sed s/\:/\|/g | sed s/\*/\.\*/g`
      # negated grep removes matches
      grep -vx "$IGNORE_PAT" $@
   else
      cat $@
   fi
}

# clean up the history file by remove duplicates and commands matching
# $HISTIGNORE entries
function history_cleanup {
   local HISTFILE_SRC=~/.bash_history
   local HISTFILE_DST=/tmp/.$USER.bash_history.clean
   if [ -f $HISTFILE_SRC ]; then
      \cp $HISTFILE_SRC $HISTFILE_SRC.backup
      dedup $HISTFILE_SRC | remove_histignore >| $HISTFILE_DST
      \mv $HISTFILE_DST $HISTFILE_SRC
      chmod go-r $HISTFILE_SRC
      history -c
      history -r
   fi
}

umask 0002

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).


# Compress history, removing any duplicate lines except the most recent one.
tempfile="$(mktemp)"
awk 'NR==FNR && !/^#/{lines[$0]=FNR;next} lines[$0]==FNR' "$HISTFILE" "$HISTFILE" > "$tempfile" && mv -f "$tempfile" "$HISTFILE"
unset tempfile

# Reload history.
history -c ; history -r

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nicholas/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nicholas/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nicholas/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nicholas/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

neofetch
