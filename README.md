# Linux-workshop

## Table of Contents
- [Goals](#goals)
  - [Why Debian?](#why-debian)
  - [Why Ansible?](#why-ansible)
- [Requirements](#requirements)
  - [Operating System](#operating-system)
  - [Chocolatey](#chocolatey)
  - [Virtual Box](#virtual-box)
  - [VM Setup](#vm-setup)
  - [System Upgrade](#system-upgrade)
- [Setup](#setup)
  - [Environment](#environment)
    - [.bashrc](#bashrc)
    - [.vimrc](#vimrc)
  - [SSH Keys](#ssh-keys)
  - 

## Goals

Provide entry-level presentation to `Debian`, set up an environment and show
example administration tasks.

### Why Debian?
Debian is the distribution Ubuntu is based on, it has the same package manager
as well - There are many Linux distributions out there, I just happen to enjoy
Debian more.

### Why Ansible

Ansible replicates what we'd use in a work environment to deploy IaC
( infrastructure as code ). Put simply, it allows us to automate the installation
of software and administer servers. And what better way to show the power of auto-
mation than deploy the workshop setup itself?

## Requirements

### Operating system

This workshop is designed around Debian and other distributions that use the apt
( aptitude ) package manager. 

```
wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-XX.Y.Z-amd64.netinst.iso
```

> NOTE: Check `https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/` for the
latest version.

### Chocolatey

Here's a package manager for Windows, if you weren't aware there was one. Gone are
the days of manually searching the web for executables to install your favorite software.

### Virtual Box

Simple [Tier 2 hypervisor](https://en.wikipedia.org/wiki/Hypervisor) that we can use.
Explaining virtualization and the differencebetween Tier 1 and 2 hypervisors is
outside the scope of this workshop - To put it simply, you can run a virtual system
on your physical one. This brings security and convenience in certain scenarios.

### VM Setup

> TODO:


### System Upgrade

Verify that your `Debian` installation is up to date.

```
sudo apt-get update
sudo apt-get upgrade
```

> NOTE: This will take some time.

## Setup

### Environment

Why set up an environment? 

#### .bashrc

```bash
#!/bin/bash
# > NOTE: The first commented line above is called a shebang, it
#          declares the file content type.
# --------------------------- bash config BEG-------------------------
#

# --------------------------- dir colors-- ---------------------------
#
if _have dircolors; then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi

# --------------------------- smart prompt ---------------------------
# Courtesy of [rwxrob](https://github.com/rwxrob/dot)
# > NOTE: Ignore this for now, just enjoy the nice Bash prompt

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B == master || $B == main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
  double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

# --------------------------- env variables --------------------------
# > NOTE: We're exporting variables that the CLI will recognize.

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000
export TERM=xterm-256color
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

unalias -a  # > NOTE: Care to guess why we're doing this?
alias ls='ls -h --color=auto'
alias clear='printf "\e[H\e[2J"'
alias dot='cd $DOTFILES'
alias ls='ls -h --color=auto'
alias diff='diff --color'

#
# --------------------------- bash prompt END ------------------------

```

#### .vimrc

```vim
" We use this check because Some distributions come by default with vim-tiny,
"  a stripped down version of VIm.
if has("eval")
  let skip_defaults_vim = 1

" automatically indent new lines
set autoindent
" automatically write files when changing between files - Autosave
set autowrite
" turn col and row positions on in bottom right section
set ruler
" show command and insert mode
set showmode
" set tab value
set tabstop=2
set smartindent
set textwidth=72
" disable relative line numbers, comment to sample it
set norelativenumber
" highlight search hits
set hlsearch
set incsearch
set linebreak
" stop complaints about switching buffers with unsaved changes
set hidden
" set command history
set history=1000
" enable faster scrolling
set ttyfast
" allows Vim to sense filetype
set filetype plugin on
set background=dark

if v:version >= 800
  " > NOTE: As in bash scripts, we can write logic into the
  "          .vimrc and vimscript in general
  
  " stop vim from silently messing with files that it shouldn't mess with
  set nofixedofline
endif
```

### SSH Keys

```
ssh-keygen -t rsa -b 4096
```



##Itinerary
* Presentation ( self and students )
* Debian ISO DL \& VirtualBox Install ( via chocolatey (?))
* System update, install Ansible, DL & run ansible playbook
* $mainStructure
* Intro to BASH scripting, CLI variables pushd & dirs -v

##TODO:
* Write Ansible playbook to:
  - update system
  - set up various users, their home directories, different Shells
  - create directories for future NFS shares
  - install NFS server
*
