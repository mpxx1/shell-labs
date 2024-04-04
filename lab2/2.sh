#!/bin/bash

# Вывести в файл список PID всех процессов, которые были запущены командами, расположенными в
# /sbin/

ps -ef | 
awk '$8 ~ /^\/sbin\// { print $2 }' > 2.rslt
