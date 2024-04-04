#!/bin/bash


exectime=$(date '+%F>%T')

mkdir ~/test && {
	echo "catalog '~/test' was created successfully" > ~/report
    	touch ~/test/$exectime
}


ping -c 1 www.net_nikogo.ru || {
	echo $exectime "host is unavailable" >> ~/report
}
