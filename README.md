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
    - [Expansion and quoting](#expansion-and-quoting)
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
    - [Tips & Tricks](#tips-&-tricks)
  - [Prompt](#prompt)
    - [Customizing bashrc](#customizing-bashrc)
    - [Build logic in your configs](#build-logic-in-your-configs)
  - [LSOF and PS](#lsof-and-ps)
- [Part 3 - Common tasks and tools](#part-3-common-tasks-and-tools)
  - [Package Managers](#package-managers)
    - [Common tasks](#common-tasks)
  - [Searching for files](#searching-for-files)
    - [Locate & find](#locate-&-find)
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

Command line, shell, same thing. Think of it as a program that takes keyboard
commands and sends them over to the OS to run.

```bash
[user@hostname ~]$
[user@hostname ~]#
``` 

> NOTE: The pound sign instead of the dollar sign shows that you're logged in as root

#### History

history - prints list of commands run previously by the user

### Navigation

pwd - print name of current working directory

cd - change directory

ls - list directory contents

#### File system tree

Like Windows and Unix, Linux organizez files in a hierarchical directory structure. Think of a tree
that starts with the root directory. It contains files and subdirectories, which in turn contain more
files and subdirectories.

#### Pathnames

Absolute or relative

Absolute pathnames begin with the root directory and follows the tree branch by branch until the path
to the desired directory or file is completed.

```bash
[user@hostname ~]$ cd /usr/bin
[user@hostname bin]$ pwd
/usr/bin
[user@hostname bin]$ ls
# listing of files
```

> NOTE: See that by changing the directory to /usr/bin the shell prompt changed? It displays the name of the working directory by default.

Relative pathnames start from the working directory using special characters.

"." - refers to the working directory <br />
".." - refers to the working directory's parent directory

Here's an example:

```bash
[user@hostname ~]$ cd /usr/bin
[user@hostname bin]$ pwd
/usr/bin
[user@hostname bin]$ cd /usr
[user@hostname usr]$ pwd
/usr
[user@hostname bin]$ cd ..
[user@hostname usr]$ pwd
/usr
[user@hostname bin]$ cd ~
[user@hostname ~]$ pwd
/home/user
```

> NOTE: Two different methods with identical results. Which one should you use? The one that requires the least typing.

"~", "~user", "cd" - they all change the working directory to your home directory <br />
"cd -" - changes the working directory to the previous working directory

### Exploring the system

ls - list directory contents

file - determine file type

less - view file contents

tree - prints a tree-like structure of the directory

#### Less is more

The "less" program was designed as an improved replacement of an older program called "more". It's name is a play on
the phrase "less is more". It allows easier viewing of long text documents in a page by page manner, both forward and
backward.

#### Links

As you look around you'll find files and directories that point to others. This is a special kind of file called a
symbolic link (also known as soft link or symlink), a very useful feature.

Picture a program that requires the use of a shared resource of some kind, contained in a file called "foo", but "foo"
has frequent version changes. You could include the version number in the filename but this presents a problem, if you
change the name you have to track down every program that might use it and change it to look for a new resource name
every time a new version gets installed.

There are also hard links, these allow files to have multiple names, but they do it differently. Here are two important
limitations that they have:
* it can't reference a file outside its own filesystem, so it can't reference a file that is not on the same partition
* it can't reference a directory

```bash
[user@hostname ~]$ ls -lahi /lib
lrwxrwxrwx 1 root root 7 Dec 7 2022 /lib -> /usr/lib
```

```bash
[me@hostname ~]$ ln file file-hard
[me@hostname ~]$ ln -s file file-sym
[me@hostname ~]$ ls
file file-hard file-sym
```

### Commands

Commands can be executables written in various programming languages and compiled, shell builtins (e.g. cd), shell 
functions and aliases.

type - indicate how a command is interpreted

which - display which executable will be run

help - get help for shell builtins

man - display a command's manual page

apropos - display a list of appropriate commands

info - display a command's info entry

alias - create an alias for a command

whatis - display one-liner manual page descriptions

#### Identifying commands

type - display a command's type

```bash
[me@hostname ~]$ type type
type is a shell builtin
[me@hostname ~]$ type ls
ls is aliased to `ls --color=tty`
[me@hostname ~]$ type cp
cp is /bin/cp
```

```bash
[me@hostname ~]$ apropos partition
addpart (8) - simple wrapper around the "add partition"...
all-swaps (7) - event signalling that all swap partitions...
cfdisk (8) - display or manipulate disk partition table
cgdisk (8) - Curses-based GUID partition table (GPT)...
delpart (8) - simple wrapper around the "del partition"...
fdisk (8) - manipulate disk partition table
fixparts (8) - MBR partition table repair utility
```

> NOTE: Special mention should be made to the most brutal man page of them all, the one for "bash".

#### Redirection and pipes

One of the coolest features of the command line, I/O redirection. "I/O" stands for input/output and
it allows us to redirect the input and output of commands to and from files, as well as connect mul-
tiple commands together.

cat - concatenate files

sort - sort lines of text

uniq - report or omit repeated lines

grep - print lines matching a pattern

wc - print newline, word and byte counts for each file

head - output the first part of a file

tail - output the last part of a file

tee - read from standard input and write to standard output and files

Standard input, output and error; many commands produce output of some kind, usually of two types:
* the program's result; the data it's designed to produce
* status and error messages that tell us how the program is doing

I/O redirection allows us to redefine where the standard output goes using redirectors such as ">".

```bash
[me@hostname ~]$ ls -l /usr/bin > ls-output.txt
[me@hostname ~]$ ls -l /bin/usr > ls-output.txt
```

Redirecting standard error lacks the ease of a dedicated operator. To redirect STDERR we must refer to
its file descriptor. A program can produce output on any of several numbered file streams. While we
have referred to the first three of these file streams as standard input, output and error, the shell
references them internally as file descriptors 0, 1 and 2 respectively.

```bash
[me@hostname ~]$ ls -l /bin/usr 2> ls-error.txt
[me@hostname ~]$ ls -l /bin/usr > ls-output.txt 2>&1
[me@hostname ~]$ ls -l /bin/usr 2> /dev/null
```

> NOTE: /dev/null in Unix culture is called the bit bucket.

```bash
[me@hostname ~]$ cat movie.mpeg.0* > movie.mpeg
[me@hostname ~]$ cat
```

> NOTE: if run without arguments, the "cat" command does exactly what it should, it reads from STDIN (the
keyboard in this case) and it waits for you to press Enter. Try it.

Pipelines allow reading data from STDIN and sending it to STDOUT via the pipe "|" operator (vertical bar).

```bash
command1 | command2
[me@hostname ~]$ ls -l /usr/bin | less
```

">" - redirection operator, connects a command with a file  <br />
"|" - pipeline operator, connects the output of one command with the input of a second command

> NOTE: By misusing the redirection operator (e.g. "command1 > command2") you can get some really bad outcomes.

#### Expansion and quoting

Each time you type and run a command, bash performs several substitutions on the text before it carries out the
command.

```bash
[me@hostname ~]$ echo this is a test
this is a test

[me@hostname ~]$ echo *
Desktop Documents ls-output.txt Music Pictures Public Templates
```

echo - display a line of text

echo D*                                   <br />
echo *s                                   <br />
echo [[:upper:]]*                         <br />
echo /usr/*/share                         <br />
echo ~                                    <br />
echo $((2+2))                             <br />
echo $(($(5**2))*3                        <br />
echo Five divided by two equals $((5/2))  <br />
echo with $((5%2)) left over.             <br />

```bash
[me@hostname ~]$ cd Photos
[me@hostname Photos]$ mkdir {2007..2009}-{01..12}
[me@hostname Photos]$ ls
2007-01 2007-07 2008-01 2008-07 2009-01 2009-07
2007-02 2007-08 2008-02 2008-08 2009-02 2009-08
2007-03 2007-09 2008-03 2008-09 2009-03 2009-09
2007-04 2007-10 2008-04 2008-10 2009-04 2009-10
2007-05 2007-11 2008-05 2008-11 2009-05 2009-11
2007-06 2007-12 2008-06 2008-12 2009-06 2009-12
```

echo $USER  <br />
echo $(ls)  <br />
ls -l $(which cp) <br />

file $(ls -d /usr/bin/* | grep zip)

Now that you've seen expansions, how about we control them?

```bash
[me@hostname ~]$ echo this is a     test
this is a test

[me@linuxbox ~]$ echo The total is $100.00
The total is 00.00

[me@linuxbox ~]$ echo The total is \$100.00
The total is $100.00
```

Escape characters:

"\a" - bell <br />
"\b" - backspace  <br />
"\n" - newline  <br />
"\r" - carriage return  <br />
"\t" - tab

sleep 10; echo "Time's up" $'\a'

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
