#!/bin/bash

grep $1 /var/log/s3.log | tail -$2 | sed s/[^0-9\.]//g > stats.txt
/usr/bin/gnuplot <<_EOF
set term png
set output "stat.png"
set grid
set ylabel "$1"
set xlabel "Time in minutes"
plot "stats.txt" title "$1" with lines
pause -1
_EOF
display "stat.png" 
