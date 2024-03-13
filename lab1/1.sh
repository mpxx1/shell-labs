#!/bin/bash

if [[ $# != 3 ]]; then
  echo "Ошибка: Необходимо передать ровно три числа в качестве аргументов"
  exit 1
fi


num1=$1
num2=$2
num3=$3


if [[ $num1 -eq $num2 && $num2 -eq $num3 ]]; then
  echo "Все числа равны"
elif [[ $num1 -gt $num2 && $num1 -gt $num3 ]]; then
  echo "Первое число ($num1) наибольшее"
elif [[ $num2 -gt $num1 && $num2 -gt $num3 ]]; then
  echo "Второе число ($num2) наибольшее"
else
  echo "Третье число ($num3) наибольшее"
fi
