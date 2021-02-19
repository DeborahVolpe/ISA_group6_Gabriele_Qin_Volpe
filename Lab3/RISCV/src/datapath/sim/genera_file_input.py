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
N_data_test = 100;
lista_sel = ["000", "001", "010", "011", "100"];
lista_opcode2 = ["0", "1"];
lista_opcode5 = ["0", "1"];
lista_sub_add_n = ["0", "1"];

for n in range (N_data_test):
	in1 = random.randrange(0, 2**32)	
	in2 = random.randrange(0, 2**32)
	PC = random.randrange(0, 2**32)
	immediate = random.randrange(0, 2**20)
	shamt = random.randrange(0, 2**5)
		
	in1_str = format(in1, 'b').zfill(32)
	in2_str = format(in2, 'b').zfill(32)	
	PC_str = format(PC, 'b').zfill(32)
	immediate_str = format(immediate, 'b').zfill(20)
	sel_str = random.choice(lista_sel)
	shamt_str = format(shamt, 'b').zfill(5)
	opcode2_str = random.choice(lista_opcode2)
	opcode5_str = random.choice(lista_opcode5)
	sub_add_n_str = random.choice(lista_sub_add_n)
	

	file_input.write(in1_str + " " + in2_str + " "+ PC_str + " " + immediate_str + " " + sel_str + " " + shamt_str + " " + opcode2_str + " " + opcode5_str + " " + sub_add_n_str + "\n")

file_input.close()
