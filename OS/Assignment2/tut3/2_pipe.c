#include<stdio.h>
#include<string.h>
#include<unistd.h>
#include<sys/stat.h>
#include<fcntl.h>

int main(){
    char s[102], f_content[102];
    int fildes[2];

    // create a pipe. data -> fildes[1] -> fildes[0]
    if(pipe(fildes) != 0)
      perror("pipe failed");

    scanf("%s", s);
    printf("\"%s\" will be written to fildes[1]\n", s);
    write(fildes[1], s, strlen(s) + 1);
    close(fildes[1]);

    read(fildes[0], f_content, 100);
    printf("Contents of fildes[0]: %s\n", f_content);
    close(fildes[0]);

    return 0;
}
