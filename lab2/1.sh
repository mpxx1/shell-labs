#!/bin/bash

# Посчитать количество процессов, запущенных пользователем user, и вывести в файл получившееся
# число, а затем пары PID:команда для таких процессов.


ps -u $USER | cut -d $' ' -f2,8 | tail -n +2 | sed 's/ /:/g' > 1.rslt.tmp

echo "proc cnt: $(wc -l 1.rslt.tmp | cut -d $' ' -f1)" > 1.rslt

cat 1.rslt.tmp >> 1.rslt

rm -f 1.rslt.tmp
