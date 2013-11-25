#!/bin/bash

grep $1 /var/log/s3.log | tail -$2 | sed s/[^0-9\.]//g > /var/www/aws/$1.txt
/usr/bin/gnuplot <<_EOF
set term png
set output "/var/www/aws/$1.png"
set grid
set ylabel "$1"
set xlabel "Time in minutes"
plot "/var/www/aws/$1.txt" title "$1" with lines
pause -1
_EOF

