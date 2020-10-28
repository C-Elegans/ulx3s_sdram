#!/bin/bash
ecppll -n pll -f pll.v -i 25 -o 100 --clkout0_name CLOCK_100 --clkout1 100 --clkout1_name CLOCK_100_del_3ns --phase1 180 --clkout2 50 --clkout2_name CLOCK_50
