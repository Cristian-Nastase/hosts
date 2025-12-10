#!/bin/bash

if [ -z "$3" ];then
	echo "Nu s-a transmis serverul DNS, va fi omis"
	look=`nslookup $1`
else
	look=`nslookup $1 $3`	
fi

last_word=$(echo "$look" | awk '{print $NF}' | tail -n 3 | head -n 1)

if [ "$last_word" != "$2" ]; then
	echo "Bogus IP for $1"
else
	echo "Da, este corect"
fi
