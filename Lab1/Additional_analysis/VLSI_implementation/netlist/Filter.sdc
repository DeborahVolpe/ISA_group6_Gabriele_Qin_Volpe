###################################################################

# Created by write_sdc on Fri Nov  6 11:46:31 2020

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_load -pin_load 3.40189 [get_ports {DOUT[10]}]
set_load -pin_load 3.40189 [get_ports {DOUT[9]}]
set_load -pin_load 3.40189 [get_ports {DOUT[8]}]
set_load -pin_load 3.40189 [get_ports {DOUT[7]}]
set_load -pin_load 3.40189 [get_ports {DOUT[6]}]
set_load -pin_load 3.40189 [get_ports {DOUT[5]}]
set_load -pin_load 3.40189 [get_ports {DOUT[4]}]
set_load -pin_load 3.40189 [get_ports {DOUT[3]}]
set_load -pin_load 3.40189 [get_ports {DOUT[2]}]
set_load -pin_load 3.40189 [get_ports {DOUT[1]}]
set_load -pin_load 3.40189 [get_ports {DOUT[0]}]
set_load -pin_load 3.40189 [get_ports VOUT]
create_clock [get_ports CLK]  -period 4.8  -waveform {0 2.4}
set_clock_uncertainty 0.07  [get_clocks CLK]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[10]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[9]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[8]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[7]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[6]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[5]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[4]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[3]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[2]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[1]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {DIN[0]}]
set_input_delay -clock CLK  -max 0.5  [get_ports VIN]
set_input_delay -clock CLK  -max 0.5  [get_ports RST_n]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[10]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[9]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[8]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[7]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[6]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[5]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[4]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[3]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[2]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[1]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {b0[0]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[10]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[9]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[8]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[7]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[6]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[5]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[4]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[3]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[2]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[1]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c0[0]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[10]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[9]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[8]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[7]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[6]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[5]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[4]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[3]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[2]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[1]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c1[0]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[10]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[9]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[8]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[7]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[6]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[5]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[4]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[3]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[2]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[1]}]
set_input_delay -clock CLK  -max 0.5  [get_ports {c2[0]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[10]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[9]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[8]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[7]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[6]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[5]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[4]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[3]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[2]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[1]}]
set_output_delay -clock CLK  -max 0.5  [get_ports {DOUT[0]}]
set_output_delay -clock CLK  -max 0.5  [get_ports VOUT]
