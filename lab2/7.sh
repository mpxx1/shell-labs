#!/bin/bash


# Написать скрипт, определяющий три процесса, которые за 1 минуту, прошедшую с момента запуска
# скрипта, считали максимальное количество байт из устройства хранения данных. Скрипт должен
# выводить PID, строки запуска и объем считанных данных, разделенные двоеточием.


pids=$(ps -eo pid | tail -n +2)
rm -f 7.tmp.[01]

for pid in $pids
do 
	if [ -f "/proc/$pid/io" ];
	then
		rd_byts=$(cat "/proc/$pid/io" | grep "read_bytes" | cut -d: -f2)
		echo "$pid : $rd_byts" >> 7.tmp.0
	fi
done

sleep 3 #60
pids2=$(ps -eo pid | tail -n +2)

for pid in $pids2
do 
	if [ -f "/proc/$pid/io" ];
	then
		rd_byts=$(cat "/proc/$pid/io" | grep "read_bytes" | cut -d: -f2)
		rd_byts_old=0

		if grep -q $pid 7.tmp.0 
		then
			rd_byts_old=$(grep $pid 7.tmp.0 | cut -d: -f2)
		fi
		dif=($rd_byts - $rd_byts_old)

		echo "$pid : $dif" >> 7.tmp.1
	fi

done

sort -k3nr 7.tmp.1 | head -n 3 > 7.rslt

rm -f 7.tmp.[01]
