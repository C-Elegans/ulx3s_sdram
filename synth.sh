#!/bin/bash
yosys -p "synth_ecp5 -json ulx3s_top.json" ulx3s_top.v top.v sdram_controller3.v driver.v pll.v
nextpnr-ecp5 --json ulx3s_top.json --lpf ulx3s_v20.lpf --85k --package CABGA381 --textcfg ulx3s_top.config
ecppack ulx3s_top.config ulx3s_top.bit
