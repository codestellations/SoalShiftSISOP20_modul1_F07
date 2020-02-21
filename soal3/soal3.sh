#!/bin/bash

#Soal 3.a : script untuk mendownload 28 gambar dari alamat dengan command wget dan file "pdkt_kusuma_no"
#           log messages wget ke file "wget.log"

a=1
no=1

satu(){
until [ $a -eq 29 ]
do
 name="pdkt_kusuma_$no"
 #echo $name
  a=$((a + 1))
  wget -O /home/el/Downloads/pdkt_kusuma_$no "https://loremflickr.com/320/240/cat" 2>&1 | tee -a /home/el/Downloads/wget.log
  no=$((no + 1))
done
}

satu

#Soal 3.c : script identifikasi gambar identik dari keseluruhan gambar yang didownload
#           duplikat diberi nama "duplicate_no" dan dipindah ke folder ./duplicate dengan nama "kenangan_no"
#           setelah tidak ada gambar di current directory, backup log dengan .log.bak

cd /home/el/Downloads

num=1
ber=1

finddup(){
 dir="/home/el/Downloads/"
 find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD | awk -F" " 'NR%2==0 {print $2}' > /home/el/Downloads/duplicate.log
}

finddup

ken(){
 for file in pdkt_kusuma_*
 do
  mv "$file" /home/el/Downloads/kenangan/"kenangan_$num"
  num=$((num + 1))
 done
}

dup(){
 for file in pdkt_kusuma_*
 do
  mv "$file" /home/el/Downloads/duplikat/"duplikat_$ber"
  ber=$((ber + 1))
 done
}

#ken
#dup
