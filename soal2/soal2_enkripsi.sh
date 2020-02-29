#!/bin/bash

file_encrypt=$(basename "$1" .txt)

hour=$(date "+%H" -r $1)
while [ $hour -gt 0 ]
do
	file_encrypt=$(echo "$file_encrypt" | tr '[A-Za-z]' '[B-ZAb-za]')
	hour=$((hour-1))
done
mv "$1" /home/liizza/password/"$file_encrypt.txt"


