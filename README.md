# Linux-workshop

- [Goals](#goals)
  - [Why Debian?](#why-debian)
  - [Why Ansible?](#why-ansible)
- [Requirements](#requirements)
  - [Operating System](#operating-system)
  - [Chocolatey](#chocolatey)
  - [Virtual Box](#virtual-box)
- [Setup](#setup)
  - [VM Setup](#vm-setup)
  - [System Upgrade](#system-upgrade)

## Table of Contents
- [Part 1 - SHELL](#part-1-shell)
  - [Learning the Shell](#learning-the-shell)
    - [Terminal](#terminal)
    - [History](#history)
  - [Navigation](#navigation)
    - [File system tree](#file-system-tree)
    - [Pathnames](#pathnames)
  - [Exploring the system](#exploring-the-system)
    - [Less is more](#less-is-more)
    - [Links](#links)
  - [Commands](#commands)
    - [Identifying commands](#identifying-commands)
    - [Redirection and pipes](#redirection-and-pipes)
    - [Expansion & quoting](#expansion-and-quoting)
  - [Permissions](#permissions)
    - [Owners, groups & others](#owners-groups-and-others)
    - [RWX, identities](#rwx-identities)
  - [Processes](#processes)
    - [How a process works](#how-a-process-works)
    - [Sockets and signals](#sockets-and-signals)
    - [Unit files](#unit-files)
    - [Process spawning](#process-spawning)
    - [Headers](#headers)
    - [Accessing system resources](#accessing-system-resources)
    - [Inter-process communication](#inter-process-communication)
- [Part 2 - Configuration & Environment](#part-2-configuration-and-environment)
  - [Environment](#environment)
    - [What, how and why](#what-how-and-why)
    - [Files and text editors](#files-and-text-editors)
  - [Introduction to Vi/VIm](#introduction-to-vi)
    - [Editing Modes](#editing-modes)
    - [Movement](#movement)
    - [Search and replace](#search-and-replace)
    - [Editing multiple files](#editing-multiple-files)
    - [Customizing VIM](#customizing-vim)
    - [Tips & Tricks](#tips-and-tricks)
  - [Prompt](#prompt)
    - [Customizing bashrc](#customizing-bashrc)
    - [Build logic in your configs](#build-logic-in-your-configs)
  - [LSOF and PS](#lsof-and-ps)
- [Part 3 - Common tasks and tools](#part-3-common-tasks-and-tools)
  - [Package Managers](#package-managers)
    - [Common tasks](#common-tasks)
  - [Searching for files](#searching-for-files)
    - [Locate & find](#locate-and-find)
    - [xargs](#xargs)
  - [Networking](#networking)
    - [Ping, traceroute, netstat](#ping-traceroute-netstat)
    - [SFTP, wget](#sftp-wget)
    - [SSH](#ssh)
    - [NFS](#nfs)
    - [tcpdump](#tcpdump)
  - [Archiving and backup](#archiving-and-backup)
    - [gzip](#gzip)
    - [tar](#tar)
    - [zip](#zip)
    - [File synchronization](#file-synchronization)
  - [Regular Expressions](#regular-expressions)
    - [grep](#grep)
    - [Logic, any and negation](#logic-any-and-negation)
    - [Quantifiers](#quantifiers)
    - [find, locate and less](#find-locate-and-less)
  - [Text processing](#text-processing)
    - [cat, sort and uniq](#cat-sort-uniq)
    - [cut, paste and join](#cut-paste-join)
    - [diff and sed](#diff-and-sed)
- [Part 4 - Shell scripts](#part-4-shell-scripts)
  - [Format](#format)
  - [Indentation](#indentation)
  - [Keep scripts running](#keep-scripts-running)
  - [VIm for scripting ](#vim-for-scripting)
  - [Shell scripts in .bashrc](#shell-scripts-in-bashrc)
  - [If tests and parantheses](#if-tests-and-parantheses)
  - [Read IFS](#read-ifs)
  - [Loops and breaks](#loops-and-breaks)
  - [Strings and numbers](#strings-and-numbers)
  - [Troubleshooting](#troubleshooting)
  - [Patterns with case](#patterns-with-case)
  - [Arrays](#arrays)
    - [Creating, assigning and accessing values](#creating-assigning-and-accessing-values)
    - [Array operations](#array-operations)
- [Resources](#resources)


## Goals

Provide entry-level presentation to Linux via `Debian`, set up an environment
and go over common administration tasks.

### Why Debian?
Debian is the distribution Ubuntu is based on, it has the same package manager
as well - There are many Linux distributions out there, I just happen to enjoy
Debian more.

### Why Ansible

Ansible replicates what we'd use in a work environment to deploy IaC
(infrastructure as code). Put simply, it allows us to automate the installation
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

### [Chocolatey](https://chocolatey.org/install)

Here's a package manager for Windows, if you weren't aware there was one. Gone are
the days of manually searching the web for executables to install your favorite software.

### [Virtual Box](https://www.virtualbox.org/wiki/Downloads)

Simple [Tier 2 hypervisor](https://en.wikipedia.org/wiki/Hypervisor) that we can use.
Explaining virtualization and the differencebetween Tier 1 and 2 hypervisors is
outside the scope of this workshop - To put it simply, you can run a virtual system
on your physical one. This brings security and convenience in certain scenarios.

### VM Setup

Create a virtual machine with two CPU cores, 2048 MB of RAM, a 16GB OS disk and one 16GB data
disk. Mount the downloaded Debian iso you've downloaded as the virtual disk drive. Install the OS.

### System Upgrade

Verify that your `Debian` installation is up to date.

```
sudo apt-get update
sudo apt-get upgrade
```

> NOTE: This will take some time.

## Part 1 - SHELL

### Learning the Shell

#### Terminal

#### History

### Navigation

#### File system tree

#### Pathnames

### Exploring the system

#### Less is more

#### Links

### Commands

#### Identifying commands

#### Redirection and pipes

### Permissions

#### Owners, groups & others

#### RWX, identities

### Processes

#### How a process works

#### Sockets and signals

#### Unit files

#### Process spawning

#### Headers

#### Accessing system resources

#### Inter-process communication

## Part 2 - Configuration & Environment

Why set up an environment? 

### Environment

#### What, how and why

#### Files and text editors

### Introduction to Vi/VIm

#### Editing Modes

#### Movement

#### Search and replace

#### Editing multiple files

#### Customizing VIM

```vim
" We use this check because Some distributions come by default with vim-tiny,
"  a stripped down version of VIm.
if has("eval")
  let skip_defaults_vim = 1
endif

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

" > NOTE: Like in bash scripts, we can write logic into the
"          .vimrc and vimscript in general
if v:version >= 800
  " stop vim from silently messing with files that it shouldn't mess with
  set nofixedofline
endif
```

#### Tips & Tricks

### Prompt

#### Customizing bashrc

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
# --------------------------- bash config END ------------------------
```

#### Build logic in your configs

## Part 3 - Common tasks and tools

### Package Managers

#### Common tasks

### Searching for files

#### Locate & find

#### xargs

### Networking

#### Ping, traceroute, netstat

#### SFTP, wget

#### SSH

#### NFS

#### tcpdump

### Archiving and backup

#### gzip

#### tar

#### zip

#### File synchronization

### Regular Expressions

#### grep

#### Logic, any and negation

#### Quantifiers

#### find, locate and less

### Text processing

#### cat, sort and uniq

#### cut, paste and join

#### diff and sed

## Part 4 - Shell scripts

### Format

### Indentation

### Keep scripts running

### VIm for scripting

### Shell scripts in .bashrc

### If tests and parantheses

### Read IFS

### Loops and breaks

### Strings and numbers

### Troubleshooting

### Patterns with case

### Arrays

#### Creating, assigning and accessing values

#### Array operations

## Resources

[The Linux Command Line](https://www.linuxcommand.org/tlcl.php) ([Download](https://sourceforge.net/projects/linuxcommand/files/TLCL/19.01/TLCL-19.01.pdf/download)) & Adventures with the Linux Command Line ([Download](https://sourceforge.net/projects/linuxcommand/files/AWTLCL/21.10/AWTLCL-21.10.pdf/download)) are free books in PDF format, released under the Creative Commons [license](https://creativecommons.org/licenses/by-nc-nd/3.0/).


# ######################################################################################
## Itinerary
* Debian ISO DL & VirtualBox Install
* Presentation ( self and students )
* System update, install Ansible, DL & run ansible playbook
* $mainStructure
* Intro to BASH scripting, CLI variables pushd & dirs -v

## TODO:
* Write Ansible playbook to:
  - update system
  - set up various users, their home directories, different Shells
  - create directories for future NFS shares
  - install NFS server
* Add couple of notes from https://danielmiessler.com/study/tcpdump/ to tcpdump section
* Add homework to each chapter
# ######################################################################################
