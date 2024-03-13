#!/bin/bash

# Создать файл emails.lst, в который вывести через запятую все адреса электронной почты,
# встречающиеся во всех файлах директории /etc.

grep -srhwo "[[:alnum:]]\+@[[:alnum:]]\+" /etc/* |
grep -v "Binary file" |
tr '\n' ', ' > emails.lst
