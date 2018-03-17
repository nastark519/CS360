

/* Nathan Stark
CS 360 winter 2018
Lab 3: C data types 
Note this lab did not compile very while in ANCI C.*/

#include <stdio.h>
#include <stdlib.h> /* Makes it so EXIT_FAILURE and EXIT_SUCCESS are fond this will define both as constents.*/

#define MAX 10485760

/*Global file pointer*/
FILE * fp;

/* Making my struct for those extra credit points */
struct file{
	long fileSize;
	char unsigned fileData; /*I'll have to change my leak fix to free the the data stored here.*/
	int index;
}

/*read in the file into memory*/
void readFile(struct file * newFile){
	/* How many bytes are there in the file?  If you know the OS you're
	// on you can use a system API call to find out.  Here we use ANSI standard
	// function calls.*/
	long size = 0;					/* let us use the global var. */
	fseek( fp, 0, SEEK_END );		/* go to 0 bytes from the end*/
	size = ftell(fp);				/* how far from the beginning?*/
	rewind(fp);						/* go back to the beginning*/

	if( size < 1 || size > MAX )
	{
		printf("File size is not within the allowed range\n"); 
		fclose(fp);				/* close and free the file*/
		exit(EXIT_SUCCESS);		/* or return 0;*/
	}

	/* Now that we have the size lets put that into the struct we made.*/
	newFile->fileSize = size;

	/* now it will print the file size to 2 decimals points */
	printf( "File size: %.2f MB\n", (float)size/((float)MAX/10));

	/* Allocate memory on the heap for a copy of the file*/
	unsigned char * data = (unsigned char *)malloc(size);
	/* Read it into our block of memory*/
	size_t bytesRead = fread( data, sizeof(unsigned char), size, newFile );
	if( bytesRead != size )
	{
		printf( "Error reading file. Unexpected number of bytes read: %d\n",bytesRead );
		fclose(fp);				/* close and free the file*/
		exit(EXIT_SUCCESS);		/* or return 0;*/
	}
	/*store the data in the struct*/
	newFile->fileData = data;
}

/* gets the file name and opens a file*/
void initialize(int argc, char ** argv){
	/* Open the file given on the command line*/
	if( argc != 2 )
	{
		printf( "Usage: %s filename.mp3\n", argv[0] );
		return(EXIT_FAILURE);
	}
	/*Commented out FILE * because the file pointer has been set by the global var.*/
	/*FILE */fp = fopen(argv[1], "rb");
	if( fp == NULL )
	{
		printf( "Can't open file %s\n", argv[1] );
		return(EXIT_FAILURE);
	}
}

/* find the header in the file */
int findHeader(struct file* newFile){
	int i; 
	for ( i = 0; i < newFile->fileSize; i = i + 1){
		if((newFile->fileData[i] == 0xFF) && ((newFile->fileData[i + 1] & 0xF0) == 0xF0)){
			printf("\n");
			printf("Found mp3 Header \n");
			printf("Header is: %x%x%x%x \n",newFile->fileData[i],newFile->fileData[i+1], \
				newFile->fileData[i+2],newFile->fileData[i+3]);
			newFile->index = i;
			return -1;/* return on fff found*/
		}
	}
	return 1;/* return on fff not found*/
}

/*Checking function for if the file is layer 3 if it is print message
 and return value 0 if not return value 1.*/
int findLayer3(struct file* newFile){
	int flag = 1;
	
	unsigned char secondByte = (newFile->fileData[newFile->index + 1] & 0x0f);
	
	if(secondByte == 0x0A || secondByte == 0x0B)
	{
		printf("MP3 is Layer III \n");
		flag = 0;
	}
	return flag;
}

/*Functin to find the bit rate and then return that rate as an int.
 or print statement and return 0*/
int findBitRate(struct file* newFile){
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
			bitrate = -1;
	}
	return bitrate;
}

/*Find the frequency and return it as an int. or print a statement and return 0.*/
int findFrequency(struct file* newFile){
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
void findStatus(struct file* newFile){
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

int main( int argc, char ** argv ){
	initialize(argc, argv);/* Here we begin the modularize saving 13 lines int the code and adding the 
							ability  to call this function again if need be and not rewrite the code.*/

	struct file theFile;/* init a struct for the cofig. that we have setup with the struct file.*/

	readFile(&theFile); /* Go to the address of the file and load the data we want into the fields.
						   this will change the actual theFile struct and avoid copies.*/
	if( findHeader(&newFile) == 1){
		printf("File contains no 'FFF' header. \n"); 
		fclose(fp);					 	
		exit(EXIT_SUCCESS);
	}

	if(findLayer3(&newFile) == 1) {
		printf("MP3 is not Layer III \n");
		fclose(fp);
		exit(EXIT_SUCCESS);
	}

	int bitrate = findBitRate(&newFile);
	if(bitrate != -1){
		printf("Bitrate is %d kbps \n", bitrate);
	}

	int frequency = findFrequency(&newFile);

	printf("%.1f kHz \n",(float) frequency/(float) 1000);

	findStatus(&newFile);

	/* Clean up got rid of all occurrences of goto eliminating the need for END*/
	free(theFile.fileData); /* I have first freed data the unsigned char pointer, in order to plug them leaks. */
	fclose(fp);				/* close and free the file*/
	exit(EXIT_SUCCESS);		/* or return 0;*/
}
