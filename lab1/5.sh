#!/bin/bash

# Создать файл info.log, в который поместить все строки из файла /var/log/anaconda/syslog,
# второе поле в которых равно INFO.

rg '^[^ ]+ INFO' /var/log/anaconda/syslog > info.log
