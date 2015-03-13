# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples



################################
##==--~~ STANDARD STUFF ~~--==##
################################



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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

# In interactive shells, you cannot use ! inside strings
#  because that triggers a csh-style history expansion.
#  The most common place where I run into this is in git commit messages
#  where $ git commit -m "Fixed bug!"
#  leads to the error - bash: !": event not found
# To fix this, we disable histexpand which I never use annyways.
set +o histexpand


###############################
##==--~~ ENV VARIABLES ~~--==##
###############################


# Modified path
# Added Haskell PPA paths
export PATH=$HOME/bin:./.cabal-sandbox/bin:$HOME/.cabal/bin:/opt/ghc/7.8.3/bin:/opt/alex/3.1.3/bin:/opt/happy/1.19.4/bin:/opt/cabal/1.20/bin:$PATH

# Add android SDK to path
export PATH=$HOME/progs/android-sdk-linux/platform-tools:$HOME/progs/android-sdk-linux/tools:$PATH

# Set a 256 color terminal
# Needed for vim and tmux
if [ -n "$TMUX" ]; then
  # Tmux really, really, wants screen-256color
  export TERM=screen-256color
else
  export TERM=xterm-256color
fi


##################################
##==--~~ VIM MODE IN BASH ~~--==##
##################################


# Change BASH editing style to VIM mode (instead of the default emacs mode)
set -o vi

# Bugfix for GVim launching without a global menu (when launched from a shell)
# Taken from http://askubuntu.com/questions/132977/how-to-get-global-application-menu-for-gvim
# function gvim () { (/usr/bin/gvim -f "$@" &) }

# clear the screen with control-L, as defined in emacs editing mode
bind -m vi-insert "\C-l":clear-screen

# Some other tab completion shortcuts from (http://www.jukie.net/bart/blog/20040326082602)
# ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history
# ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete

# Added aliases to switch to emacs/vim modes
alias govi="set -o vi"
alias goemacs="set -o emacs"





############################
##==--~~ MY ALIASES ~~--==##
############################


# Add a pretty print json command
# It reads json from stdin and pretty prints the output on stdout
# Taken from http://ruslanspivak.com/2010/10/12/pretty-print-json-from-the-command-line/
alias pp='python -mjson.tool'

# Generate ctags for haskell code using the inbuilt features in recent ghcs
# Earlier this was done through the hasktags executable
# Usage: hasktags Main.hs
alias hasktags='ghc -e :ctags'

# Command to start a simple ad-hoc webserver in the current directory
# Great for testing out stuff that cannot be run from file:// urls due to browser security restrictions
alias server='python -m SimpleHTTPServer'

# Command to get application which is using a particular port
# Use it like `port 3000`
alias port='sudo netstat -lpn | grep'

# Less should accept color from commands
alias less='less -R'

# Remove color codes (special characters) with sed
alias nocolor='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

# Activate a hsenv environment
# Parallel to using deactivate_hsenv
alias activate_hsenv='source ./.hsenv/bin/activate'

# List all Haskell packages which can be upgraded
alias cabalupgrades="cabal list --installed | egrep -iv '(synopsis|homepage|license)'"

# Ack should always use a pager
alias ack="ack-grep --pager=\"less -R\""

# Ag (a.k.a. the Silver Surfer) should always use a pager
alias ag="ag --pager=\"less -R\""

# Wget as a spider
# See - http://blog.syntaxvssemantics.com/2010/08/wget-as-spidercrawler-recursively.html
alias spider="wget -r -np -p -k"

# Ack should always use a pager
# alias ack="ack-grep --pager=\"less -R\""

# Quickly go up a directory - upto 6 levels up
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."


##############################
##==--~~ MY FUNCTIONS ~~--==##
##############################

# les = less + ls
# If the arg is a dir then run ls
# else display the file using less
function les() {
  if [ -d $1 ]; then
    ls -al $1
  else
    less $1
  fi
}

# Simple script to quickly update all git and svn repos in the current directory
function updateRepos() {
  # Update Git Repos
  for i in `find . -name \.git | awk -F "/" '{print $2}'`; do
    echo "cd $i"
    cd $i
    # Detect git svn repos and handle them differently
    # http://stackoverflow.com/a/9086279/348716
    if [ -d .git/svn ] && [ x != x"$(ls -A .git/svn/)" ] && echo Looks like a git svn repo; then
      echo "git svn rebase"
      git svn rebase
    else
      echo "git pull"
      git pull
    fi
    echo "cd .."
    cd ..
    echo "Done"
  done
  # Update SVN Repos
  for i in `find ./* -name \.svn | awk -F "/" '{print $2}'`; do
    echo "cd $i"
    cd $i
    echo "svn update"
    svn update
    echo "cd .."
    cd ..
    echo "Done"
  done
}

