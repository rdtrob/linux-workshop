# Linux-workshop

- [Goals](#goals)
  - [Why Debian?](#why-debian)
- [Requirements](#requirements)
  - [Operating System](#operating-system)
  - [Chocolatey](#chocolatey)
  - [Virtual Box](#virtual-box)
- [Setup](#setup)
  - [VM Setup](#vm-setup)
  - [System Upgrade](#system-upgrade)

## Table of Contents
- [Part 1 - SHELL](#part-1---shell)
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
  - [Processes](#processes)
    - [How a process works](#how-a-process-works)
    - [Signals](#signals)
- [Part 2 - Configuration and Environment](#part-2---configuration-and-environment)
  - [Environment](#environment)
    - [What, how and why](#what-how-and-why)
    - [Files and text editors](#files-and-text-editors)
  - [Introduction to Vi/VIm](#introduction-to-vi)
    - [Editing Modes](#editing-modes)
    - [Movement](#movement)
    - [Search and replace](#search-and-replace)
    - [Editing multiple files](#editing-multiple-files)
    - [Customizing VIM](#customizing-vim)
    - [Tips and Tricks](#tips-and-tricks)
  - [Prompt](#prompt)
    - [Customizing bashrc](#customizing-bashrc)
    - [Build logic in your configs](#build-logic-in-your-configs)
  - [LSOF and PS](#lsof-and-ps)
- [Part 3 - Common tasks and tools](#part-3---common-tasks-and-tools)
  - [Package Managers](#package-managers)
    - [Common tasks](#common-tasks)
  - [Searching for files](#searching-for-files)
    - [Locate and find](#locate-and-find)
    - [xargs](#xargs)
  - [Intro to Filesystems](#intro-to-filesystems)
  - [Networking](#networking)
    - [Ping, traceroute, netstat](#ping-traceroute-netstat)
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
- [Part 4 - Shell scripts](#part-4---shell-scripts)
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

[me@hostname ~]$ echo The total is $100.00
The total is 00.00

[me@hostname ~]$ echo The total is \$100.00
The total is $100.00
```

Escape characters:

"\a" - bell  
"\b" - backspace  
"\n" - newline  
"\r" - carriage return  
"\t" - tab

sleep 10; echo "Time's up" $'\a'

### Permissions

If you've tried to cat the "/etc/shadow" file (or others in "/etc" you might have
noticed that you didn't have permission to read it.

```bash
[me@hostname ~]$ cat /etc/shadow
/etc/shadow: Permission denied
[me@hostname ~]$ file /etc/shadow
/etc/shadow: regular file, no read permission
```

This is because as a regular user, you don't have permission to read the contents of it.

```bash
[me@hostname ~]$ > foo.txt
[me@hostname ~]$ ls -l foo.txt
-rw-rw-r-- 1 me me 0 2016-03-06 14:52 foo.txt
```

"-" - regular file  
"d" - directory  
"l" - symbolic link  
"c" - character special file (e.g. /dev/null)  
"b" - block special file (e.g. DVD drive)

> NOTE: With symbolic links, the file attributes are always "rwxrwxrwx", these are dummy values. The real file attributes are those of the file the symlink is pointing to.

Owner   Group   Other
rwx     rwx     rwx

sudo - execute a command as another user

```bash
[me@hostname ~]$ sudo apt-get update
Password:
```

### Processes

Linux, in the Unix tradition differs, from MS-DOS and Windows. It's not only a
multitasking system, but also multi-user.

id - display user identity

chmod - change a file's mode

umask - set default file permissions

su - run a shell as another user

chown - change a file's owner

chgrp - change a file's group ownership

passwd - change a user's password

#### How a process works

Modern operating systems multitask, in a sense. They give the illusion that they do
more than one thing at once by rapidly switching from one executing program to another.

When a process starts up, the kernel initiates a program called "init". Init in turn runs
init scritps (found in /etc), that start all the system services. Many of these are just
programs that sit in the background and do their thing without having a user interface
(usually referred to as "daemons"). The whole scheme is presented as a parent process pro-
ducing a child process.

"ps" - report current processes  
"top" - display tasks  
"jobs" - list active jobs  
"bg" - place a job in the background  
"fg" - bring a job back in the foreground  
"kill" - send a signal to a process  
"killall" - kill processes by name  
"shutdown" - shutdown or reboot the system

```bash
[me@hostname ~]$ gedit &
[1] 28236
[me@hostname ~]$ ps
...
28236 pts/1 00:00:00 gedit
28349 pts/1 00:00:00 ps
[me@hostname ~]$ jobs
[1]+ Running
[me@hostname ~]$ fg %1
```

#### Signals

The kill command is used to kill processes, think pausing or termination.

kill [-signal] PID

Signals:
"1" - Hangup. Vestige of computers connecting via phone lines and modems. Now reinit.  
"2" - Interrupt (akin to Ctrl-c in the terminal)  
"9" - Kill  
"15" - Terminate  
"18" - Continue. This will restore a process after a Stop or TSTP signal  
"19" - Stop  
"20" - Terminal stop (akin to Ctrl-z). Program can choose to ignore it

## Part 2 - Configuration and Environment

So the shell maintains a body of information during the shell session, this is the
environment. While most programs use configuration files to adjust their behavior,
some look for values stored in the environment.

Why set up an environment? To customize the shell experience.

printenv - print part or all of the environment

set - set shell options

export - export environment to subsequently executed programs

alias - create an alias for a command

### Environment

So how is it established? When you log into the system, the "bash" program starts.
It reads a series of configuration scripts called startup files, which define the
default environment shared by all users. This is followed by a login shell session
(CLI), or a non-login shell session (GUI).

#### What, how and why

"/etc/profile" - global configuration script that applies to all users  
"~/.bash_profile" - user's personal startup file, used to extend or override settings  
"~/.bash_login" - if ~/.bash_profile isn't found, bash attempts to read this script  
"~/.profile" - if neither the profile or the login scripts are found, it tries this one  
"/etc/bash.bashrc" - global configuration script that applies to all users  
"~/.bashrc" - user's personal startup file

```bash
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH
```

"#" - comment, not read by the shell. There only for human readability
"if block" - if compound command, we'll get to this in the Shell scripting chapter

> NOTE: If the file "~/.bashrc" exists, then read the ~/.bashrc" file

"PATH assign" - PATH is set to add the directory "$HOME/bin" to the end of its list

```bash
[me@hostname ~]$ foo="This is some "
[me@hostname ~]$ echo $foo
This is some
[me@hostname ~]$ foo=$foo"text."
[me@hostname ~]$ echo $foo
This is some text.
```

"export PATH" - tells the shell to make the contents of PATH available to child processes of this shell

So which files should you modify?

".bash_profile" (or equivalent) - to add environment variables
".bashrc" - everything else

After you've made your modifications, it's time to apply them. Changes made to .bashrc won't take effect
until you start a new terminal session, since it's only read at the beginning of a session. However you can
force bash to reread the modified .bashrc using the source command.

```bash
[me@hostname ~]$ source ~/.bashrc
```

#### Files and text editors

### Introduction to Vi/VIm

The reason Vi/VIm were chosen is because of how wide-spread they are. Old networking gear? Runs vi. Modern Linux
OS? Runs both. Well, that and I like it.

":q" - quit  
":q!" - quit and ignore changes made to the buffer or file

> NOTE: If you get lost in Vi, try pressing Esc twice then try exiting via :q


#### Editing Modes

So Vi is a modal editor, when it starts it begins in command mode. In this mode almost every key is a command.
Don't type anything yet.

To type, first press i to enter insert mode, type, then press Esc.

Saving your work. In command mode (Esc after typing in insert mode) type :w

#### Movement

l or right arrow - right one character  
h or left arrow - left one character  
j or down arrow - down one line  
k or up arrow - up one line  
0(zero) - to the beginning of the current line  
^ - to the first non-whitespace character on the line  
$ - to the end of the current line  
w - to the beginning of the next word or punctuation character  
W - to the beginning of the next word, ignoring punctuation characters  
b - to the beginning of the previous word or punctuation  
B - to the beginning of the previous word, ignoring punctuation  
Ctrl-f or Page Down - down one page  
Ctrl-b or Page Up - up one page  
numberG - to line number (e.g. 1G moves to the first line of the file)  
G - to the last line of the file  

Deleting:  
x - delete the current character  
3x - delete the current character and the next two characters  
dd - delete the current line  
5dd - delete the current line and the next four lines  
dW - from the current cursor position to the next word  
d$ - from the current cursor position to the end of the current line  
d0 - from the current cursor position to the beginning of the line  
d^ - from the current cursor position to the first non-whitespace character in the line  
dG - from the current line to the end of the file  
d20G - from the current line to the twentieth line of the file  

Copying:  
yy - The current line 
5yy - The current line and the next four lines  
yW - From the current cursor position to the beginning of the next word  
y$ - From the current cursor location to the end of the current line  
y0 - From the current cursor location to the beginning of the line  
y^ - From the current cursor location to the first non-whitespace character in the line  
yG - From the current line to the end of the file  
y20G - From the current line to the twentieth line of the file

#### Search and replace

/text

:%s/oldText/newText/g

: - colon character starts an ex command  
% - specifies range of lines for the operation. % is a shortcut meaning from the first line to the last. Alternatively the range could have been 1,5  
s - specifies the operation (substitution in this case)  
/oldText/newText/ - search and replacement pattern  
g - global, without specifying it, only the first instance of the search string on each line is replaced

You now get a prompt.

y - Perform the substitution.  
n - Skip this instance of the pattern.  
a - Perform the substitution on this and all subsequent instances of the pattern.  
q or Esc - Quit substituting.  
l - Perform this substitution and then quit. This is hort for “last.”  
Ctrl-e, Ctrl-y - Scroll down and scroll up, respectively. This is useful for viewing the context of the proposed substitution.

#### Editing multiple files

vi file1 file2

:bn - move from one file to the next
:bp - move back to the previous file
:buffers
:buffer 2
:e newFile

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

What if you open a file, write to it, then realize you can't save it because you
don't have permissions?

:!sudo tee %

% - current file  
:w - in this case isn't updating your file  
tee - T-shaped pipe. It directs output to specified files and also sends it to the standard output  
    - this is a more 'hacky' way of using tee, since we're ignoring half of its functionality

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

Give it a try, you can set something simple by yourself. It's encouraged.

Here's some escape sequences to set the background for example:

```bash
Sequence    Background Color  Sequence    Background Color  
\033[0;40m  Black             \033[0;44m  Blue  
\033[0;41m  Red               \033[0;45m  Purple  
\033[0;42m  Green             \033[0;46m  Cyan  
\033[0;43m  Brown             \033[0;47m  Light gray
```

What can you do with these? Here's an example:
```bash
[me@hostname ~]$ PS1="\[\033[0;31m\]<\u@h \W>\$\[\033[0m\] "  # What does this to?

[me@hostname ~]$ PS1="\[\033[0;31m\]<\u@\h \W>\$\[\033[0m\] " # What about this?
```

This might seem complicated but let's split it in parts to better showcase what each part does.

PS1="" - declaration  
\033[0;31m - set Red  
<\u@\h \W>\$ - prompt string  
\033[0m - turn off color  

Obviously, if you want to save your changes to the prompt, add them to your .bashrc
To do so, add these two lines to your .bashrc file, like so:

```bash
PS1="\[\033[s\033[0;0H\033[0;41m\033[K\033[1;33m\t\033[0m\033[u\]<\u@\h \W>\$ "
export PS1
```

#### Build logic in your configs

Say you want to better organize your environment. You have a separate file with aliases, let's call
it "00-aliases.bash" and you want to source it if it exists. What can you do?

You could do it the old fashioned way, and just add "source 00-aliases.bash" to your .bashrc file.

But there's a better way:

```bash
if [ -f /home/$USER/.dotfiles/00-aliases.bash ]; then
  source /home/$USER/.dotfiles/00-aliases.bash
else
  print "404: /home/$USER/.dotfiles/00-aliases.bash not found."
fi
```

This translates to:
```bash
if file 00-aliases.bash exists then
  source it
else
  print 404: file 00-aliases.bash not found.
end if
```

To use this principle, create a file 00-aliases.bash as shown above, and set .bashrc to import it:

```bash
# in your .bashrc add:
for f in $HOME/.dotfiles/00-aliases.bash; do
  . $f
done
```

To explain what this does, here's the for loop written in human readable language:
```bash
for every file that ends in .bash found in /home/.dotfiles do
  source 
done
```

> NOTE: We've set a variable f (file) and called it via "$f". This trick allows you to do more complex things.

## Part 3 - Common tasks and tools

### Package Managers

Most people are probably used to Windows, as their first experience with a computer. Installing software tends
to become a PITA pretty fast, searching for the software you want, making sure you get the right version and 
keeping it up to date. How does Linux do it? Package managers. Package management is a method of installing
and maintaining software on systems.

Different distributions use different packaging systems, and as a general rule packages intended for one 
distribution aren't compatible with other distributions. Most distributions fall into one of two camps:
* .deb (Debian and Ubuntu, Raspbian, Linux Mint)  
* .rpm (RedHat, Fedora, CentOS, OpenSUSE)

#### Common tasks

Some common operations that can be performed with the CLI package management tools are searching, installing,
updating and removing packages.

apt-cache search SEARCH_STRING  
apt-get update; apt-get install emacs  
apt-get remove emacs  
dpkg -i PACKAGE_FILE  
dpkg -l  
dpkg -s PACKAGE_NAME  
dpkg --status emacs

### Searching for files

#### Locate & find

locate - find files by name

find - search for files in a directory hierarchy

touch - change file times

stat - display file or file system status

locate bin/zip  
locate zip | grep bin  
find ~  
find ~ | wc -l  
find ~ -type d | wc -l  

> NOTE: find's argument are: b(block special device file), c(character special device file), d(directory),
f(regular file), l(symbolic link).

Here's a more complex find:

```bash
find ~ -type f -name "*.JPG" -size +1M | wc -l
```

Operators:
-and - match if the tests on both sides of the operator are true, shortened to -a  
-or - match if a test on either side is true, shortened to -o  
( ) - groups tests and operators together to form larger expressions

Example:
```bash
find ~ ( -type f -not -perms 0600 ) -or ( -type d -not -perms 0700 )
```

find AND/OR logic:

Results of expr1  Operator    expr2 is...  
True              -and        Always performed  
False             -and        Never performed  
True              -or         Never performed  
False             -or         Always performed

Try to run these:
```bash
find ~ -type f -and -name '*.bak' -and -print  
find ~ -print -and -type f -and -name '*.bak'  
find ~ -type f -name 'foo*' -ok ls -l '{}' ';'  
find ~ -type f -name 'foo*' -exec ls -l '{}' ';'
```

#### xargs

The xargs command performs an interesting function. It accepts input from STDIN and converts it
into an argument list for a specified command. We could use it like this:

```bash
find ~ -type f -name 'foo*' -print | xargs ls -l
```

> NOTE: Here we can see the output of the find command piped into xargs, which in turn constructs
an argument list for the ls command then executes it.

> NOTE: Dealing with funny names. Unix-like systems allow embedded spaces (even newlines) in filenames.
This can cause problems for programs such as xargs that construct argument lists. An embedded space
will be treated as a delimiter, and the resulting command will interpret each space-separated word
as a separate argument. To overcome this, find and xargs allow the optional use of a null character
as a separator.

```bash
find ~ -iname '*.jpg' -print0 | xargs --null ls -l
```

> NOTE: Using this method we can ensure that all files, even those containing embedded spaces in their
names are handled correctly.

```bash
[me@hostname ~]$ mkdir -p playground/dir-{001..100}  
[me@hostname ~]$ touch playground/dir-{001..100}/file-{A..Z}  
[me@hostname ~]$ find playground -type f -name 'file-A'  
[me@hostname ~]$ find playground -type f -name 'file-A' | wc -l  
[me@hostname ~]$ touch playground/timestamp  
[me@hostname ~]$ stat playground/timestamp  
[me@hostname ~]$ touch playground/timestamp  
[me@hostname ~]$ find playground -type f -name 'file-B' -exec touch '{}' ';'  
[me@hostname ~]$ find playground -type f -newer playground/timestamp  
[me@hostname ~]$ find playground \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)  
[me@hostname ~]$ find playground \( -type f -not -perm 0600 -exec chmod 0600 '{}' ';' \) -or \( -type d -not -perm 0700 -exec chmod
0700 '{}' ';' \)
```

Options:
-depth - direct find to process a directory's files before the directory itself  
-maxdepth levels - set the maximum number of levels that find will descend into a directory tree when performing tests and actions  
-mindepth levels - set minimum number of levels that find will descend into a directory tree before applying tests and actions  
-mount - direct find not to traverse directories that are mounted on other file systems  
-noleaf - direct find not to optimize its search based on the assumption that it is searching a Unix-like file system. Needed when scanning DOS/Windows file systems and CD-ROMs

### Intro to Filesystems

lsblk  
df -h  
sudo mkdir -p /mnt/datastore  
sudo fdisk /dev/sdb  

> NOTE: Create a new partition ("p"), list the partition types ("l"), change partition's system id ("t"),
select partition ("1"), set it to type Linux ("83") followed by a save and exit ("w").

sudo mkfs -t ext4 /dev/sdb1  
sudo mount /dev/sdb1 /mnt/datastore  
sudo fsck /dev/sdb1  

While most commands mentioned above make sense, some might be a bit vague the way they're named:
lsblk - list block devices  
df - report file system space usage  
fdisk - manipulates disk partition table  
mkfs - make filesystem  
fsck - check and repair Linux filesystems

While we usually think of data on our computers as organized into files, it's also possible to think of
said data in "raw" form. You can copy blocks of data with "dd".

> NOTE: Although the name is derived from "data definition", dd has another alias: destroyer of disks.
Like other commands such as "rm", be very careful when using this tool. Double-check your input and
output before running this command.

```bash
dd if=input_file of=output_file [bs=block size [count=blocks]]
```

Or more specific examples:  
dd if=/dev/sdb of=/dev/sdc  
dd if=debian.img of=/dev/sdc  
dd if=/dev/cdrom of=debian.iso  

When writing .iso or .img files you can check to see if the copy was completed successfully by making
checksums of the input and output and comparing the two.

```bash
md5sum debian.iso
34e354760f9bb7fbf85c96f6a3f94ece debian.iso
md5sum /dev/cdrom
34e354760f9bb7fbf85c96f6a3f94ece /dev/cdrom
```

### Networking

This is going to assume a little understanding of networking. If not, you should become familiarized
with the following concepts:
* Internet protocol (IP) address  
* Host and domain name  
* Uniform resource identifier (URI)

#### Ping, traceroute, netstat

ping - send an ICMP ECHO_REQUEST to network hosts  
traceroute - print the route packets trace to a network host  
netstat - print network connections, routing tables, interface statistics, masquerade connections and
multicase memberships  
ip - show / manipulate routing, devices, policy routing and tunnels  

The most basic network command is ping. It sends a special network packet (ICMP ECHO_REQUEST) to the
specified host and if said host is online and reachable, a response is sent back.

ping 1.1.1.1

Traceroute lists all the "hops" network traffic takes to get from the local system to a specified host.

traceroute fcc.org

Netstat is used to examine various network settings and statistics. Through the use of its many options,
we can look at a variety of features in our network setup.

netstat -ie  
netstat -r

Ip is a multi-purpose network configuration tool that makes use of the full range networking features
available in modern Linux kernels. It replaces the now deprecated "ifconfig" program.

ip a

#### SSH

ssh - OpenSSH SSH client (remote login program)

SSH consists of two parts, an SSH servers running on the remote host, listening to incoming connections
(port 22 by default) and an SSH client on the local system to communicate with the remote server.
SSH authenticates that the remote host is who it says it is (preventing main-in-the-middle attacks) and
it encrypts all of the communications between the two hosts.

```bash
ssh remote-host  
ssh user@remote-host  
ssh remote-host free  
ssh remote-host 'ls *' > dirlist.txt  
```

Tunneling with SSH. One of the most common uses is allowing the X Window system traffic to be transmitted.
On a system running an X server (system displaying a GUI), it's possible to launch and run an X client
program (graphical application) on a remote system and have its display appear on the local one.

```bash
[me@hostname ~]$ ssh -X remote-host
user@remote-host's password:
Last login: Mon Oct 03 16:23:09 2022
[me@remote-host ~]$ xload
```

> NOTE: Once the xload command is executed on the remote system, its window appears on the local system.
On some systems, you may need to use the "-Y" option rather than the "-X" option.

#### NFS

nfs - internet standard protocol that allows file sharing between systems on a local network

server:path /mountpoint fstype option,option,... 0 0

#### tcpdump

#### rsync

tcpdump - dump traffic on a network

### Archiving and backup

One of the primary tasks of a system's administrator is keeping the system's data secure. One way
this is done is by performing timely backups.

> NOTE: Don't compulsively compress. If a file has already been compressed, especially lossless, it has
no redundant information. You'll only have a bigger archive because of the overhead, that's the data
that is added to the file to describe the compression.

#### gzip

gzip - tool that compresses or expands files

When executed it replaces the original file with a compressed version of it. The corresponding "gunzip"
program is used to restore compressed files to their original uncompressed form.

```bash
[me@hostname ~]$ ls -l /etc > foo.txt
[me@hostname ~]$ gzip file.txt
[me@hostname ~]$ ls -l foo*
[me@hostname ~]$ gunzip foo.txt
```

#### tar

tar - tape archiving utility

Classic tool for archiving files. Its name comes from tape archive, revealing its roots as a tool for
backing up magnetic tapes.

```bash
[me@hostname ~]$ mkdir -p playground/dir-{001.100}
[me@hostname ~]$ touch playground/dir-{001..100}/file-{A..Z}
[me@hostname ~]$ tar cf playground.tar playground
[me@hostname ~]$ ls -lahi
[me@hostname ~]$ tar xvf playground.tar
```

> NOTE: Notice that we offer the, then, non-existing archive name ("playground.tar") before the directory
it's supposed to archive. Refer to the tool's respective man page before archiving, compressing or removing
something to avoid unwanted file removal.

You can even be selective regarding what you want to extract.

```bash
[me@hostname ~]$ sudo tar cf /datastore/backup/home.tar /home
[me@hostname ~]$ tar xvf ../playground.tar --wildcards 'home/me/playground/dir-*/file.txt'
[me@hostname ~]$ find playground -name 'file.txt' -exec tar rf playground.tar '{}' '+'
```

You can even create incremental backups using tar:

```bash
[me@hostname ~]$ find playground -name 'file-A' | tar cf - --files-from=- | gzip > playground.tgz
```

#### zip

zip - tool that packages and compresses files

zip is both a compression tool and an archiving one. In Windows it's common, however the common file format
in Linux is gzip.

zip -r playground.zip playground

unzip playground

#### File synchronization

rsync - remote file and directory synchronization

rsync source destination

ls destination

rsync -avP playground foo

```bash
[me@hostname ~]$ mkdir -p /datastore/backup
[me@hostname ~]$ sudo rsync -av --delete /etc /home /usr/local /datastore/backup
```

You can make use of aliases:
alias backup='sudo rsync -av --delete /etc /home /usr/local /datastore/backup

sudo rsync -av --delete --rsh=ssh /etc /home /usr/local remote-system:/backup

We went through how to securely transfer data through an ssh-encrypted tunnel. Let's see how we
can transfer files via an rsync server. Rsync can run as a service (daemon) and listen to incoming
requests for synchronization, often done to allow mirroring of a remote system.

```bash
mkdir -p repos/fedora-devel
rsync -av --delete rsync://archive.linux.duke.edu/fedora/linux/development/rawhide/Everything/x86_64/os/ repos/fedora-devel
```

In this example we used the remote rsync server, consisting of the "rsync://" protocol, followed by the remote
hostname "archive.linux.duke.edu", followed by the pathname of the repository.

### Regular Expressions

In this chapter we'll take a look at tools used to manipulate text. We've gone through some escape characters and other
operators that allowed us to do some neat tricks, so let's take a look at them - regular expressions

Regular expressions are symbolic notations used to identify patterns in text.

> NOTE: Understand that not all regular expressions are the same, they vary slightly from tool to tool and from programming
language to another. For this case we'll limit ourselves to regex as described in the POSIX standard ( which covers most 
command line tools ).

#### grep

The main program is grep, or "global regular expression print". It simply searches files for the occurrence of text matching
specified regular expressions and outputs them.

```bash
[me@hostname ~]$ grep -L bzip dirlist*.txt
[me@hostname ~]$ grep -h '.zip' dirlist*.txt
```

#### Logic, any and negation

```bash
[me@hostname ~]$ grep -i '^..j.r$' /usr/share/dict/words
```

This example allows us to find all words in our dictionary file that are five letters long and have a "j" in the third
position and an "r" in the last position.

Common expressions: ^ $ . [ ] { } - ? * + ( ) | \

> NOTE: Generally metacharacters lose their special meaning when placed within brackets. There are two cases in which
metacharacters are used within bracket expressions and have different meanings. "^" - the caret, which indicates negation,
and "-" - the dash, which is used to indicate a character range.

```bash
[me@hostname ~]$ grep -h '[bg]zip' dirlist*.txt
[me@hostname ~]$ grep -h '[^bg]zip' dirlist*.txt
```

The first example, using a two-character set, we match any line that contains the string bzip or gzip, while the second one
has a different take. With negation, we get a list of files that contain the string zip preceded by any character except "b"
or "g".

> NOTE: The file zip wasn't found. A negated character set still requires a character at the given position, but the character
must not be a member of the negated set.

```bash
[me@hostname ~]$ grep -h '^[ABCDEFGHIJKLMNOPQRSTUVWXZY]' dirlist*.txt
[me@hostname ~]$ grep -h '^[A-Za-z0-9]' dirlist*.txt

ls /usr/sbin/[ABCDEFGHIJKLMNOPQRSTUVWXYZ]*
ls /usr/sbin/[A-Z]*
```

#### Quantifiers

Extended regular expressions support several ways to specify the number of times an element is matched.

"?" - make the preceding element optional  

Say you want to check a phone number for validity. Say a number is valid if it matches one of two forms,
where "n" is a numeral:  
(nnn) nnn-nnnn  
nnn nnn-nnnn

The regular expression would look like this:
```bash
^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$
```

In this expression we follow the parentheses characters with question marks to indicate that they're to be matched
zero or one time. Parentheses are normally metacharacters, therefore we precede them with backslashes to cause
them to be treated as literals instead.

```bash
[me@hostname ~]$ echo "(555) 123-4567" | grep -E '^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
(555) 123-4567
[me@hostname ~]$ echo "555 123-4567" | grep -E '^\(?[0-9][0-9][0-9]\)? [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'
555 123-4567
```

"\*" - match an element zero or more times

```bash
[me@hostname ~]$ echo "This works." | grep -E '[[:upper:]][[:upper:][:lower:] ]*\.'
This works.
[me@hostname ~]$ echo "This Works." | grep -E '[[:upper:]][[:upper:][:lower:] ]*\.'
This Works.
[me@hostname ~]$ echo "this does not" | grep -E '[[:upper:]][[:upper:][:lower:] ]*\.'
[me@hostname ~]$
```

"+" - match an element one or more times

```bash
[me@hostname ~]$ echo "This that" | grep -E '^([[:alpha:]]+ ?)+$'
This that
[me@hostname ~]$ echo "a b c" | grep -E '^([[:alpha:]]+ ?)+$'
a b c
```

"{}" - match an element a specific number of times

These metacharacters are used to express minimum and maximum numbers of required matches. They may be specified
as follows:

{n} - Match the preceding element if it occurs exactly n times.  
{n,m} - Match the preceding element if it occurs at least n times but no more than m times.  
{n,} - Match the preceding element if it occurs n or more times.  
{,m} - Match the preceding element if it occurs no more than m times

```bash
[me@hostname ~]$ echo "(555) 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$'
(555) 123-4567
[me@hostname ~]$ echo "555 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$'
555 123-4567
[me@hostname ~]$ echo "5555 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$'
[me@hostname ~]$
```

Let's see an example:

```bash
[me@hostname ~]$ for i in {1..10}; do echo "(${RANDOM:0:3}) ${RANDOM:0:3}-${RANDOM:0:4}" >> phonelist.txt; done
[me@hostname ~]$ cat phonelist.txt
(232) 298-2265
(624) 381-1078
(540) 126-1980
(874) 163-2885
(286) 254-2860
(292) 108-518
(129) 44-1379
(458) 273-1642
(686) 299-8268
(198) 307-2440
[me@hostname ~]$ grep -Ev '^\([0-9]{3}\) [0-9]{3}-[0-9]{4}$' phonelist.txt
(292) 108-518
(129) 44-1379
```

#### find, locate and less

The find command supports a test based on a regular expression. Important consideration to keep in mind, when
using regex in find versus grep. Whereas grep will print a line when it contains a match, find requires that
the pathname exactly match the regex.

```bash
[me@hostname ~]$ find . -regex '.*[^-_./0-9a-zA-Z].*'
```

The locate program supports both basic (the --regexp option) and the extended (--regex option) regular expressions.  
With it we can perform many operations:

```bash
[me@hostname ~]$ locate --regex 'bin/(bz|gz|zip)'
/bin/bzcat
/bin/bzcmp
/bin/bzdiff
/bin/bzegrep
/bin/bzexe
/bin/bzfgrep
/bin/bzgrep
...
```

less and vim both share the same method of searching for text, using the "/" key followed by the regular expression.

```bash
[me@hostname ~]$ less phonelist.txt
(232) 298-2265
(624) 381-1078
(540) 126-1980
(874) 163-2885
(286) 254-2860
(292) 108-518
(129) 44-1379
(458) 273-1642
(686) 299-8268
(198) 307-2440
~
~
~
/^\([0-9]{3}\) [0-9]{3}-[0-9]{4}
```

> NOTE: less will highlight the strings that match, leaving the invalid ones easy to spot.

Here's a trick on how to find more information about them by searching via zgrep.

```bash
[me@hostname ~]$ cd /usr/share/man/man1
[me@hostname man1]$ zgrep -El 'regex|regular expression' *.gz
```

### Text processing

cat - concatenate files and print on the standard output  
sort – Sort lines of text files  
uniq – Report or omit repeated lines  
cut – Remove sections from each line of files  
paste – Merge lines of files  
join – Join lines of two files on a common field  
comm – Compare two sorted files line by line  
diff – Compare files line by line  
patch – Apply a diff file to an original  
tr – Translate or delete characters  
sed – Stream editor for filtering and transforming text  
aspell – Interactive spell checker

> NOTE: Opposite 'head', you have the 'tail' command. Check their respective man pages to see what they do.

#### cat, sort and uniq

sort file1.txt file2.txt file3.txt > final_sorted_list.txt 

du -s /usr/share/* | head  

ls -l /usr/bin | sort -nrk 5 | head  

```bash
[me@hostname ~]$ sort distros.txt
Fedora 10 11/25/2008
Fedora 5 03/20/2006
Fedora 6 10/24/2006
Fedora 7 05/31/2007
Fedora 8 11/08/2007
Fedora 9 05/13/2008
SUSE 10.1 05/11/2006
SUSE 10.2 12/07/2006
SUSE 10.3 10/04/2007
SUSE 11.0 06/19/2008
Ubuntu 6.06 06/01/2006
Ubuntu 6.10 10/26/2006
Ubuntu 7.04 04/19/2007
Ubuntu 7.10 10/18/2007
```

sort --key=1,1 --key=2n distros.txt  

sort -k 3.7nbr -k 3.1nbr -k 3.4nbr distros.txt

sort -t ':' -k 7 /etc/passwd | head  

#### cut, paste and join

cut - program used to extract a section of text from a line, and output the extracted section to STDOUT

cat -A distros.txt  

cut -f 3 distros.txt  

cut -f 3 distros.txt | cut -c 7-10  

> NOTE: Expanding Tabs
Our distros.txt file is ideally formatted for extracting fields using cut. But
what if we wanted a file that could be fully manipulated with cut by characters,
rather than fields? This would require us to replace the tab characters within the
file with the corresponding number of spaces. Fortunately, the GNU Coreutils
package includes a tool for that. Named expand, this program accepts either one
or more file arguments or standard input and outputs the modified text to standard
output.
If we process our distros.txt file with expand, we can use cut -c to ex-
tract any range of characters from the file. For example, we could use the follow-
ing command to extract the year of release from our list by expanding the file and
using cut to extract every character from the 23rd position to the end of the line:
```bash
[me@hostname ~]$ expand distros.txt | cut -c 23-
```
Coreutils also provides the unexpand program to substitute tabs for spaces.

paste - does the opposite of cut, it adds one or more columns of text to a file

sort -k 3.7nbr -k 3.1nbr -k 3.4nbr distros.txt > distros-by-date.txt  
cut -f 1,2 distros-by-date.txt > distros-versions.txt  
head distros-versions.txt  
cut -f 3 distros-by-date.txt > distros-dates.txt  
head distros-dates.txt  
paste distros-dates.txt distros-versions.txt  

#### diff and sed

Like the comm program, diff is used to detect the differences between files. Diff however
is a much more complex tool.

diff file1.txt file2.txt  
diff -c file1.txt file2.txt  

> NOTE: Using diff with the -c option shows the range in the context format, considerably more human readable.

You can either modify the file using your preferred text editor or you can use patch.

```bash
[me@hostname ~]$ diff -Naur file1.txt file2.txt > patchfile.txt
[me@hostname ~]$ patch < patchfile.txt
patching file file1.txt
[me@hostname ~]$ cat file1.txt
b
c
d
e
```

tr - program used to transliterate characters, think of it as a character-based search and replace 

Transliteration is the process of changing characters from one alphabet to another, say, lowercase to uppercase.

```bash
[me@linuxbox ~]$ echo "lowercase letters" | tr a-z A-Z
LOWERCASE LETTERS
```



While editing on the fly is possible, keep it to small, niche cases, such as echo-ing a string into a new file.

echo -e "Host remoteHost \n\tIdentitiesOnly=yes" >> ~/.ssh/config

> NOTE: We used echo -e in this case to have it interpret \n and \t as newline and tab respectively. The output is as follows:

```bash
me@hostname ~]$ tail -3 ~/.ssh/config
Host remoteHost
	User me
        IdentityFile ~/.ssh/id_rsa
[me@hostname ~]$ echo -e "Host remoteHost2 \n\tIdentitiesOnly=yes" >> ~/.ssh/config
me@hostname ~]$ tail -5 ~/.ssh/config
Host remoteHost
	User me
        IdentityFile ~/.ssh/id_rsa

Host remoteHost2
	IdentitiesOnly=yes
```

sed - short for stream editor, it performs text editing on a stream of text (specified files or STDIN

```bash
[me@linuxbox ~]$ echo "front" | sed 's/front/back/'
back
```

```
#Command Description
= - Output the current line number.
a - Append text after the current line.
d - Delete the current line.
i - Insert text in front of the current line.
p - Print the current line. By default, sed prints every
    line and only edits lines that match a specified
    address within the file. The default behavior can
    be overridden by specifying the -n option.
    q Exit sed without processing any more lines. If the
    -n - option is not specified, output the current line.
    Q - Exit sed without processing any more lines.
    s/regexp/replacement/ - Substitute the contents of replacement wherever
    regexp is found. replacement may include the
    special character &, which is equivalent to the text
    matched by regexp. In addition, replacement may
    include the sequences \1 through \9, which are
    the contents of the corresponding subexpressions
    in regexp. For more about this, see the discussion
    of back references below. After the trailing slash
    following replacement, an optional flag may be
    specified to modify the s command’s behavior.
y/set1/set2 - Perform transliteration by converting characters
              from set1 to the corresponding characters in set2.
              Note that unlike tr, sed requires that both sets be
              of the same length.
```

Here's an example of how ugly it can get:

```bash
[me@linuxbox ~]$ sed 's/\([0-9]\{2\}\)\/\([0-9]\{2\}\)\/\([0-9]\{4\}\
)$/\3-\1-\2/' distros.txt
SUSE 10.2 2006-12-07
Fedora 10 2008-11-25
SUSE 11.0 2008-06-19
Ubuntu 8.04 2008-04-24
Fedora 8 2007-11-08
SUSE 10.3 2007-10-04
Ubuntu 6.10 2006-10-26
Fedora 7 2007-05-31
Ubuntu 7.10 2007-10-18
Ubuntu 7.04 2007-04-19
SUSE 10.1 2006-05-11
Fedora 6 2006-10-24
Fedora 9 2008-05-13
Ubuntu 6.06 2006-06-01
Ubuntu 8.10 2008-10-30
Fedora 5 2006-03-20
```

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
## TODO:
* Write Ansible playbook to:
  - update system
  - set up various users, their home directories, different Shells
  - create directories for future NFS shares
  - install NFS server
* Add couple of notes from https://danielmiessler.com/study/tcpdump/ to tcpdump section
* Add homework to each chapter
# ######################################################################################
