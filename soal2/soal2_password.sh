#!/bin/bash

echo "Please input your file name: "
read pass_file

genpass() #a function to generate random password
{
  pass=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28)
}

i=0

while [ $i -eq 0 ]
do
	if [[ $pass =~ [A-Z] ]]
	then
		if [[ $pass=~[a-z] ]]
		then
			if [[ $pass=~[0-9] ]]
			then i=1
			else genpass
			fi
		else genpass
		fi
	else genpass
fi
done

if [[ $pass_file =~ ^[a-zA-Z]+$ ]]; then #mengecek nama file
echo $pass >> "/home/liizza/password/$pass_file.txt"
#echo $pass >> "$pass_file.txt"
echo "Congratulations!" #jika nama file yg dimasukkan sudah alphabet saja
else
echo "Please input file name in alphabet only";
fi

