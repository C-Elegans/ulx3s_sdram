#!/bin/bash
set -e
iverilog -Dden256Mb -Dsg6a -Dx16 -DSIMULATION -o driver_tb driver_tb.v top.v driver.v sdram_controller3.v IS42S16160.v
vvp driver_tb
