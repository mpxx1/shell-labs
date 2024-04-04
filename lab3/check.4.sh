#!/bin/bash


ni=0

while true 
do 
	cpu_usage=$(top -p $1 -b -n 1 -d 0.1 | tail -1 | awk '{ printf "%.0f", $9 }')
	
	if (( $(echo "$cpu_usage > 10" | bc -l) ));
	then
        	renice -n "$ni" $1
		((++ni))
	fi
done
