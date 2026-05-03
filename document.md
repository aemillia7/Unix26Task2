<p align="center">
  <img src="images/BusyBox.png" />
</p>
<p align="center">

<div align="center">
 | <a href="#large_blue_diamond-about">About</a> |
  <a href="#large_blue_diamond-task-and-requirements">Task and Requirements</a> |
  <a href="#large_blue_diamond-implementation-details">Implementation Details</a> |
  <a href="#large_blue_diamond-work-diary">Work Diary and Challenges</a> |
  <a href="#large_blue_diamond-conclusion">Conclusion and Lessons Learned</a> |
  <a href="#large_blue_diamond-setup--run">Setup & Run</a> |
</div>

<p align="center">

  <img src="https://img.shields.io/badge/Language-Bash-blue" />

  <img src="https://img.shields.io/badge/Software-BusyBox-orange" />

  <img src="https://img.shields.io/badge/OS-Linux-lightgrey" />

  <img src="https://img.shields.io/badge/Architecture-x86__64-green" />

  <img src="https://img.shields.io/badge/Build-From_Source-red" />

  <img src="https://img.shields.io/badge/Service-systemd-blueviolet" />

  <img src="https://img.shields.io/badge/Status-Academic_Project-darkgreen" />

</p>

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
## :large_blue_diamond: Implementation Details
---
<p align="justify">

miau miau miau

!!!Emilia don't forget to add a table with exit codes for explaining the test.sh script!!!

Exit Code	Meaning
0	Success: The command or script executed without errors.
1	General error: A generic error occurred during execution.
</p>

<a id="diary"></a>
## :large_blue_diamond: Work Diary and Challenges
---
<p align="justify">

### DAY 1:

Basically, it is easiest for me to start working when I plan what I need to do and organize everything so that the task is clear to me. That is why the first thing I did was to carefully read the task and understand what is required from me. First of all, I did some research about BusyBox - what it is, how it works, and what is the main idea of this task, what I am supposed to learn (some points, like what BusyBox is and how it works, will be explained in other sections, so I will not explain everything here). Next, I created all the required files where scripts and documentation will be written, and I defined a structure in which order the scripts should be written. I also explained to myself why this order makes sense:

`compile.sh  ->  deploy.sh  ->  test.sh  ->  bb-httpd service  ->  httptest.sh  ->  document.md`

But I will update document.md after each step, so the documentation is more complete, because if I write everything only at the end, a lot of information can be missed or not fully explained.

The first file I worked on was `compile.sh`. This file is used to compile a statically linked BusyBox (which means it works without additional libraries) for x86_64 architecture (which is a standard 64-bit Linux architecture). The next thing I did was to understand how BusyBox source code is downloaded. I went to the website https://busybox.net/downloads/ to see how the download structure looks like, specifically **busybox-[version].tar.bz2**. I also checked available versions and decided to use the latest one, which is **1.37.0** (_released 2025-09-26_).

In the `compile.sh` file, I started by defining variables and paths. More comments about the code and why specific variables are needed are written directly in the script, because it is easier for me when everything is explained in place. While writing the script, I used the following command to check if there are syntax errors:

`bash -n compile.sh`

_-n_ means _no execution_ - it checks syntax but does not run the script.

**Challenges:**

  1. The first challenge: when I ran the script for the first time, it failed during the extraction step because the system did not have _bzip2_. At first, I tried to change _.bz2_ to _.gz_, but it turned out that BusyBox does not provide a _.gz_ archive, so I had to go back to _.bz2_ and solve the problem differently.
  2. The second challenge: during compilation, some build tools (`make`, `gcc`, `bzip2`) were missing, so I had to add a dependency check in the script. At this point, I had questions about the task requirements.
  3. Also, during compilation, some errors appeared with certain BusyBox components (for example, `tc`), so I had to disable unnecessary features in the `.config` file.

In general, `compile.sh` looked simple at first, but debugging and fixing errors took quite a lot of time.

While working on this task, I also had a few questions (which I later had clarified):
- Is it allowed to install build tools such as `make` and `gcc` using `apt`, while BusyBox itself is downloaded and compiled from source?
- Is it allowed to use `sudo apt update` in this script?
- Is it allowed to use external commands, such as: `grep`, `sed` and etc.
- Regarding commits - am I allowed to push all the script in one commit, or is it better to divide into several parts?

In short, after a few hours of work, I finally finished the first script. Honestly, I did everything in one commit – maybe I should have made several commits, but I forgot. I will try to commit more often for the next files.

P.S. Now it is 4:30 in the morning, I am so cooked 😭, so see you in DAY 2.


### DAY 2:

