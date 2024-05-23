#!/bin/bash

rm -rf outs
for (( i=0; i < 30; ++i ))
do
    ./newmem.sh $1 &
    sleep 1
done

