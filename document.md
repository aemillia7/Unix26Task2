<p align="center">
  <img src="images/BusyBox.png" />
</p>
<p align="center">

<p align="center">
  | <a href="#about">About</a> |
  <a href="#task">Task and Requirements</a> |
  <a href="#implementation">Implementation Details</a> |
  <a href="#diary">Work Diary</a> |
  <a href="#setup">Setup & Run</a> |
  <a href="#challenges">Challenges</a> |

</p>

<p align="center">

  <img src="https://img.shields.io/badge/Language-Bash-blue" />

  <img src="https://img.shields.io/badge/Software-BusyBox-orange" />

  <img src="https://img.shields.io/badge/OS-Linux-lightgrey" />

  <img src="https://img.shields.io/badge/Architecture-x86__64-green" />

  <img src="https://img.shields.io/badge/Build-From_Source-red" />

  <img src="https://img.shields.io/badge/Service-systemd-blueviolet" />

  <img src="https://img.shields.io/badge/Status-Academic_Project-darkgreen" />

</p>

<a id="about"></a>
## :large_blue_diamond: About
---
<p align="justify">

miau miau miau

</p>

---

<a id="task"></a>
## :large_blue_diamond: Task and Requirements
---
<p align="justify">

The objective of this task is to build and use BusyBox from source on a Debian virtual machine ("IT Unix 26 debian-13") without using any package managers.

The following requirements must be completed:

### 1. BusyBox Compilation
- Download BusyBox source code manually
- Compile a statically linked BusyBox binary for x86_64 architecture
- Store all source files in `/opt/task2/src`

### 2. Script Development
- Create `/opt/task2/compile.sh` to compile BusyBox
- Create `/opt/task2/deploy.sh` to deploy BusyBox commands as `/bin/bb-<command>`
- Create `/opt/task2/test.sh` to test all deployed commands and print their exit codes

### 3. BusyBox Usage
- Configure a systemd service `bb-httpd` using BusyBox `httpd`
- Serve content from `/var/www/html/index.html`
- The page must display: `I am alive <MIF-username>`
- Store httpd configuration in `/etc/bb-httpd.conf`

Service requirements:
- Must start automatically on system boot
- Must restart if stopped or killed

### 4. HTTP Testing
- Create `/opt/task2/httptest.sh` to display served HTTP content in terminal

### 5. Documentation & Delivery
- Document the implementation and challenges in `document.md`
- Submit a Git repository containing all scripts and documentation

</p>

<a id="implementation"></a>
## :large_blue_diamond: Implementation
---
<p align="justify">

miau miau miau

</p>

<a id="diary"></a>
## :large_blue_diamond: Work Diary
---
<p align="justify">

Basically, it is easiest for me to start working when I plan what I need to do and organize everything so that the task is clear to me. That is why the first thing I did was to carefully read the task and understand what is required from me. First of all, I did some research about BusyBox - what it is, how it works, and what is the main idea of this task, what I am supposed to learn (some points, like what BusyBox is and how it works, will be explained in other sections, so I will not explain everything here).

I created all the required files where scripts and documentation will be written, and I defined a structure in which order the scripts should be written. I also explained to myself why this order makes sense:

compile.sh  ->  deploy.sh  ->  test.sh  ->  bb-httpd service  ->  httptest.sh  ->  document.md

But I will update document.md after each step, so the documentation is more complete, because if I write everything only at the end, a lot of information can be missed or not fully explained.

The first file I worked on was compile.sh. This file is used to compile a statically linked BusyBox (which means it works without additional libraries) for x86_64 architecture (which is a standard 64-bit Linux architecture).

The next thing I did was to understand how BusyBox source code is downloaded. I went to the website https://busybox.net/downloads/ to see how the download structure looks like, specifically busybox-[version].tar.bz2. I also checked available versions and decided to use the latest one, which is 1.37.0 (released 2025-09-26).

In the compile.sh file, I started by defining variables and paths. More comments about the code and why specific variables are needed are written directly in the script, because it is easier for me when everything is explained in place.

While writing the script, I used the following command to check if there are syntax errors:

bash -n compile.sh

-n means “no execution” – it checks syntax but does not run the script.

Challenges:

The first challenge: when I ran the script for the first time, it failed during the extraction step because the system did not have bzip2. At first, I tried to change .bz2 to .gz, but it turned out that BusyBox does not provide a .gz archive, so I had to go back to .bz2 and solve the problem differently.

The second challenge: during compilation, some build tools (make, gcc, bzip2) were missing, so I had to add a dependency check in the script. At this point, I had questions about the task requirements.

Also, during compilation, some errors appeared with certain BusyBox components (for example, tc), so I had to disable unnecessary features in the .config file.

In general, compile.sh looked simple at first, but debugging and fixing errors took quite a lot of time.

While working on this task, I also had a few questions (which I will clarify during practice session):
- Is it allowed to install build tools such as make and gcc using apt, while BusyBox itself is downloaded and compiled from source?
- Is it allowed to use sudo apt update in this script?

In short, after a few hours of work, I finally finished the first script. Honestly, I did everything in one commit – maybe I should have made several commits, but I forgot. I will try to commit more often for the next files.

P.S. Now it is 4:30 in the morning, I am so cooked 😭, so see you probably again today in part two of DAY 1.

</p>

Declaration of AI:

All the sentences and words written in this file are my own. AI was only used to check spelling and correct grammar mistakes for better understanding, and to slightly improve clarity where needed.