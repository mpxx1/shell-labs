#!/bin/bash

# Вывести три наиболее часто встречающихся слова из man по команде bash длиной
# не менее четырех символов.

man bash |
tr -sc 'A-Za-z' '\n' |
tr 'A-Z' 'a-z' |
sort |
uniq -c |
sort -nr |
awk 'length($2) >= 4' |
head -n 3
