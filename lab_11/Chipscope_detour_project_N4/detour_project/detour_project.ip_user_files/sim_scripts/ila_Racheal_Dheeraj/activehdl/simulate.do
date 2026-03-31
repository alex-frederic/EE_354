onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ila_Racheal_Dheeraj -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ila_Racheal_Dheeraj xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ila_Racheal_Dheeraj.udo}

run -all

endsim

quit -force
