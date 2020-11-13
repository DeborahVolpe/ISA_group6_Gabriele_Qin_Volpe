# -Wall compiling to obtain not only errors, but also all the warnings
# -o to assign a name to the final executable file
# link operation
MyProgram : main.o
	gcc -Wall main.o -o MyProgram

# -Wall compiling to obtain not only errors, but also all the warnings	
# -c option to obtain object file	
main.o : main.c
	gcc -Wall -c main.c
	
# make Clean to execute this target
# to cancel eventual previous version		
Clear : 
	rm -f MyProgram main.o
