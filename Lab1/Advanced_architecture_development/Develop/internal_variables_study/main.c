#include<stdio.h>
#include<stdlib.h>
#include "myfunction.h"

int main (int argc, char **argv)
{
  FILE *fp_in = NULL;
  FILE *fp_out = NULL;

  int x;
  int y;
  int i;
  int wait = 0;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n", argv[1]);
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do{
    y = myfilter(x);
    if ( wait > 1){
    	fprintf(fp_out,"%d\n", y);
    }
    fscanf(fp_in, "%d", &x);
    wait ++;
  } while (!feof(fp_in));

  for (i = 0; i< 2; i++){
	y = myfilter(0);
	fprintf(fp_out, "%d\n", y);	
  }


  fclose(fp_in);
  fclose(fp_out);

  return 0;

}