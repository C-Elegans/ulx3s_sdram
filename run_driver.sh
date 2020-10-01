#!/bin/bash
set -e
iverilog -Dden256Mb -Dsg6a -Dx16 -DSIMULATION -o driver_tb driver_tb.v top.v driver.v sdram_controller3.v sdr.v 
vvp driver_tb
