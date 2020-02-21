#!/bin/bash

#Soal 2.a : membuat script bash untuk generate password 28 karakter (uppercase, lowercase, number)
password() {
 pw=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28)
}

i=0
while [ $i -eq 0 ]
 do
  if [[ $pw =~ [A-Z] ]]
   then
    if [[ $pw =~ [a-z] ]]
     then
      if [[ $pw =~ [0-9] ]]
       then i=1
      else password
      fi
    else password
    fi
  else password
  fi
done

#Soal 2.b : menyimpan password ybs ke file .txt dengan nama yang diinputkan dan hanya alfabet
read s



#Soal 2.c : enkripsi string manipulation disesuaikan dengan jam dibuatnya file


#Soal 2.d : dekripsi supaya nama file bisa kembali
