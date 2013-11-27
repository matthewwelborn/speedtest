#!/bin/bash

output_path="/var/www/aws/"

usage()
{
cat << EOF
	Usage: $0 [Latency|DNS|Speed|Response] {n minutes}
	Example: $0 DNS 60
		Shows DNS response times for the last sixty minutes
	
	-h 	Shows usage
	-p 	Path to save files
	-s 	Search string for log
	-m 	Minutes to display (really the number of lines)
	-n 	File name to use for saves.
	-d 	Display the image after creating
	-y 	y scale
EOF
}

display=0
search=$1
minutes=$2
name=$search
xscale="[]"
yscale="[]"

while getopts "hs:m:n:p:x:y:d" args
do
	case $args in
	h)
		usage
		exit 1
		;;
	p)
		output_path=$OPTARG
		;;
	s)
		search=$OPTARG
		;;
	m)
		minutes=$OPTARG
		;;
	n)
		name=$OPTARG
		;;
	d)
		display=1
		;;
	x)
		xscale="[$OPTARG]"
		;;
	y)
		yscale="[$OPTARG]"
		;;
	?)
		usage
		exit 1 
		;;
	esac
done

grep $search /var/log/s3.log | tail -$minutes | sed s/[^0-9\.]//g > ${output_path}/${name}.txt
/usr/bin/gnuplot <<_EOF
set term png
set output "${output_path}/${name}.png"
set grid
set ylabel "$search"
set xlabel "Time in minutes"
plot $xscale $yscale "${output_path}/${name}.txt" title "$search" with lines
pause -1
_EOF

if [ $display -eq 1 ]
then
	display ${output_path}${name}.png
fi

