# Linux-workshop

## Table of Contents
- [Goals](#goals)
  - [Why Debian?](#why-debian)
  - [Why Ansible?](#why-ansible)
- [Requirements](#requirements)A
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

### Why Ansible?

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

Verify your `Debian` installation is up to date before starting.

```
sudo apt-get update
sudo apt-get upgrade
```

> NOTE: This will take some time.

## Setup

### Environment

Why set up an environment? 

#### .bashrc

#### .vimrc

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
