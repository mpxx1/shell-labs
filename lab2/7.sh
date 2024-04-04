#!/bin/bash

# Написать скрипт, определяющий три процесса, которые за 1 минуту, прошедшую с момента запуска
# скрипта, считали максимальное количество байт из устройства хранения данных. Скрипт должен
# выводить PID, строки запуска и объем считанных данных, разделенные двоеточием.

get_proc_bytes() {
        grep -Pos "rchar:\K.*" $(find /proc -maxdepth 2 -mindepth 2 -regex .*io)
}

get_proc_bytes > 7.proc.0
sleep 10
get_proc_bytes > 7.proc.1

echo "" > 7.tmp
echo "" > 7.rslt

while read i
do
	if [[ -n "$i" ]]
	then
        	pid=$(echo "$i" | grep -Po "/proc/\K[0-9]*")
        	old_data=$(grep -Po "/proc/$pid/io: \K.*" 7.proc.0)
        	new_data=$(echo "$i" | awk '{ print $2 }')
        	
		if [[ -n "$old_data" ]]
        	then
                	let diff="$new_data"-"$old_data"
                	echo "$diff $pid" >> 7.tmp
        	fi
	fi
done < 7.proc.1

cat 7.tmp |
sort -rn |
head --lines=3 |
awk '{ print "PID", $2, "READ", $1 }' > 7.rslt

rm -f 7.tmp
rm -f 7.proc.*

cat 7.rslt
