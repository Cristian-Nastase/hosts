#!/bin/bash

continut="/etc/hosts"

while read line; do
	for word in $line; do
		firstchr=`echo $word | cut -c1-1`
		if [[ "$firstchr" =~ ^[0-9] ]]; then
			ip=$word
		elif [ $firstchr != "#" ]; then
			look=`nslookup $word`
			last_word=$(echo "$look" | awk '{print $NF}' | tail -n 1)
			if [ "$last_word" != "$ip" ]; then
				echo "$last_word $ip"
				echo "Bogus IP for $word in /etc/hosts!"
			fi
		elif [ $firstchr == "#" ]; then
			exit 0
		fi
	done
done < $continut
