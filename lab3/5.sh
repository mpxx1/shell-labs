#!/bin/bash

mkfifo pipe

./hand.5.sh&
echo "+" > pipe
./gen.5.sh

rm -f pipe
