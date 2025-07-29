#!/bin/bash

filename="modulus.txt"

sum=0
count=0
line_num=0

while read -r line;do
	second_column=$(echo "$line" | awk '{print $2}')
	sum=$(echo "$sum+$second_column" | bc)
	((count++))

	if ((count == 5)); then
		average=$(echo "$sum/5" | bc -l)
		echo "$average" >> miu.txt
		
		sum=0
		count=0
	fi

	((line_num++))
done < "$filename"