# Simple function to run FAY compiler and the other needed operations
# This function does the following -
#   - Run GHC for typechecking
#   - Run Fay for actual compilation to JS
#   - Also generate a beautified file by running jsbeautify
#   - Remove temporary files
#
# TODO: This function is kind of ugly. Fix!
function fayme() {
  unset noerror; unset hsfilename; unset jsfilename; unset tempfilename; unset dirname; unset extension; unset filename

  noerror=0
  while [ 1 ]; do
    if [ $# -gt 0 ]; then
      hsfilename=$1
      extension="${hsfilename##*.}"
      # if filename == extension then there IS NO extension
      if [ $extension == $hsfilename ]; then
        extension="hs"
        hsfilename="${hsfilename}.hs"
      fi
      if [ -e $hsfilename ]; then
        if [ $extension == "hs" ]; then
          dirname=$(dirname $hsfilename)
          filename="${hsfilename%.*}"
          jsfilename="${filename}.js"
          tempfilename="${filename}BAK.js"
          echo "Running GHC"
          ghc $hsfilename || break
          echo "Running Fay"
          fay --autorun $hsfilename || break
          echo "Un-minifying js"
          mv $jsfilename $tempfilename || break
          js_beautify $tempfilename > $jsfilename || break
          echo "Cleaning up"
          if [ -z $dirname ]; then
            dirname="."
          fi
          rm $dirname/*.o $dirname/*.hi $tempfilename || break
          noerror=1
        fi
      fi
    fi
    # Only execute loop once
    break
  done

  if [ $noerror -eq 0 ]; then
    echo "fayme: Run Fay compiler and other needed operations on a Haskell source file"
    echo "Usage: fayme filename"
    echo "  where filename = path/to/Foo.hs"
    echo "     OR filename = path/to/Foo"
  fi

  unset noerror; unset hsfilename; unset jsfilename; unset tempfilename; unset dirname; unset extension; unset filename
}

# Replace strings across files
# Internally uses perl -pi -e
# Usage:
#   searchReplace <search> <replacement> <files>
function searchReplace() {
  unset s; unset r; unset l;
  if [ $# -gt 2 ]; then
    s=$1
    r=$2
    l=$3
    echo "perl -pi -e \"s/$s/$r/g\" $l"
    perl -pi -e "s/$s/$r/g" $l
  fi
}


# Bunch of functions to quickly rename multiple files
# By either replacing a prefix or suffix pattern
# You specify the filename pattern in the following way
#   renamePrefix <search> [<replacement>]
#   renameSuffix <search> [<replacement>]
function renamePrefix() {
  unset s; unset r
  if [ $# -gt 0 ]; then
    s=$1
    r=$2
    for f in $s*; do
      echo "mv \"$f\" \"$r${f#$s}\""
      mv "$f" "$r${f#$s}"
    done
    unset s; unset r
  fi
}

function renameSuffix() {
  unset s; unset r
  if [ $# -gt 0 ]; then
    s=$1
    r=$2
    for f in *$s; do
      echo "mv \"$f\" \"${f%$s}$r\""
      mv "$f" "${f%$s}$r"
    done
    unset s; unset r
  fi
}

# A wrapper over grep to perform a nested search for a phrase in the current dir
function grepcr() {
  unset a
  if [ $# -gt 0 ]; then
    a=$1
    shift
  fi
  sp=" "
  while [ $# -gt 0 ]; do
    a=$a$sp$1
    shift
  done
  echo "grep --color=always -ri \"$a\" . | less -R"
  grep -ri --color=always "$a" . | less -R
  unset a
}

##############################################################################
# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
    for p in `ghc-pkg check $* 2>&1 | grep problems | awk '{print $6}' | sed -e 's/:$//'`
    do
echo unregistering $p; ghc-pkg $* unregister $p
    done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.
# When all else fails, use this to get out of dependency hell and start over.
function ghc-pkg-reset() {
    read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
    test x$ans == xy && ( \
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
        # echo 'erasing ~/.cabal/packages'; rm -rf ~/.cabal/packages; \
        # echo 'erasing ~/.cabal/share'; rm -rf ~/.cabal/share; \
        )
}

# Genie
# Examples -
#   genie where am i
#   genie what is a corn dog
function genie(){
  query=`printf "%s+" $@`
  result=`curl -s "https://weannie.pannous.com/api?out=simple&input=$query"`
  echo $result
  # say $result 2>/dev/null
}


# Enable/Disable openssh server
alias enablessh='sudo mv /etc/init/ssh.conf.disabled /etc/init/ssh.conf && sudo start ssh'
alias disablessh='sudo stop ssh && sudo mv /etc/init/ssh.conf /etc/init/ssh.conf.disabled'


###################################
##==--~~ FANCY BASH PROMPT ~~--==##
###################################
# Shows helpful git info
. ~/.bash/vendor/git-prompt/git-prompt.sh

