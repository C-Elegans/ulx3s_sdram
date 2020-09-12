#!/bin/bash
set -e
iverilog -Dden256Mb -Dsg6a -Dx16 -DSIMULATION -o testbench testbench.v sdram_controller3.v sdr.v 
vvp testbench
