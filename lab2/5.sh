#!/bin/bash

rm -f 5.rslt

sed 's/Parent_ProcessID=//g' 4.rslt |
sed 's/ProcessID=//g'  |
sed 's/Average_Running_Time=//g' > 5.tmp.0

awk -F: '
    {
        pid=$1; ppid=$2; art=$3;
        if (art != "" && art != 0) {
            sum[ppid] += art;
            count[ppid]++;
        }
    }
    END {
        for (ppid in sum) {
            if (count[ppid] > 0) {
                avg = sum[ppid] / count[ppid];
                printf "Average_Running_Children_of_ParentID=%s\tis %.3f\n", ppid, avg;
            }
        }
    }
' 5.tmp.0 > 5.tmp.1


last=0
while read i
do 
	if [[ -n $i ]];
	then
		ppid=$(echo $i | cut -d' ' -f3 | cut -d= -f2 | tr -d ' ') 

		if [[ "$last" == "$ppid" ]];
		then
			echo $i
		else
			grep -w "Average_Running_Children_of_ParentID= $last" 5.tmp.1
			echo $i
			last=$ppid
		fi
	
	fi
done < 4.rslt > 5.rslt

grep -w "Average_Running_Children_of_ParentID= $last" 5.tmp.1 >> 5.rslt

cat 5.rslt

rm -f 5.tmp.*
