#!/bin/bash
#Xander van Rensburg - 10525611

#Start endless loop. If conditions are met loop is broken.
while true;
do
	#Ask user to provide int
	echo "Enter an integer that is either 20 or 40"
	read -p ">" int
	
	#Check if user input non-empty and is an integer. Pipe stderror to /dev/null to supress errors
	if [ -n "$int" ] && [ $int -eq $int ] 2> /dev/null
	then
		#Check if int is either of the valid numbers.
		if [[ ( $int -eq 20 ) || ( $int -eq 40 ) ]]
		then
			#If supplied int is vaild print success message and exit
			echo "Valid integer of $int supplied. Exiting..."
			exit 0
		else
			#If supplied in is not one of the options print error message and continue loop
			printf "Integer passed but is not one of the valid values\n\n\n"
		fi
	else
		#If user input not valid continue loop
		printf "$int is not a valid integer!\n\n\n"
	fi
done
