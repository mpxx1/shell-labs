#!/bin/bash


num=1
mode="+"

setOperation() {
    echo "set operation $*"
    mode=$1
}

trap 'setOperation +' USR1
trap 'setOperation "*"' USR2

while true
do
    if [[ "$mode" == "+" ]]
    then
	num=$(( num + 2 ))
	echo "-> " $num
    fi 

    if [[ "$mode" == "*" ]]
    then
	num=$(( num * 2 ))
        echo "-> "$num
    fi

    sleep 5
done