Today’s task was to write the `deploy.sh` script. The goal of this script is: first of all, to check if `/opt/task2/busybox` exists, then take the BusyBox command list and for each command create `/bin/bb-<command>` (because currently commands work like `/opt/task2/busybox ls`, but they need to work like `bb-ls`, for example); and each `bb-*` file will execute `/opt/task2/busybox <command>`.

The first step (the check) did not cause any problems, so I quickly moved to step two. In this step, I had to create a loop that goes through all BusyBox commands. I take the full list of commands from `/opt/task2/busybox` and for each command create a small wrapper script in the format `/bin/bb-<command>`.

For example, a file `/bin/bb-ls` is created, and inside it runs:

`/opt/task2/busybox ls "$@"`

So when the user types `bb-ls` in the terminal, in reality the BusyBox `ls` command is executed. In other words, `bb-ls` is just a convenient name for a BusyBox command with a `bb-` prefix.

Finally, inside the loop I added `chmod +x`, so that each created file becomes executable. After this step, commands like `bb-echo miau`, `bb-ls`, and others were already working correctly.

While working on this task, I also had a few questions (to which I later got answers):
- Regarding sudo permissions, at the end of my work I plan to create a fresh VM to test whether my scripts work properly. For that, sudo access will be required. However, the teaching assistant said that there should be no issues and sudo permissions will be available.

**Challenges:**

  1. One challenge was understanding how to correctly loop through the BusyBox command list. At first, I tried to use a `for` loop, but it did not work correctly because of how Bash splits input. The correct solution was to use `while read -r`, which reads the commands line by line.
  2. Another challenge was understanding how the wrapper scripts work, especially the part with `$@`. It was not immediately clear why it needs to be escaped as `\$@`, but later I understood that this is required so that the arguments are passed correctly when the wrapper script is executed, not during its creation.

P.S. Overall, not bad, only 1.6 hours of work and one red bull (_Watermelon_ taste is not bad but _Iced gummy bears_ is the best one), and the script is finished! 🥳

### DAY 3:

Today my goal was to write the `test.sh` script. At first glance, it seemed that it would not be difficult, because the task was just to test commands and print their exit codes. But... the first impression was misleading.

It looked like only one simple loop would be needed, where I get the list of `bb-*` files, run each one, take its exit code and print the result. Logically, all of this was implemented quite quickly, however what happened later after running the script was that several issues appeared.

The first issue was that the output of some commands was very long, so it was necessary to redirect the output of each command to `/dev/null` and only show the report in the terminal.

The second challenge was that some commands (for example `bb-cat`, etc.) were waiting for input, and because of that the script seemed to freeze, because until one command is finished, the next ones cannot be executed. Because of this, a decision was made to add a `timeout` - if a command is not processed within 2 seconds, it exits with code `124`. Therefore, the loop had to be modified and the following part was added:

`timeout 2 "$cmd" </dev/null >/dev/null 2>&1`

After that, the output looked much cleaner and more manageable. However, later during testing, the connection was closed by the remote host. This happened because eventually the `killall5` command was tested and it affected the system, which caused the connection to close. This is actually a serious issue, because after that there were still many commands left untested. At this point, there are several possible solutions. The first option is to skip commands that can affect the system, but this is not a very good solution, because those commands will not be tested. The second option is not to test commands directly, but to use `--help`, meaning that instead of performing the real action, the command only prints the help text. This is a safer solution, but it raises a question whether this approach is allowed. After modifying the code and using `--help`, I noticed that all commands were tested, but the exit code was always `0`, which means that this solution is also not fully correct.

While working on this task, I also had a few questions (to which I later got answers):

- Is it allowed to skip dangerous commands that can affect the system?
- Is it allowed to use `timeout 2` and treat exit code `124` as a valid result for commands that do not respond?
- Is it acceptable to test commands using `--help` instead of executing them normally?

**Challenges:**
  1. Managing large command output. Some BusyBox commands produce very large output, which made the terminal output hard to read. This was solved by redirecting output to /dev/null.
  2. Commands waiting for input. Some commands (like `bb-cat`, etc.) were waiting for user input, which caused the script to freeze. This was solved by using timeout and redirecting input from `/dev/null`.
  3. Dangerous commands affecting the system. Commands like `killall5` can affect the system and even terminate the current session. This caused the connection to be closed before all commands were tested.
  4. Choosing the correct testing approach. It was not clear whether commands should be tested directly (which can be dangerous), skipped (which is incomplete), or tested using `--help` (which is safe but may not fully validate functionality).

P.S. Expectation: I thought it will take me 15 min to write this script. Reality: I am leaving this task for the next day since I have to clarify the requirements xd

### DAY 4:


</p>




### Declaration of AI:

All the sentences and words written in this file are my own. AI was only used to check spelling and correct grammar mistakes for better understanding, and to slightly improve clarity where needed.