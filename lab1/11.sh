#!/bin/bash

# Вывести список пользователей системы с указанием их UID, отсортировав по UID.
# Сведения о пользователей хранятся в файле /etc/passwd. В каждой строке этого
# файла первое поле – имя пользователя, третье поле – UID.
# Разделитель – двоеточие. !! без awk !!


#awk -F: '{printf "%s:%s\n", $3, $1}' /etc/passwd |
#grep -v "#" |
#sort -t: -nk1


cut -d: -f1,3 /etc/passwd |
grep -v "#"
