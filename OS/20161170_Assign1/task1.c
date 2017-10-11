#include <stdio.h> 
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define _LARGEFILE_SOURCE
#define _FILE_OFFSET_BITS 64

int main(int argc, char *argv[]){

	if(argc != 2){
		printf("Usage: ./a.out [filename]\n");
		return 0;
	}

	// make a new directory
	mkdir("./Assignment", S_IRWXU);
	// Name of the files
	int inputFile,outputFile;

	inputFile = open(argv[1], O_RDONLY);

	if(inputFile < 0){
		// open returns -1 if the file failed to open
		fprintf(stderr, "Failed to open file \"%s\"\n", argv[1]);
		exit(1);
	}
	
	outputFile = open("./Assignment/reversedFile",O_WRONLY|O_CREAT, 0600);

	if(outputFile < 0){
		// open returns -1 if the file failed to open
		fprintf(stderr, "Failed to open file \"%s\"\n", argv[1]);
		exit(1);
	}

	char word[1];

	lseek(inputFile,-1,SEEK_END);
	
	while(lseek(inputFile,-2,SEEK_CUR) >=0){
		read(inputFile,word,1);
		if(word[0] >96 && word[0] < 123) word[0] -=32;
		
		else if(word[0] >64 && word[0] < 90) word[0] +=32;

		write(outputFile,word,1);
	}


	close(inputFile);
	close(outputFile);

	symlink("./Assignment/reversedFile","symlink");

	return 0;
}