#!/bin/bash

#Soal 3.a : script untuk mendownload 28 gambar dari alamat dengan command wget dan file "pdkt_kusuma_no"
#           log messages wget ke file "wget.log"

a=0
no=1

while [ a -ne 28 ]
do
 name="pdkt_kusuma_$no"
 echo $name
 ((no++))
done

#wget -O /home/el/Documents/GitHub/SoalShiftSISOP20_modul1_F07/


#Soal 3.b : penjadwalan tiap 8 jam mulai jam 6.05 tiap hari kecuali sabtu
#           script memindahkan gambar identik gambar berbeda disimpan di folder /kenangan


#Soal 3.c : script identifikasi gambar identik dari keseluruhan gambar yang didownload
#           duplikat diberi nama "duplicate_no" dan dipindah ke folder ./duplicate dengan nama "kenangan_no"
#           setelah tidak ada gambar di current directory, backup log dengan .log.bak
