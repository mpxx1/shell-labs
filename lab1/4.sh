#!/bin/bash

# Если скрипт запущен из домашнего директория, вывести на экран путь к домашнему директорию и
# выйти с кодом 0. В противном случае вывести сообщение об ошибке и выйти с кодом 1.


if [[ $PWD == $HOME ]]; then
    pwd
    exit 0
else
    echo "Запуск не из домашней директории!"
    exit 1
fi
