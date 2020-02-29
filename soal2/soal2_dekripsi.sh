#!/bin/bash

file_decrypt=$(basename "$1" .txt)

hour=$(date "+%H" -r $1)
while [ $hour -gt 0 ]
do
	file_decrypt=$(echo "$file_decrypt" | tr '[A-Za-z]' '[ZA-Yza-y]')
	hour=$((hour-1))
done
mv "$1" /home/liizza/password/"$file_decrypt.txt"

