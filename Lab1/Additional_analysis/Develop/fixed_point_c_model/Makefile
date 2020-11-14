# -Wall compiling to obtain not only errors, but also all the warnings
# -o to assign a name to the final executable file
# link operation
MyFilter : main.o myfunction.o
	gcc -Wall main.o myfunction.o -o MyFilter
	
# -Wall compiling to obtain not only errors, but also all the warnings	
# -c option to obtain object file
main.o : main.c myfunction.h
	gcc -Wall -c main.c
	
# -Wall compiling to obtain not only errors, but also all the warnings	
# -c option to obtain object file
myfunction.o : myfunction.c myfunction.h
	gcc -Wall -c myfunction.c
	
# make Clean to execute this target
# to cancel eventual previous version	
Clear : 
	rm -f MyFilter main.o myfunction.o
