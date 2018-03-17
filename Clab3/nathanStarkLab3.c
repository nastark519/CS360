/* CS315 Lab 3: C data types
@author Nathan Stark
@Helped by and worked with Khorben Boyer*/

#include <stdio.h>
#include <stdlib.h> /* Makes it so EXIT_FAILURE and EXIT_SUCCESS are fond this will define both as constents.*/

#define MAX 1048576
#define MIN 1

/* global variable to replace all others. Is a file pointer. Hence fp => filepointer.*/
FILE * fp;

/*a struct hopefully I will get some extra points for this.*/
struct file {
	
	long fileSize;
	unsigned char * fileData;
	int index;
};


/*Lines 21 - 44 only read in the file into memory, put that into a
function called readFile. We could make all variables global to do that? No way, that’s a
hack. We can get by with only one global variable: File * fp, everything else needs to be
passed in as an argument or returned as the return value. If we have a lot to pass in and out,
maybe we could just pass in a pointer to a struct? Yeah, that would be cool. Probably get
extra credit for that one.*/
void readFile(struct file * newFile)
{
	/* How many bytes are there in the file?  If you know the OS you're
	// on you can use a system API call to find out.  Here we use ANSI standard
	// function calls.*/
	long size = 0;
	fseek( fp, 0, SEEK_END );    /* go to 0 bytes from the end*/
	size = ftell(fp);            /* how far from the beginning?*/
	rewind(fp);                  /* go back to the beginning*/

	/*Check for the accepted file size exit if not.*/
	if( size < MIN || size > MAX * 10 )
	{
			printf("File size is not within the allowed range\n");
			fclose(fp);
			exit(EXIT_SUCCESS);

	}
	
	/* stores file size into struct data field */
	newFile->fileSize = size;

	
	printf( "File size: %.2f MB\n", (float)size / (float)MAX ); /*prints to two dec. as a float.*/
	
	/* Allocate memory on the heap for a copy of the file*/
	unsigned char * data = (unsigned char *)malloc(size);
	/* Read it into our block of memory*/
	size_t bytesRead = fread( data, sizeof(unsigned char), size, fp );
	
	/*Check to make sure that the data read is not less than what we are expecting and not more that what we are expecting.
	If either of those are true exit the program to avoid errors.*/
	if( bytesRead != size )
	{
			printf( "Error reading file. Unexpected number of bytes read: %ld\n",bytesRead );
			fclose(fp);
			exit(EXIT_SUCCESS);  /*got rid of the goto's and added the code that the flag would have executed.*/
	}
	/*points to the file data.*/
	newFile->fileData = data;
}/*this is done no more to fix or change.*/


/* Gets the file name and opens and calects 
info from the file that is being pointed at.*/
int  initialize(int argc, char ** argv)
{
	
	if( argc != 2 )
    {
		printf( "Usage: %s filename.mp3\n", argv[0] );
        return(EXIT_FAILURE);
    }

    fp = fopen(argv[1], "rb");
    if( fp == NULL )
    {
        printf( "Can't open file %s\n", argv[1] );
        return(EXIT_FAILURE);
    }
	return 0;
}/*this is done no more to fix or change.*/

/* This function will find the fff header in the file */
int findHeader(struct file* newFile)
{
	int i; 
	for ( i = 0; i < newFile->fileSize; i = i + 1)
	{
		if((newFile->fileData[i] == 0xFF) && ((newFile->fileData[i + 1] & 0xF0) == 0xF0)) 
		{
			printf("\n");
			printf("Found mp3 Header \n");
			printf("Header is: %x%x%x%x \n",newFile->fileData[i],newFile->fileData[i+1], \
				newFile->fileData[i+2],newFile->fileData[i+3]);

 
			newFile->index = i;
			return -1;
		} 
	}


	return 1;
}

/*Checking function for if the file is layer 3 if it is print message
 and return value 0 if not return value 1.*/
