#!/bin/bash

#Soal 3.a : script untuk mendownload 28 gambar dari alamat dengan command wget dan file "pdkt_kusuma_no"
#           log messages wget ke file "wget.log"

a=10
no=1

until [ $a -eq 10 ]
do
 name="pdkt_kusuma_$no"
 #echo $name
  a=$((a + 1))
  wget -O /home/el/Downloads/pdkt_kusuma_$no "https://loremflickr.com/320/240/cat" 2>&1 | tee -a /home/el/Downloads/wget.log
  no=$((no + 1))
done


#Soal 3.b : penjadwalan tiap 8 jam mulai jam 6.05 tiap hari kecuali sabtu
#           script memindahkan gambar identik gambar berbeda disimpan di folder /kenangan


#Soal 3.c : script identifikasi gambar identik dari keseluruhan gambar yang didownload
#           duplikat diberi nama "duplicate_no" dan dipindah ke folder ./duplicate dengan nama "kenangan_no"
#           setelah tidak ada gambar di current directory, backup log dengan .log.bak

grep -e 'Location' -e 'Saving' /home/el/Downloads/wget.log > /home/el/Downloads/location.log
paste -d " " - - < /home/el/Downloads/location.log | sort -u -k2 > /home/el/Downloads/kenangan.log
awk '$2 in a {print a[$2]} {a[$2]=$0}' /home/el/Downloads/kenangan.log > /home/el/Downloads/duplicate.log
#dupes=${grep -o ''.*'' duplicate.log | sed 's/'//g'}
#filename=$(awk '/home/ {print $6}' /home/el/Downloads/duplicate.log)

#grep -io "/home.*\'" /home/el/Downloads/duplicate.log | cut -d "'" -f2 
#echo "${satu::-1}"
#| cut -d"'" -f2
#grep -o ''.*'' /home/el/Downloads/duplicate.log | tr -d "'"
#awk -F\' ' '{print $6}' /home/el/Downloads/duplicate.log
#grep -o "\'.*\'" /home/el/Downloads/duplicate.log
#huft=$(sed -n "s/^.*'\(.*\)'.*$/\1/p" <<< $filename)
#echo "$huft"
#grep "to: '" /home/el/Downloads/duplicate.log | cut -d "'" -f4
#sed 's/^[^"]*"\([^"]*\)".*/\1/'
#grep -o ''.*'' /home/el/Downloads/duplicate.log | sed 's/"//g'
#grep -v "/home/el/Downloads/.*'" /home/el/Downloads/duplicate.log
#sed -E 's/.*\('(.*)')\.*/\1/'
#grep -oP "'.*'" /home/el/Downloads/duplicate.log

cd /home/el/Downloads

finddup(){
 find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD > /home/el/Downloads/test.log
}

#cd /home/el/Downloads
num=1
ber=1

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
