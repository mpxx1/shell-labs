#!/bin/bash

# Используя псевдофайловую систему /proc найти процесс, которому выделено больше всего
# оперативной памяти. Сравнить результат с выводом команды top.

echo "pc:"
ps -eo pid,rss,comm --sort -rss | head -n2

echo "top:"
top -b -n 1 -o %MEM | tail -n +8 | head -n 1

echo "/proc:"

pids=$(ps -eo pid)
rm -f 6.rslt.tmp

for pid in $pids 
do
	if [[ -f /proc/$pid/status ]]; 
	then
		rss=$(grep 'VmRSS' /proc/$pid/status | 
			cut -d: -f2 | 
			sed 's/ kB//g' | 
			cut -d $'\t' -f2
		) 
		echo "$pid : $rss" >> 6.rslt.tmp
	fi
done

sort -k3nr 6.rslt.tmp | head -n 1

rm -f 6.rslt.tmp
