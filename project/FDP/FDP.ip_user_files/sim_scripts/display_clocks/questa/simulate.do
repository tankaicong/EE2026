onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib display_clocks_opt

do {wave.do}

view wave
view structure
view signals

do {display_clocks.udo}

run -all

quit -force
