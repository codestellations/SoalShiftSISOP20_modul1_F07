#!/bin/bash

#Soal 2.a : membuat script bash untuk generate password 28 karakter (uppercase, lowercase, number)
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

#Soal 2.b : menyimpan password ybs ke file .txt dengan nama yang diinputkan dan hanya alfabet
#!/bin/bash

echo "Please input your file name: "
read pass_file

if [[ $pass_file =~ ^[a-zA-Z]+$ ]]; then
echo $pass >> $pass_file.txt
else
echo "Please input file name in alphabet only";
fi

#Soal 2.c : enkripsi string manipulation disesuaikan dengan jam dibuatnya file
low=abcdefghijklmnopqrstuvwxyz
up=ABCDEFGHIJKLMNOPQRSTUVWXYZ

#Soal 2.d : dekripsi supaya nama file bisa kembali
