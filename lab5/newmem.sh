#!/bin/bash

mem=()
c=0
while true
do
    mem+=({1..10})
    (( ++c ))

    if (( ${#mem[@]} > $1 ));
    then
        echo "out of memory $$" >> outs
        exit 0
    fi
done

