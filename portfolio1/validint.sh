#!/bin/bash

while true;
do
	echo "Enter an integer that is either 20 or 40"
	read -p ">" int
	
	if [ -n "$int" ] && [ $int -eq $int ] 2> /dev/null
	then
		if [[ ( $int -eq 20 ) || ( $int -eq 40 ) ]]
		then
			echo "Valid integer of $int supplied. Exiting..."
			exit 0
		else
			printf "Integer passed but is not one of the valid values\n\n\n"
		fi
	else
		printf "$int is not a valid integer!\n\n\n"
	fi
done
