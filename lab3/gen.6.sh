#!/bin/bash

while true
do

    sleep 0.1
    read line

    if [[ "$line" == "TERM" ]]
    then
        kill -SIGTERM $1
        echo "EXIT TERM 0"
        exit 0
    fi

    if [[ "$line" == "+" ]]
    then
        kill -USR1 $1
    fi

    if [[ "$line" == "*" ]]
    then
        kill -USR2 $1
    fi

done
