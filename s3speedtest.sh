#!/bin/bash

logfile="/var/log/s3.log"

getfile="https://s3.amazonaws.com/smock_staging/0d4c4027-8e78-4ec0-bced-8d0f63140d12.jpeg.jpg" #100KB
#getfile="https://s3.amazonaws.com/smock_staging/0682cbe6-2fa4-45a8-be48-77bbb4fcecdb.jpeg"    #500KB
#getfile="https://s3.amazonaws.com/smock_staging/10159/bc_back.pdf"                            #1MB
#getfile="https://s3.amazonaws.com/smock_staging/10611/bc_front.pdf"                           #1.9MB
#getfile="https://s3.amazonaws.com/smock_staging/0ef36f9a-4584-4ea5-a5c1-b994bdb203fc.tiff"    #9.2MB

usage()
{
cat<<EOF
usage: $0 options
  -h    Shows this message
  -t    Test outputs data - does not write to log
EOF
}

logformat="\n  Size:        %{size_download} Bytes\n  Response:    %{http_code}\n  Latency:     %{time_starttransfer} seconds\n  Speed:       %{speed_download} Bytes/sec\n  DNS Time:    %{time_namelookup} seconds\n  Pretransfer: %{time_pretransfer} seconds\n  Total Time:  %{time_total}\n\n"

buildlog()
{
logdate=`date`
curldata="`curl -sSw "$logformat" $getfile -o /dev/null`"
log="[${logdate}] ${curldata}"
}

while getopts "ht" arg; do
case $arg in
  h)
    usage 
    exit 1
	;;
  t)
    buildlog
    echo "$log" 
	exit
    ;;
  *)
	buildlog
	if [ -w "$logfile" ]
	then
	  echo $log >> $logfile
	else
	  echo "Unable to write to log file!"
	  exit 1
	fi
	exit
	;;
esac
done

