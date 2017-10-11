#include<stdio.h>
#include<unistd.h>
#include<sys/stat.h>
#include<fcntl.h>

int main(int argc, char *argv[]) {

    if(argc != 2) {
      printf("Usage: %s filename\n", argv[0]);
      return 0;
    }

    int fd;
    // open the file to replace stdout
    fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);

    if(fd == -1) {
      perror("Failed to open file");
    }

    printf("The first line\n");

    close(1); // not required, but a good practice

    // use dup2() to duplicate the fd
    if(dup2(fd, 1) != 1)  // 1 refers to stdout
      perror("dup2 fail");

    // close the original fd
    close(fd);

    printf("The second line\n");

    return 0;
}
