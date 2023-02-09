set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# clk
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 [get_ports {clk}];

# switches
set_property -dict { PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [get_ports { resetn }];

# Puerto VGA
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports { RED[0] }];
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports {RED[1]} ];
set_property -dict { PACKAGE_PIN C5 IOSTANDARD LVCMOS33 } [get_ports {RED[2]} ];
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports {RED[3]} ];
set_property -dict { PACKAGE_PIN C6 IOSTANDARD LVCMOS33 } [get_ports {GREEN[0]} ];
set_property -dict { PACKAGE_PIN A5 IOSTANDARD LVCMOS33 } [get_ports {GREEN[1]} ];
set_property -dict { PACKAGE_PIN B6 IOSTANDARD LVCMOS33 } [get_ports {GREEN[2]} ];
set_property -dict { PACKAGE_PIN A6 IOSTANDARD LVCMOS33 } [get_ports {GREEN[3]} ];
set_property -dict { PACKAGE_PIN B7 IOSTANDARD LVCMOS33 } [get_ports {BLUE[0]} ];
set_property -dict { PACKAGE_PIN C7 IOSTANDARD LVCMOS33 } [get_ports {BLUE[1]} ];
set_property -dict { PACKAGE_PIN D7 IOSTANDARD LVCMOS33 } [get_ports {BLUE[2]} ];
set_property -dict { PACKAGE_PIN D8 IOSTANDARD LVCMOS33 } [get_ports {BLUE[3]} ];
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports {HS} ];
set_property -dict { PACKAGE_PIN B12 IOSTANDARD LVCMOS33 } [get_ports {VS} ];

# leds
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports { out_byte[0] }];
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports { out_byte[1] }];
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports { out_byte[2] }];
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { out_byte[3] }];
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { out_byte[4] }];
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { out_byte[5] }];
set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { out_byte[6] }];
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { out_byte[7] }];

set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { out_byte_en }];
set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports { trap }]