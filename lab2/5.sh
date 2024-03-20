#!/bin/bash


# В полученном на предыдущем шаге файле после каждой группы записей с одинаковым
# идентификатором родительского процесса вставить строку вида
# Average_Running_Children_of_ParentID=N is M,
# где N = PPID, а M – среднее, посчитанное из ART для всех процессов этого родителя.

#!/bin/bash

ppids=$(cat 4.rslt | cut -d: -f2 | cut -d= -f2 | uniq)
rm -f tmp
touch tmp
rm -f 5.rslt

for ppid in $ppids
do
	counter=0
      	IFS=$'\n'	

	for line in $(cat 4.rslt)
        do
                cur_ppid=$(echo "$line" | cut -d: -f2 | cut -d= -f2)
		pc_time=$(echo $line | cut -d: -f3 | cut -d= -f2)

                if [ "$cur_ppid" -eq "$ppid" ];
                then
                        counter=$(echo "$counter + $pc_time" | bc)
                fi
        done
	
        echo "$ppid : $counter" >> tmp
done

cur_ppid=$(cat 4.rslt | cut -d: -f2 | cut -d= -f2 | uniq | head -n 1)

for line in $(cat 4.rslt)
do 
        line_ppid=$(echo "$line" | cut -d: -f2 | cut -d= -f2)

	if [ $line_ppid -eq $cur_ppid ];
	then	
		echo $line >> 5.rslt
	else
		grep "$cur_ppid" tmp | 
		awk -F: '{ printf "Average_Running_Children_of_ParentID=%s is %s\n", $0, $1 }' >> 5.rslt
		echo $line >> 5.rslt
		cur_ppid=$line_ppid
	fi
done	

grep "$line_ppid" tmp |
awk -F: '{ printf "Average_Running_Children_of_ParentID=%s is %s\n", $0, $1 }' >> 5.rslt

rm -r tmp
