### Nexys N4 to Nexys A7 XDC conversion script: 
### Author : Sharath Krishnan - sharath@usc.edu 

set_property PACKAGE_PIN E3 [get_ports ClkPort]							
	set_property IOSTANDARD LVCMOS33 [get_ports ClkPort]
	create_clock -add -name ClkPort -period 10.00 [get_ports ClkPort]

set_property PACKAGE_PIN J15 [get_ports {Sw0}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw0}]

set_property PACKAGE_PIN L16 [get_ports {Sw1}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw1}]

set_property PACKAGE_PIN M13 [get_ports {Sw2}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw2}]

set_property PACKAGE_PIN R15 [get_ports {Sw3}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw3}]

set_property PACKAGE_PIN H17 [get_ports {Ld0}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld0}]

set_property PACKAGE_PIN K15 [get_ports {Ld1}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld1}]

set_property PACKAGE_PIN J13 [get_ports {Ld2}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld2}]

set_property PACKAGE_PIN N14 [get_ports {Ld3}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld3}]

set_property PACKAGE_PIN R18 [get_ports {Ld4}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld4}]

set_property PACKAGE_PIN V17 [get_ports {Ld5}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld5}]

set_property PACKAGE_PIN U17 [get_ports {Ld6}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld6}]

set_property PACKAGE_PIN U16 [get_ports {Ld7}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld7}]

set_property PACKAGE_PIN T10 [get_ports {Ca}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ca}]

set_property PACKAGE_PIN R10 [get_ports {Cb}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Cb}]

set_property PACKAGE_PIN K16 [get_ports {Cc}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Cc}]

set_property PACKAGE_PIN K13 [get_ports {Cd}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Cd}]

set_property PACKAGE_PIN P15 [get_ports {Ce}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Ce}]

set_property PACKAGE_PIN T11 [get_ports {Cf}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Cf}]

set_property PACKAGE_PIN L18 [get_ports {Cg}] 
	set_property IOSTANDARD LVCMOS33 [get_ports {Cg}]

set_property PACKAGE_PIN H15 [get_ports Dp] 
	set_property IOSTANDARD LVCMOS33 [get_ports Dp]

set_property PACKAGE_PIN J17 [get_ports {An0}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An0}]

set_property PACKAGE_PIN J18 [get_ports {An1}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An1}]

set_property PACKAGE_PIN T9 [get_ports {An2}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An2}]

set_property PACKAGE_PIN J14 [get_ports {An3}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An3}]

set_property PACKAGE_PIN P14 [get_ports {An4}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An4}]

set_property PACKAGE_PIN T14 [get_ports {An5}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An5}]

set_property PACKAGE_PIN K2 [get_ports {An6}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An6}]

set_property PACKAGE_PIN U13 [get_ports {An7}] 
	set_property IOSTAnDARD LVCMOS33 [get_ports {An7}]

set_property PACKAGE_PIN N17 [get_ports BtnC] 
	set_property IOSTANDARD LVCMOS33 [get_ports BtnC]

set_property PACKAGE_PIN P17 [get_ports BtnL] 
	set_property IOSTANDARD LVCMOS33 [get_ports BtnL]

set_property PACKAGE_PIN M17 [get_ports BtnR] 
	set_property IOSTANDARD LVCMOS33 [get_ports BtnR]

set_property PACKAGE_PIN L13 [get_ports QuadSpiFlashCS]					
	set_property IOSTANDARD LVCMOS33 [get_ports QuadSpiFlashCS]

#set_property PACKAGE_PIN L18 [get_ports RamCS]					
#	set_property IOSTANDARD LVCMOS33 [get_ports RamCS]

#set_property PACKAGE_PIN H14 [get_ports MemOE]					
#	set_property IOSTANDARD LVCMOS33 [get_ports MemOE]

#set_property PACKAGE_PIN R11 [get_ports MemWR]					
#	set_property IOSTANDARD LVCMOS33 [get_ports MemWR]

