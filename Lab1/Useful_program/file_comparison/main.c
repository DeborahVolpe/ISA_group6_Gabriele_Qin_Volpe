#include <stdio.h>
#include <stdlib.h>

int main ( int argc, char** argv )
{
	FILE* fp_output_reference = NULL;
	FILE* fp_output = NULL;
	int flag = 0, c_ref, c, temp_ref, temp;
	int max_difference = 0, diff;
 	
 	 /// check the command line
  	if (argc != 3)
	{
    		fprintf(stderr, "Use: %s <output_reference_file> <output_file>\n", argv[0]);
    		exit(1);
  	}

  	/// open files
 	fp_output_reference = fopen(argv[1], "r");
  	if (fp_output_reference == NULL)
 	{
    		fprintf(stderr,"Error: cannot open %s\n", argv[1]);
   		exit(2);
  	}

  	fp_output = fopen(argv[2], "r");
  	if (fp_output == NULL)
 	{
    		fprintf(stderr,"Error: cannot open %s\n", argv[2]);
		fclose(fp_output_reference);
   		exit(3);
  	}

	while ( flag == 0 )
	{
		c_ref = fscanf ( fp_output_reference, "%d", &temp_ref);
		c = fscanf ( fp_output, "%d", &temp);

		if ( c_ref == EOF && c == EOF )
		{
			flag = 1;
		}
		else
		{
			if ( c_ref == EOF || c == EOF )
			{
				fprintf(stderr, "Error: the two files to compare must have the same lenght\n");
				fclose(fp_output);
				fclose(fp_output_reference);
				exit(4);
			}
			else
			{
				if ( c_ref != 1 || c != 1 )
				{
					fprintf(stderr, "Data format in file not correct!");
					fclose(fp_output);
					fclose(fp_output_reference);
					exit(5);
				}
				else
				{
					diff = abs(temp_ref - temp);
					if ( diff > max_difference )
					{
						max_difference = diff;
					}
				}
			}	

			
		} 
	}

	fclose(fp_output);
	fclose(fp_output_reference);

	if ( max_difference == 0 )
	{
		fprintf ( stdout, "The two file are perfectly equal!");
	}
	else
	{
		fprintf( stdout, "The maximum difference is %d", max_difference);
	}
	
	exit(0);

}
