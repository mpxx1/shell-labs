#!/bin/bash

# Подсчитать общее количество строк в файлах, находящихся в директории
# /var/log/ и имеющих расширение log.


cat $( find /var/log/* -type f -name "*.log" ) |
wc -l
