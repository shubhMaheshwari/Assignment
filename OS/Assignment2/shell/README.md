# Shell Implementation in C++
## Shubh Maheshwari 
## Pratik Kamble

### Introduction

- This is a basic shell implemented using `syscalls` and C++ _STL templates_.
- C/C++ provides headers such as `unistd`, `pwd.h`, `sys/types.h`, etc to make system calls and other process calling much easier.

### How to Run

- First, make sure you have _make_ installed.
	- `sudo apt-get install make`
- Clone this repo to your computer  `git clone https://github.com/Pk13055/cpp-shell.git`
- `cd cpp-shell`
- `make`
- Now, provided your make succeeds, you will have a file `shkell` in this folder.
- Finally, run `./shkell`

### How to Contribute

- When adding a new feature/method, make sure you follow the following steps.
	- (_optional_) Define a new header file if it is a completely new feature.
	- The header file(s) should only have class and function **definitions**.
	- Variables can be included but should be of the form `extern ...`.
	- Now, make a `*.cpp` file, and `#include<yourheader>` in that file. Here, the class and function definitions can be written. Additionaly, any variables declared in the header file must be declared here again _sans_ `extern`.
	- At the end now, include your header file in the `main.cpp` as `#include "yourheader"`.

- Open a pull request describing your feature addition.