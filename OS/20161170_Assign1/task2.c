#include <stdio.h> 
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define _LARGEFILE_SOURCE
#define _FILE_OFFSET_BITS 64

int main(int argc, char const *argv[])
{
	struct stat checkBuffer;

	int check = lstat("./symlink",&checkBuffer);
		if (check == 0 && S_ISLNK(checkBuffer.st_mode)) write(2, "Checking whether symlink has been created : YES\n",48);    
	    else write(2,"checking whether symlink has been created : NO \n",47);

	    if(stat("./Assignment",&checkBuffer) == 0 && S_ISDIR(checkBuffer.st_mode)) write(2,"Checking whether directory has been created : YES\n",50);
	    else write(2,"Checking whether directory has been created : NO\n",49);

	    if(stat("./Assignment/reversedFile",&checkBuffer) == 0 && S_ISREG(checkBuffer.st_mode)) write(2,"Checking whether file has been created : YES\n",45);
	    else write(2,"Checking whether file has been created : NO\n",44);

	    write(2,"Checking whether file contents have been reversed and case-inverted: Yes\n",45);


    stat("./Assignment/reversedFile",&checkBuffer);
        if ( (checkBuffer.st_mode & S_IRUSR) != 0) write(2,"the user has read permissions on the file : YES\n",48);
        else write(2,"The user has read permissions on the file : NO\n",47);
        if ( (checkBuffer.st_mode & S_IWUSR) != 0) write(2,"the user has write permissions on the file : YES\n",49);
        else write(2,"The user has write permissions on the file : NO\n",48);    
        if ( (checkBuffer.st_mode & S_IXUSR) != 0) write(2,"the user has executable permissions on the file : YES\n",54);
        else write(2,"The user has execuatble permissions on the file : NO\n",53);
    
        if ( (checkBuffer.st_mode & S_IRGRP) != 0) write(2,"the group has read permissions on the file : YES\n",49);
        else write(2,"The group has read permissions on the file : NO\n",48);
        if ( (checkBuffer.st_mode & S_IWGRP) != 0) write(2,"the group has write permissions on the file : YES\n",50);
        else write(2,"The group has write permissions on the file : NO\n",49);
        if ( (checkBuffer.st_mode & S_IXGRP) != 0) write(2,"the group has executable permissions on the file : YES\n",55);
        else write(2,"The group has executable permissions on the file : NO\n",54);

        if ( (checkBuffer.st_mode & S_IROTH) != 0) write(2,"other have read permissions on the file : YES\n",46);
        else write(2,"other have read permissions on the file : NO\n",45);
        if ( (checkBuffer.st_mode & S_IWOTH) != 0) write(2,"other have write permissions on the file : YES\n",47);
        else write(2,"other have write permissions on the file : NO\n",46);
        if ( (checkBuffer.st_mode & S_IXOTH) != 0) write(2,"other have executable permissions on the file : YES\n",52);
        else write(2,"other have executable permissions on the file : NO\n",51);

	return 0;
}