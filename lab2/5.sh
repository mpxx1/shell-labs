#!/bin/bash

sed 's/Parent_ProcessID=//g' 4.rslt |
sed 's/ProcessID=//g'  |
sed 's/Average_Running_Time=//g' > 5.rslt.tmp

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
                printf "Average_Running_Children_of_ParentID=%s\tis %.2f\n", ppid, avg;
            }
        }
    }
' 5.rslt.tmp

rm -f 5.rslt.tmp
