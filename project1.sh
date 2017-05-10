#!/bin/bash


filename=$1;


if [ -f $filename ]; then
if [ $# -eq 2 ]; then 
	if [ $2 = "-h" ]; then

		printf "$filename";
		awk 'BEGIN{FS=""}{for(i=1;i<=NF;i++)count++}END{print " contains "count" letters."}' $filename;

	elif [ $2 = "-k" ]; then

		printf "$filename";
		awk 'BEGIN{FS=" "}{for(i=1;i<=NF;i++)count++}END{print " contains "count" words."}' $filename;

	elif [ $2 = "-s" ]; then

		printf "$filename";
		awk 'BEGIN{FS=FNR}{for(i=1;i<=NF;i++)count++}END{print " contains "count" lines."}' $filename;

	else
		echo "YOU DID NOT ENTERED A VALID ARGUMENT"
	fi
else
	echo "THE NUMBER OF ARGUMENTS IS MISSING !"
fi
else
echo "$filename IS NOT EXISTS !"
fi

