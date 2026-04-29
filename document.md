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

---

<a id="about"></a>
## :large_blue_diamond: About
<p align="justify">

miau miau miau

</p>

---

<a id="task"></a>
## :large_blue_diamond: Task and Requirements
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


