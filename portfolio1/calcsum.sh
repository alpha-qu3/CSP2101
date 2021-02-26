#!/bin/bash

#Initalise variable to hold total
total=0

#Add all passed integers to the total
((total=$1+$2+$3))

#Check if the total is greater than 30. Note the operator > could have also been used.
if [ $total -gt 30 ]
then
	#If total is greater than 30 print error message and exit.
	echo "Sum exceeds maximum allowable"
	exit 0
else
	#If total is less than or equal to 30, display the passed integers and their sum
	echo "The sum of $1 and $2 and $3 is $total"
	exit 0
fi
