#!/bin/bash
#Xander van Rensburg - 10525611

# This take the output of the subshell, splits it at ', ' and appends elements to an array.
# The -m flag has ls output on one line seperated by commas and the --file-type flag appends '/' to directories. Example output: 
# "emptyDir, emptyDir2, empty.txt, nonEmptyDir, nonEmpty.txt, notempty2.txt"
IFS=', ' read -r -a array <<< $(ls -m --file-type $1)

# Full path variable converts user supplied argument (a directory) to its full path. This is to avoid any confusion that relative paths can cause.
fullPath=$(cd "$1"; pwd)

# Variables to hold the counts of each type
emptyFiles=0
Files=0
emptyDirs=0
Dirs=0

# Loop through array
for item in "${array[@]}";
do
	# Use regex operator to check if the item ends '/'. This checks to see if the item is a directory.
	if [[ "$item" =~ .*/$ ]];
	then
		# If item is directory, list it's contents and count characters in output.
		nestedDir=$(ls "$fullPath/$item" | wc -m)

		# If listing the directory's contents returns 0 characters, it is an empty dir and should add 1 to that counter.
		if [[ "$nestedDir" -eq 0 ]]
		then
			((emptyDirs+=1))
		# If listing the directory's contents returns more that 0 characters, it is a non-empty dir and should add 1 to that counter.
		elif [[ "$nestedDir" -gt 0 ]]
		then
			((Dirs+=1))
		fi
	
	# If item does not end in '/', it is a file
	else
		# Store the output of the file command on the item. This is used to determine if the file is empty
		file_c=$(file "$fullPath/$item")
		
		# If the command returns a string that ends in empty, the file is empty and should add 1 to that counter.
		if [[ "$file_c" =~ empty$ ]]
		then
			((emptyFiles+=1))
		# If the command does not return empty, the file is non-empty and should add 1 to that counter.
		else
			((Files+=1))
		fi
	fi
done

# Once for loop is complete print results to user
echo "The $1 directoy contains:"
echo "$Files files that contain data"
echo "$emptyFiles files that are empty"
echo "$Dirs non-empty directories"
echo "$emptyDirs empty directories"
exit 0
