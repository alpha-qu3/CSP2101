#!/bin/bash
IFS=', ' read -r -a array <<< $(ls -m --file-type $1)

fullPath=$(cd "$1"; pwd)
emptyFiles=0
Files=0
emptyDirs=0
Dirs=0

for item in "${array[@]}";
do
	if [[ "$item" =~ .*/$ ]];
	then
		nestedDir=$(ls "$fullPath/$item" | wc -m)
		if [[ "$nestedDir" -eq 0 ]]
		then
			((emptyDirs+=1))
		elif [[ "$nestedDir" -gt 0 ]]
		then
			((Dirs+=1))
		fi
	else
		file_c=$(file "$fullPath/$item")
		if [[ "$file_c" =~ empty$ ]]
		then
			((emptyFiles+=1))
		else
			((Files+=1))
		fi
	fi
done

echo "The $1 directoy contains:"
echo "$Files files that contain data"
echo "$emptyFiles files that are empty"
echo "$Dirs non-empty directories"
echo "$emptyDirs empty directories"
