#!/bin/bash

# Создать full.log, в который вывести строки файла /var/log/anaconda/X.log, содержащие
# предупреждения и информационные сообщения, заменив маркеры предупреждений и
# информационных сообщений на слова Warning: и Information:, чтобы в получившемся файле
# сначала шли все предупреждения, а потом все информационные сообщения. Вывести этот файл на
# экран.

rg '(WW)' /var/log/anaconda/X.log | sed 's/(WW)/Warning:/g' > full.log
rg '(II)' /var/log/anaconda/X.log | sed 's/(II)/Information:/g' >> full.log
