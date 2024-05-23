#!/bin/bash

mem=()
c=0
rm -rf report2.log
while true
do
    mem+=({1..10})
    (( ++c ))
    
    if (( c % 100000 == 0 ))
    then
        echo "${#mem[@]}" >> report2.log
    fi
done

