This folder contains:

- report folder : contains all report obtained using the prepared scripts with Synopsys;

- analyze.do : to analyze all necessary VHDL files for synthesis. This script is call by all the other script;

- script_syn1 : to syntetize with a clock imposed equal to 0 ns and using ungroup -all -flatten command;

- script_syn1_ver : to syntetize with a clock imposed equal to the minimum and using ungroup -all -flatten command;

- script_syn2 : to syntetize with a clock imposed equal to 0 ns and forces CSA architecture for the multiplier;

- script_syn2_ver : to syntetize with a clock imposed equal to the minimum and forces CSA architecture for the multiplier;

- script_syn2 : to syntetize with a clock imposed equal to 0 ns and forces PPARCH architecture for the multiplier;

- script_syn2_ver : to syntetize with a clock imposed equal to the minimum and forces PPARCH architecture for the multiplier.