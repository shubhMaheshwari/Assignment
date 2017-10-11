#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include<sys/stat.h>
#include<fcntl.h>

int main() {
    char s[102], f_content[102];
    int fildes[2], pid;

    // create a pipe. data -> fildes[1] -> fildes[0]
    if(pipe(fildes) != 0) {
      perror("pipe failed");
    }
    
    pid = fork();

    if(pid == -1) {
      perror("fork failed");
    }
    else if(pid == 0){
      // child process

      // close unused fds
      close(fildes[1]);

      printf("%d(child): Waiting for content to be written\n", getpid());
      read(fildes[0], f_content, 100);
      printf("%d(child): File contents >>> %s\n", getpid(), f_content);
      close(fildes[0]);
    }
    else {
      // parent process

      // close unused fds
      close(fildes[0]);

      sleep(1);  // Let child do its thing first

      printf("%d(parent): Please enter some word >>> ", getpid());
      scanf("%s", s);
      write(fildes[1], s, strlen(s) + 1);
      close(fildes[1]);

      sleep(1);  // give child process time to execute
    }
    printf("process %d will quit\n", getpid());

    return 0;
}