int findLayer3(struct file* newFile)
{
	int flag = 1;
	
	unsigned char secondByte = (newFile->fileData[newFile->index + 1] & 0x0f);
	
	if(secondByte == 0x0A || secondByte == 0x0B)
	{
		printf("MP3 is Layer III \n");
		flag = 0;
	}
	return flag;
}

/*Functin to find the bit rate and then return that rate as an int. or print statement and return 0*/
int findBitRate(struct file* newFile)
{
	int bitrate = 0;
	
	unsigned char bitRate = (newFile->fileData[ newFile->index + 2] & 0xF0);

	switch(bitRate)
	{	
        	case 0x10:
			bitrate = 32;
			break;

		case 0x20:
			bitrate = 40;
			break;

		case 0x30:
			bitrate = 48;
			break;
		
		case 0x40:
			bitrate = 56;
			break;
	
		case 0x50:
			bitrate = 64;
			break;

		case 0x60:
			bitrate = 80;
			break;

		case 0x70:
			bitrate = 96;
			break;

		case 0x80:
			bitrate = 112;
			break;

		case 0x90:
			bitrate = 128;
			break;
		
		case 0xA0:
			bitrate = 160;
			break;

		case 0xB0:
			bitrate = 192;
			break;

		case 0xC0:
			bitrate = 224;
			break;

		case 0xD0:
			bitrate = 256;
			break;

		case 0xE0:
			bitrate = 320;
			break;

		default:
			printf("no matching bit rate found");
	}


	return bitrate;
}

/*Find the frequency and return it as an int. or print a statement and return 0.*/
int findFrequency(struct file* newFile)
{
	int frequency = 0;
	
	unsigned char Freq = (newFile->fileData[ newFile->index + 2] & 0xf);

 	switch(Freq)
	{	
        	case 0x00:
			frequency = 44100;
			break;

		case 0x04:
			frequency = 48000; 
			break;

		case 0x08:
			frequency = 32000;
			break;
		default:
			printf("no matching frequency found");
	}
	return frequency;
}

/*Check if the file is copyrighted print a message about it.*/
void findStatus(struct file* newFile)
{
	
	unsigned char status = (newFile->fileData[ newFile->index + 3] & 0xf) >> 2 ;

 	switch(status)
	{	
		case 0x00:
			printf("Song is not copyrighted, and is a copy of original media. \n");			
			break;
			
		case 0x01:
			printf("Song is not copyrighted, and is original media. \n");
			break;
			
		case 0x02:
			printf("Song is copyrighted, and is a copy of original media. \n");
			break;
			
		case 0x03:
			printf("Song is copyrighted, and is on original media. \n");
			break;
			
		default:
			printf("no matching frequency found");
	}
}


int main( int argc, char ** argv )
{
	initialize(argc, argv);
	
	/* We now have a pointer to the first byte of data in a copy of the file, have fun
	// unsigned char * data    <--- this is the pointer*/

	struct file newFile;  /*initialize the struct for the files data, size, and index*/
	readFile(&newFile);  /*pointer to the address.*/
	
	/* see findHeader() function for details.*/
	if( findHeader(&newFile) == 1)
	{
		printf("File contains no 'FFF' header. \n"); 
		fclose(fp);					 	
		exit(EXIT_SUCCESS);
	}

	/* see findLayer3() function for details.*/
	if(findLayer3(&newFile) == 1) 
	{
		printf("MP3 is not Layer III \n");
		fclose(fp);					 	
		exit(EXIT_SUCCESS);
	}

	/* find the bit rate of mp3 file 
	lets add in an if statement*/
	int bitrate = findBitRate(&newFile);

	printf("Bitrate is %d kbps \n", bitrate);
	
	int frequency = findFrequency(&newFile);

	printf("%.1f kHz \n",(float) frequency/(float) 1000);

	findStatus(&newFile);
	
	/* Clean up*/
	free(newFile.fileData);       /*fixing the leaks and freeing the memery*/
	fclose(fp);                             /* close and free the file*/
	exit(EXIT_SUCCESS);             /* or return 0;*/
}






