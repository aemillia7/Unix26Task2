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

1. Use your virtual machine that is using the template **"IT Unix 26 debian-13"**
2. Your task is to write an installation, compilation, and test scripts in **bash** for **BusyBox**. Learn to download source code, compile software on your machine and related libraries in _/opt/task2/src_.  It is also important to download, compile and install in _/opt/task2/src_ all components of BusyBox on your Debian virtual machine without using any package managers for the installations.
    1. Write a compilation script _/opt/task2/compile.sh_ that compiles a **statically linked** BusyBox binary for x86_64 architecture.
    2. Write a script _/opt/task2/deploy.sh_ that deploys all BusyBox call commands to /bin/bb-<command>. For example, _ls_ from BusyBox is linked to _/bin/bb-ls_. (Can be shell scripts).
    3. Write a script _/opt/task2/test.sh_ that tests all BusyBox linked binaries with case examples. Additionally, list all commands and their exit codes after executing them.
3. Your task is to use BusyBox correctly.
    1. Write a systemd service named _bb-httpd_ that uses httpd daemon from BusyBox to handle HTTP requests on port 80. It should serve _/var/www/html/index.html_ with a string _"I am alive <MIF-username>"_. The config file of _httpd_ should be in _/etc/bb-httpd.conf._
    2. The systemd service file should be in the standard systemd directory. Service must be enabled - start automatically after each reboot. It should also restart the service if it's killed or stopped.
    3. Write a script _/opt/task2/httptest.sh_ to print to the terminal HTTP served content.
4. Document your actions/challenges in a .md (markdown syntax - same as used on mif git) file in the git repository, which would be shared with course professors.
5. Share the Result for validation is of GIT repo with script, _document.md_ VM with and git repo with an installation script.

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

### DAY 1:

Basically, it is easiest for me to start working when I plan what I need to do and organize everything so that the task is clear to me. That is why the first thing I did was to carefully read the task and understand what is required from me. First of all, I did some research about BusyBox - what it is, how it works, and what is the main idea of this task, what I am supposed to learn (some points, like what BusyBox is and how it works, will be explained in other sections, so I will not explain everything here). Next, I created all the required files where scripts and documentation will be written, and I defined a structure in which order the scripts should be written. I also explained to myself why this order makes sense:

**compile.sh  ->  deploy.sh  ->  test.sh  ->  bb-httpd service  ->  httptest.sh  ->  document.md**

But I will update document.md after each step, so the documentation is more complete, because if I write everything only at the end, a lot of information can be missed or not fully explained.

The first file I worked on was `compile.sh`. This file is used to compile a statically linked BusyBox (which means it works without additional libraries) for x86_64 architecture (which is a standard 64-bit Linux architecture). The next thing I did was to understand how BusyBox source code is downloaded. I went to the website https://busybox.net/downloads/ to see how the download structure looks like, specifically **busybox-[version].tar.bz2**. I also checked available versions and decided to use the latest one, which is **1.37.0** (_released 2025-09-26_).

In the `compile.sh` file, I started by defining variables and paths. More comments about the code and why specific variables are needed are written directly in the script, because it is easier for me when everything is explained in place. While writing the script, I used the following command to check if there are syntax errors:

`bash -n compile.sh`

_-n_ means "no execution" - it checks syntax but does not run the script.

**Challenges:**

The first challenge: when I ran the script for the first time, it failed during the extraction step because the system did not have _bzip2_. At first, I tried to change _.bz2_ to _.gz_, but it turned out that BusyBox does not provide a _.gz_ archive, so I had to go back to _.bz2_ and solve the problem differently.

The second challenge: during compilation, some build tools (_make, gcc, bzip2_) were missing, so I had to add a dependency check in the script. At this point, I had questions about the task requirements.

Also, during compilation, some errors appeared with certain BusyBox components (for example, _tc_), so I had to disable unnecessary features in the `.config` file.

In general, `compile.sh` looked simple at first, but debugging and fixing errors took quite a lot of time.

While working on this task, I also had a few questions (which I later had clarified):
- Is it allowed to install build tools such as make and gcc using apt, while BusyBox itself is downloaded and compiled from source?
- Is it allowed to use sudo apt update in this script?
- Is it allowed to use external commands, such as: _grep, sed_ and etc.
- Regarding commits - am I allowed to push all the script in one commit, or is it better to divide into several parts?

In short, after a few hours of work, I finally finished the first script. Honestly, I did everything in one commit – maybe I should have made several commits, but I forgot. I will try to commit more often for the next files.

P.S. Now it is 4:30 in the morning, I am so cooked 😭, so see you in DAY 2.


### DAY 2:

</p>




### Declaration of AI:

All the sentences and words written in this file are my own. AI was only used to check spelling and correct grammar mistakes for better understanding, and to slightly improve clarity where needed.