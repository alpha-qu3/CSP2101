#!/bin/bash
#Xander van Rensburg - 10525611

while true;
do
	read -p "Pattern?: " usr_pattern

	#Determine the match type. Loop contiously prompts user until valid input is supplied
	while true;
	do
		#prompt user and convert input to lower case
		read -p "Whole-word or any match? [whole/any]: " usr_matchType
		usr_matchType=$(echo "$usr_matchType" | tr '[:upper:]' '[:lower:]')
		
		#If matchType is whole-word, then set variable to grep's -w flag
		if [[ "$usr_matchType" == "whole" ]] 
		then
			usr_matchType="-w"
			break
		#If matchType is any, then no special flag is required and variable is set to an empty string
		elif [[ "$usr_matchType" == "any" ]]
		then
			usr_matchType=""
			break
		#If user input is neither valid type, display error message and continue loop
		else
			echo "incorrect input"
		fi
	done

	#Determine if inverted. Loop contiously prompts user until valid input is supplied
	while true;
	do
		#prompt user and convert input to lower case
		read -p "Inverted match? [y/n]: " usr_inverted
		usr_inverted=$(echo "$usr_inverted" | tr '[:upper:]' '[:lower:]')
		
		#If inverted, then set variable to grep's -v flag
		if [[ "$usr_inverted" == "y" ]] 
		then
			usr_inverted="-v"
			break
		#If not inverted, then no special flag is required and variable is set to an empty string
		elif [[ "$usr_inverted" == "n" ]]
		then
			usr_inverted=""
			break
		#If user input is neither valid type, display error message and continue loop
		else
			echo "incorrect input"
		fi
	done

	#Grep command to search based on pattern and match types (whole-word/any, inverted).
	# -E allows for extended regex quries. -i forces search to case-insensitive. -n prints line number from source file
	grep_command=$(grep -E -i -n $usr_matchType $usr_inverted "$usr_pattern" access_log.txt)
	#Same grep command. The -c flag means only number of matches is returned.
	grep_count=$(grep -E -c -i -n $usr_matchType $usr_inverted "$usr_pattern" access_log.txt)
	
	#Print results to user
	printf "\n$grep_count matches found:\n"
	echo "$grep_command"
	
	#Ask user if they'd like to quit or do another search.
	read -p "Another search or quit? [*/q]: " usr_repeat
	usr_repeat=$(echo "$usr_repeat" | tr '[:upper:]' '[:lower:]')
	if [[ "$usr_repeat" == "q" ]]
	then
		break
	fi
done

# Once loop is broken it should exit sucessfully
exit 0
