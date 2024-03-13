#!/bin/bash

# Вывести в файл список PID всех процессов, которые были запущены командами, расположенными в
# /sbin/

ps -x |
grep "/sbin" | 
grep -v "grep" | 
awk -F: '{ printf "%s\n", $1 }' > 2.reslt
