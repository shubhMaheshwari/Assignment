#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <ctype.h>

int main(int argc, char *argv[])
{
  char *file_name = argv[3];
  // char buffer1[1024] = {0};

  int sockfd, portno, n;
  struct sockaddr_in serv_addr;
  struct hostent *server;

  char buffer[255];

  if (argc < 3)
  {
    fprintf(stderr, "Usage %s hostname port.\n", argv[0]);
    exit(1);
  }

  portno = atoi(argv[2]);

  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if(sockfd < 0)
  {
    perror("Error opening socket!");
    exit(1);
  }

  server = gethostbyname(argv[1]);
  if (server == NULL)
  {
    perror("Error, No such host!");
    exit(1);
  }

  bzero(buffer, 255);
  serv_addr.sin_family = AF_INET;
  bcopy((char *) server->h_addr, (char *) &serv_addr.sin_addr.s_addr, server->h_length);
  serv_addr.sin_port = htons(portno);

  if (connect(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
    perror("Connection Failed!");
    exit(1);
  }
  // my code starts here 
  printf("Connection is established with the server!\n");
  send(sockfd , file_name , strlen(file_name) , 0 );
  printf("What should be the name of the saved file: ");
  char saved_file[1000];
  scanf("%s", saved_file);
  FILE *f;
  int characters = 0;
  f = fopen(saved_file, "ab");
  if(f == NULL) {
    printf("Error opening file");
    return 1;
  }
  while((characters = read(sockfd, buffer, 255)) > 0) fwrite(buffer, 1,characters,f);
  if(characters < 0) printf("\n Read Error \n");
  printf("The file has been successfully recieved!\n");
  close(sockfd);
  return 0;
}
