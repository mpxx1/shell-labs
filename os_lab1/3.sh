#!/bin/bash

# Создать текстовое меню с четырьмя пунктами. При вводе пользователем номера пункта меню
# происходит запуск редактора nano, редактора vi, браузера links или выход из меню.

input=""

while [ 1 ]; do
    echo "1) nano"
    echo "2) vi"
    echo "3) links"
    echo "4) exit"
    read input

    if [[ "$input" == "1" ]]; then
        nano
    elif [[ "$input" == "2" ]]; then
        vi
    elif [[ "$input" == "3" ]]; then
        links
    elif [[ "$input" == "4" ]]; then
        exit
    else
        echo "no such option"
    fi
done
