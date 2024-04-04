#!/bin/bash

#Вывести на экран PID процесса, запущенного последним (с последним временем запуска).


ps axo pid,comm,bsdstart |
tac |
head -6 |
tail -1
