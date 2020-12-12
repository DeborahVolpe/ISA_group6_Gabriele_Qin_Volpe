import random
import sys

nome_file_in = "input.txt"

#opening input file
try:
	file_input = open(nome_file_in, 'w')
except:
	print("errore impossibile aprire il file" + nome_file_in + "\n")
	sys.exit()

# number of input data combinations
N_data_test = 10000;

for n in range (N_data_test):
	A = random.randrange(0, 2**24)	
	B = random.randrange(0, 2**24)			

	#binary number conversion on 24 bits		
	A_str = format(A, 'b').zfill(24)
	B_str = format(B, 'b').zfill(24)					

	file_input.write(A_str + " " + B_str + "\n")

file_input.close()
