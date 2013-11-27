#!/bin/bash

# Set the path for the images to be saved.
# The path should be served by apache.
# A central webserver will be loading and displaying these images from
# different servers

path="/var/www/aws"


# ./savegraph usage is:
# ./savegraph -s {search string} -m {number of log entries to review} -p {path to save images}
#             -n {name to use when saving images} -y {range of numbers to show on y axis}
# Currently we're saving images for latency, speed, response code and dns speed at
# 60 minute, 180 minute and 24 hour (1440 minute) graphs

./savegraph.sh -s Latency -m 60 -p $path -n Latency -y 0:3
./savegraph.sh -s Speed -m 60 -p $path -n Speed -y 0:500000
./savegraph.sh -s DNS -m 60 -p $path -n DNS -y 0:1
./savegraph.sh -s Response -m 60 -p $path -n Response -y 0:500
./savegraph.sh -s Latency -m 180 -p $path -n Latency-180 -y 0:3
./savegraph.sh -s Speed -m 180 -p $path -n Speed-180 -y 0:500000
./savegraph.sh -s DNS -m 180 -p $path -n DNS-180 -y 0:1
./savegraph.sh -s Response -m 180 -p $path -n Response-180 -y 0:500
./savegraph.sh -s Latency -m 1440 -p $path -n Latency-1d -x 0:1440 -y 0:3
./savegraph.sh -s Speed -m 1440 -p $path -n Speed-1d -x 0:1440 -y 0:500000
./savegraph.sh -s DNS -m 1440 -p $path -n DNS-1d -x 0:1440 -y 0:1
./savegraph.sh -s Response -m 1440 -p $path -n Response-1d -x 0:1440 -y 0:500

