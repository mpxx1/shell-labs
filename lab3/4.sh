#!/bin/bash

./loop.4.sh & pid1=$!
./loop.4.sh & pid2=$!
./loop.4.sh & pid3=$!

./check.4.sh $pid1 &

sleep 20

kill $pid3

sleep 60

kill $pid1 $pid2
