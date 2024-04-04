#!/bin/bash

echo $$ > .pid5

while true 
do
	
	sleep 0.1
	
	echo -n "inp: "
	read line
	echo "$line" > pipe

done
