#!/bin/bash

mem=()
c=0
rm -rf report.log

while true
do
    mem+=({1..10})
    (( ++c ))
    
    if (( c % 100000 == 0 ))
    then
        echo "${#mem[@]}" >> report.log
    fi
done

