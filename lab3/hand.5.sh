#!/bin/bash

num=1
mode="+"

(tail -f pipe) | 
while true
do
	read line

	if [[ "$line" == "+" ]] || [[ "$line" == "*" ]]
    	then
        	mode=$line
        	echo "Current operation: $mode"
		continue
	fi

	if [[ "$line" == "QUIT" ]]
	then
		
		kill 15 $(cat .pid5)
		rm -f .pid5
		echo "success; exit 0"
		exit 0

	else
		
		if [[ "$line" =~ ^[[:digit:]]+ ]]
		then
			
			if [[ "$mode" == "+" ]]
                	then
                    		num=$(echo $num $line | awk '{print $1 + $2}')
                    		echo "->" $num
                	else
                    		num=$(echo $num $line | awk '{print $1 * $2}')
                    		echo "-> " $num
                	fi

		else 
			kill 15 $(cat .pid5)
			rm -f .pid5
			echo "parse digit error; exit 1"
			exit 1
		fi	

	fi

done
