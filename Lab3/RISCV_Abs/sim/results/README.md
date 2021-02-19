This folder contain:

- resultsInnovus.txt that is the result of Verilog Netlist, provided by Cadence Innovus, simulation;

- resultsNetlist.txt that is the result of Verilog Netlist, provided by Synopsys Desifn Vision, simulation;

- resultsVHDL.txt that is the result of VHDL simulation.

To compare results obtained in the three cases, it is possible use bash command "diff" in the following way:

	diff resultsInnovus.txt resultsNetlist.txt
	
if it gives an empty results the two files are equal