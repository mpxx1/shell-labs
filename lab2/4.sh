#!/bin/bash

# Для всех зарегистрированных в данный момент в системе процессов определить среднее время
# непрерывного использования процессора (CPU_burst)

rm -f 4.rslt

sub_path="/proc"
pids=$(ps -eo pid | tail -n +2)

for pid in $pids 
do	
	ppid=$(grep -s "PPid:" "/proc/$pid/status" | awk '{print $NF}')

	sum_exec_runtime=$(grep -s "sum_exec_runtime" "/proc/$pid/sched" | awk '{print $NF}')
        nr_switches=$(grep -s "nr_switches" "/proc/$pid/sched" | awk '{print $NF}')
        
	if [[ $nr_switches > 0 ]];
        then
                art=$(echo $sum_exec_runtime $nr_switches | awk '{ print $2/$1 }')
                echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art" >> 4.rslt.tmp
        fi
done

sed -i 's/=/= /g' 4.rslt.tmp
sort -k 5 -n -o 4.rslt 4.rslt.tmp
sed -i 's/= /=/g' 4.rslt

rm -f 4.rslt.tmp
