#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main(int argc, char const *argv[]) {
  if (argc < 2) {
    fprintf(stderr, "Port number missing.\n Program stopped!");
    exit(1);
  }
  char buffer1[1024] = {0};
  int sockfd, newsockfd, portno, n;
  char buffer[255];
  struct sockaddr_in serv_addr, cli_addr;
  socklen_t client_len;
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if(sockfd < 0) {
    perror("Error creating socket");
    exit(1);
  }
  bzero((char *) &serv_addr, sizeof(serv_addr));
  portno = atoi(argv[1]);
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_addr.s_addr = INADDR_ANY;
  serv_addr.sin_port = htons(portno);
  if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
    perror("Binding Failed!");
    exit(1);
  }
  listen(sockfd, 5);
  client_len = sizeof(cli_addr);
  newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &client_len);
  if (newsockfd < 0) {
    perror("Error in accept!");
    exit(1);
  }
  printf("Client connected!\n");
  int value = read( newsockfd , buffer1, 1024);
  FILE *fp;
  fp = fopen(buffer1, "rb");
  int flag = 1;
  while(1) {
    int characters = fread(buffer, 1, 255, fp);
    if(characters > 0) {
      if (flag == 1) {
        printf("Sending File...\n");
        flag = 0;
      }
      write(newsockfd, buffer, characters);
    }
    if (characters < 255) {
        if (feof(fp)) printf("End of file\n");
        if (ferror(fp)) printf("Error reading\n");
        break;
    }
  }
  close(newsockfd);
  sleep(1);
  close(sockfd);
  return 0;
}
