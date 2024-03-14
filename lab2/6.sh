#!/bin/bash

# Используя псевдофайловую систему /proc найти процесс, которому выделено больше всего
# оперативной памяти. Сравнить результат с выводом команды top.

echo "pc:"
ps -eo pid,rss,comm --sort -rss | head -n2

echo "top:"
top -b -n 1 -o %MEM | tail -n +8 | head -n 1
