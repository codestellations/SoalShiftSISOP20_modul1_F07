# SoalShiftSISOP20_modul1_F07
Repository Modul 1 praktikum mata kuliah Sistem Operasi 2020
- Erlinda Argyanti Nugraha (05111840000017)
- Lii'zza Aisyah Putri Sulistio (05111840000073)

## Soal 1
Diberikan file `Sample-Superstore.tsv`, diminta laporan berupa :
### a. Region dengan profit paling sedikit
untuk mendapatkan *region* yang diminta, digunakan `awk` dari file yang diberikan dengan kodingan sebagai berikut :
~~~
awk -F $'\t'
    'FNR == 1 {next}
    {arr[$13]+=$21}
    END {for (i in arr) {printf "%s %.2f\n", i, arr[i]}}'
    Sample-Superstore.tsv | sort -nk2 | awk '{print $1}' | head -1
~~~
berikut adalah penjelasan masing-masing fungsi :
- `awk -F $'\t'` melakukan fungsi awk dengan pemisah berupa *tab*
- `FNR == 1 {next}` mengabaikan baris pertama dari file dan melanjutkan ke fungsi selanjutnya
- `{arr[$13]+=$21}` menjumlah profit (kolom ke-21) berdasarkan region (kolom ke-13) dan dimasukkan ke array *arr*
- `END {for (i in arr) {printf "%s %.2f\n", i, arr[i]}}` apabila telah selesai mengecek file sampai akhir, mencetak array *arr* beserta isinya
- `Sample-Superstore.tsv` input file yang digunakan
- `sort -nk2` hasil diurutkan ascending berdasarkan kolom ke-2 (*k2*), dan diurutkan berdasakan nilai numeriknya (*n*)
- `awk '{print $1}' | head -1` mencetak hasil paling atas yang sudah diurutkan, yaitu region dengan profit paling rendah

hasil dari poin a dimasukkan ke dalam variabel `region`.

---

### b. Dua state dengan profit paling sedikit berdasarkan region hasil poin a
untuk mendapatkan *state* yang diminta, digunakan `awk` dari file yang diberikan dengan kodingan sebagai berikut :
~~~
awk -v region="$region" -F $'\t'
    'FNR == 1 {next}
    ($13~region) {arr[$11]+=$21}
    END {for (i in arr) {printf "%s %.2f\n", i, arr[i]}}'
    Sample-Superstore.tsv | sort -nk2 | awk '{print $1}' | head -2
~~~
berikut adalah penjelasan masing-masing fungsi :
- `awk -v region="$region" -F $'\t'` melakukan fungsi awk dengan pemisah berupa *tab*, serta menginisiasi variabel `region` dari poin a
- `FNR == 1 {next}` mengabaikan baris pertama dari file dan melanjutkan ke fungsi selanjutnya
- `($13~region) {arr[$11]+=$21}` mencari data region (kolom ke-13) yang sesuai dengan isi dari variabel *region*, kemudian menjumlah profit (kolom ke-21) berdasarkan state (kolom ke-11) dan dimasukkan ke array *arr*
- `END {for (i in arr) {printf "%s %.2f\n", i, arr[i]}}` apabila telah selesai mengecek file sampai akhir, mencetak array *arr* beserta isinya
- `Sample-Superstore.tsv` input file yang digunakan
- `sort -nk2` hasil diurutkan ascending berdasarkan kolom ke-2 (*k2*), dan diurutkan berdasakan nilai numeriknya (*n*)
- `awk '{print $1}' | head -2` mencetak hasil kedua paling atas yang sudah diurutkan, yaitu state dengan profit paling rendah dari region yang didapatkan dari poin a

hasil dari poin b dimasukkan ke dalam variabel `state`.

---

### c. Sepuluh produk dengan profit paling sedikit berdasarkan dua state hasil poin b
untuk mendapatkan *produk* yang diminta, digunakan `awk` dari file yang diberikan dengan kodingan sebagai berikut :
~~~
awk -v state1="$state1" -v state2="$state2" -F '\t'
    'FNR == 1 {next}
    ($11~state1) || ($11~state2) {arr[$17]+=$21}
    END {for (i in arr) {printf "%s:%.2f\n", i, arr[i]}}'
    Sample-Superstore.tsv | sort -t $":" -nk2 | awk -F: '{print $1}' | head -10
~~~
berikut adalah penjalasan masing-masing fungsi :
- `awk -v state1="$state1" -v state2="$state2" -F '\t'` melakukan fungsi awk dengan pemisah berupa *tab*, serta menginisiasi variabel `state` dari poin b (dipisah menjadi dua variabel)
- `FNR == 1 {next}` mengabaikan baris pertama dari file dan melanjutkan ke fungsi selanjutnya
- `($11~state1) || ($11~state2) {arr[$17]+=$21}'` mencari data state (kolom ke-11) yang sesuai dengan isi dari variabel *state1* dan *state2*, kemudian menjumlah profit (kolom ke-21) berdasarkan state (kolom ke-17) dan dimasukkan ke array *arr*
- `END {for (i in arr) {printf "%s:%.2f\n", i, arr[i]}}` apabila telah selesai mengecek file sampai akhir, mencetak array *arr* beserta isinya
- `Sample-Superstore.tsv` input file yang digunakan
- `sort -t $":" -nk2` hasil diurutkan ascending berdasarkan kolom ke-2 (*k2*), dan diurutkan berdasakan nilai numeriknya (*n*), dan diberi pemisah berupa `:`
- `awk -F: '{print $1}' | head -10` mencetak hasil sepuluh paling atas yang sudah diurutkan, yaitu state dengan profit paling rendah dari region yang didapatkan dari poin a, dengan pemisah berupa `:`

---

## Soal 2
### a. Generate Random Password dan b. Menyimpan File dengan Ekstensi .txt dan Hanya Terdiri dari Alphabet Saja
[soal2_password.sh](https://github.com/codestellations/SoalShiftSISOP20_modul1_F07/blob/master/soal2/soal2_password.sh)
~~~
 #!/bin/bash
    echo "Please input your file name here: "
    read pass_file #variabel untuk menyimpan nama file
    genpass() #fungsi untuk membuat password random
    {
	    pass=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 28)
    }
    i=0
    while [ $i -eq 0 ]
    do
	    if [[ $pass=~ [A-Z] ]]
	    then
		    if [[ $pass=~[a-z] ]]
		    then
				 if [[ $pass=~[0-9] ]]
				 then i=1
				 else genpass
				 fi
			else genpass
		else genpass
	fi
	done
	if [[ $pass_file =~ ^[A-Za-z]+$ ]]; then #mengecek nama file
	echo $pass >> "home/liizza/password/$pass_file.txt"
	echo "Congratulations!"
	else
	echo "Please input file name in alphabet only"
	fi
 ~~~
 penjelasan:
 - `read pass_file` bertujuan untuk memasukkan nama file oleh user yang akan digunakan untuk menyimpan password nantinya.
 - `/dev/urandom` digunakan untuk menghasilkan karakter acak.
 - `tr -dc A-Za-z0-9` digunakan agar hanya mengambil karakter huruf kapital (A-Z), huruf kecil (a-z) dan angka (0-9) saja berdasarkan `/dev/urandom` tadinya.
 - `head -c 28` digunakan agar hanya mengambil 28 karakter awal dari output perintah sebelumnya. 
 -  `i=0` i diset 0 terlebih dahulu.
 - `if [[ [$pass=~ [A-Z] ]]` digunakan untuk mengecek apakah pass sudah mengandung huruf kapital.
 - `if [[ [$pass=~[a-z] ]]` digunakan untuk mengecek apakah pass sudah mengandung huruf kecil.
 - `if [[ [$pass=~[0-9] ]]` digunakan untuk mengecek apakah pass sudah mengandung angka.
 - jika `i=1` maka password sudah sesuai dengan ketentuan yang diinginkan, sehingga loop akan berhenti.
 - `if [[ $pass_file =~ ^[A-Za-z]+$ ]];` digunakan untuk mengecek apakah nama file sudah terdiri dari huruf alphabet saja, baik huruf kapital maupun huruf kecil.
 - `echo $pass >> "home/liizza/password/$pass_file.txt"` digunakan untuk menyimpan password yang sudah dihasilkan ke dalam nama file dengan format file .txt
 - `echo "Congratulations!"` jika nama file sudah sesuai dengan ketentuan perintah sebelumnya.
 - `echo "Please input file name in alphabet only"` jika nama file tidak sesuai dengan ketentuan perintah sebelumnya.
---

### c. Enkripsi Nama File
[soal 2c enkripsi](https://github.com/codestellations/SoalShiftSISOP20_modul1_F07/blob/master/soal2/soal2_enkripsi.sh)
~~~
#!/bin/bash
file_encrypt=$(basename "$1" .txt)
hour=$(date "+%H" -r $1)
while [ $hour -gt 0 ]
do
	file_encrypt=$(echo "$file_encrypt" | tr '[A-Za-z]' '[B-ZAb-za]')
	hour=$((hour-1))
done
mv "$1" /home/liizza/password/"$file_encrypt.txt"
~~~
penjelasan:
 - `file_encrypt=$(basename "$1" .txt)` basename digunakan untuk mengambil nama file saja dari string tanpa direktori dan ekstensi file. Sedangkan $1 menunjukkan argumen 1.
 - `hour=$(date "+%H" -r $1)` variabel hour digunakan untuk menyimpan data jam (yang sudah diambil dengan date "+%H") berdasarkan kapan file itu ($1) dibuat.
 - `file_encrypt=$(echo "$file_encrypt" | tr '[A-Za-z]' '[B-ZAb-za]')` variabel file_encrypt digunakan untuk menggeser setiap alphabet pada nama file sebanyak 1 kali, karena a menjadi b, b menjadi c dan seterusnya.
 - `hour=$((hour-1))` perulangan untuk pergeseran alphabet akan dilakukan sebanyak variabel hour.
 - `mv "$1" /home/liizza/password/"$file_encrypt.txt"` melakukan penamaan ulang (rename) pada file yang telah dienkripsi.
---

### d. Dekripsi Nama File
[soal 2d dekripsi](https://github.com/codestellations/SoalShiftSISOP20_modul1_F07/blob/master/soal2/soal2_dekripsi.sh)
~~~
#!/bin/bash
file_decrypt=$(basename "$1" .txt)
hour=$(date "+%H" -r $1)
while [ $hour -gt 0 ]
do
file_decrypt=$(echo "$file_decrypt" | tr '[A-Za-z]' '[ZA-Yza-y]')
hour=$((hour-1))
done
mv "$1" /home/liizza/password/"$file_decrypt.txt"
~~~
penjelasan:
- `file_decrypt=$(basename "$1" .txt)` basename digunakan untuk mengambil nama file saja dari string tanpa direktori dan ekstensi file. Sedangkan $1 menunjukkan argumen 1.
 - `hour=$(date "+%H" -r $1)` variabel hour digunakan untuk menyimpan data jam (yang sudah diambil dengan date "+%H") berdasarkan kapan file itu ($1) dibuat.
 - `file_decrypt=$(echo "$file_decrypt" | tr '[A-Za-z]' '[ZA-Yza-y]')` variabel file_decrypt digunakan untuk menggeser setiap alphabet pada nama file sebanyak 1 kali, namun pergeserannya merupakan kebalikan dari enkripsi. Pergeseran yang dilakukan adalah dengan menggeser ke kiri sebanyak 1 kali yaitu a menjadi z, b menjadi a dan seterusnya.
 - `hour=$((hour-1))` perulangan untuk pergeseran alphabet akan dilakukan sebanyak variabel hour.
 - `mv "$1" /home/liizza/password/"$file_decrypt.txt"` melakukan penamaan ulang (rename) pada file yang telah didekripsi.
---

## Soal 3
### a. Mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" dengan command wget dan menyimpan log messages wget dalam "wget.log"
untuk mendownload 28 gambar dari link yang berkaitan, digunakan kodingan sebagai berikut :
~~~
a=1
no=1

satu(){
until [ $a -eq 29 ]
do
 name="pdkt_kusuma_$no"
  a=$((a + 1))
  wget -O /home/el/Downloads/pdkt_kusuma_$no "https://loremflickr.com/320/240/cat" 2>&1 | tee -a /home/el/Downloads/wget.log
  no=$((no + 1))
done
}
~~~
awalnya, inisiasi variabel `a` sebagai *counter* untuk file yang akan didownload, dan `no` sebagai nomor dalam penamaan file yang telah didownload.
~~~
a=1
no=1
~~~

kemudian, masuk ke fungsi `satu()` di mana akan didownload file ke dalam folder downloads user melalui kodingan berikut :
~~~
until [ $a -eq 29 ]
do
 name="pdkt_kusuma_$no"
  a=$((a + 1))
  wget -O /home/el/Downloads/pdkt_kusuma_$no "https://loremflickr.com/320/240/cat" 2>&1 | tee -a /home/el/Downloads/wget.log
  no=$((no + 1))
done
~~~
berikut penjelasan masing-masing fungsi :
- `until [ $a -eq 29 ]` karena *a* dimulai dari 1, maka looping akan berhenti apabila *a* mencapai nilai 29
- `name="pdkt_kusuma_$no"` menyimpan variabel *name* yang berisi nama file yang diinginkan
- `wget -O /home/el/Downloads/pdkt_kusuma_$no "https://loremflickr.com/320/240/cat" 2>&1 | tee -a /home/el/Downloads/wget.log` mendownload file dari link dengan nama sesuai format (pdkt_kusuma_1, pdkt_kusuma_2, dst.) dan memasukkan hasil log download ke dalam file *wget.log* di dalam folder downloads

---

### b. Download dilakukan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu
berikut adalah perintah crontab yang dilakukan :
~~~
5 6,*/8 * * 1-5,7 bash /home/el/Documents/GitHub/SoalShiftSISOP20_modul1_F07/soal3.sh
~~~
berikut penjelasan masing-masing fungsi :
- `5` menit ke-5, berhubungan dengan jam pada bagian selanjutnya
- `6,*/8` dimulai dari jam 6 (lebih 5 dari bagian sebelum ini), dan diulang setiap 8 jam
- `1-5,7` tiap hari Senin-Jumat, dan Minggu
---

### c. Identifikasi gambar identik dari keseluruhan gambar yang didownload dan dipisahkan antara duplikat dan non duplikat, dan lakukan backup wget.log ke dalam file .log.bak
setelah gambar didownload, untuk memisahkan gambar duplikat dan non duplikat digunakan kodingan sebagai berikut :
~~~
cd /home/el/Downloads

num=1
ber=1

finddup(){
 find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD > /home/el/Downloads/duplicate.log
 sed -i "s|\./|	|g" duplicate.log >> /home/el/Downloads/duplicate.log
}

dup(){
 for file in $dupi
 do
  mv "$file" /home/el/Downloads/duplikat/"duplikat_$ber"
  ber=$((ber + 1))
 done
}

ken(){
 for file in pdkt_kusuma_*
 do
  mv "$file" /home/el/Downloads/kenangan/"kenangan_$num"
  num=$((num + 1))
 done
}

 finddup

 dupi=$(awk -F $'\t' 'NR%2==0 {print $2}' duplicate.log)

 dup
 ken

 cp wget.log{,.bak}
 rm duplicate.log
~~~


awalnya, berpindah directory ke `Downloads` karena proses downloading akan dilakukan di sana.
~~~
cd /home/el/Downloads
~~~

kemudian inisiasi variabel `num` dan `ber` yang keduanya berperan sebagai *counter* penamaan file duplikat dan non duplikat.
~~~
num=1
ber=1
~~~


untuk mendeteksi file mana yang merupakan duplikat, digunakan fungsi `finddup()` sebagai berikut :
~~~
 find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD > /home/el/Downloads/duplicate.log
 sed -i "s|\./|	|g" duplicate.log >> /home/el/Downloads/duplicate.log
~~~
berikut adalah penjelasan masing-masing fungsi :
- `find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD > /home/el/Downloads/duplicate.log` mencari file mana saja yang mempunyai duplikat, dan hasil dari fungsi ini akan dimasukkan ke dalam *duplicate.log*
- `sed -i "s|\./|	|g" duplicate.log >> /home/el/Downloads/duplicate.log` mengganti karakter *./* di dalam file *duplicate.log* untuk mendapatkan nama file yang bersangkutan


setelah itu, barulah dipindahkan file-file duplikat ke dalam folder `duplikat` dan file-file non duplikat (sisanya) ke dalam folder `kenangan`. sebelum dipindah, isi dari file *duplicate.log* dimasukkan ke dalam variabel `dupi` seperti berikut :
~~~
dupi=$(awk -F $'\t' 'NR%2==0 {print $2}' duplicate.log)
~~~


berikut adalah fungsi `dup()` untuk memindahkan file duplikat :
~~~
 for file in $dupi
 do
  mv "$file" /home/el/Downloads/duplikat/"duplikat_$ber"
  ber=$((ber + 1))
 done
~~~
dengan penjelasan masing-masing fungsi antara lain:
- `for file in $dupi` mengecek file di dalam folder *Downloads* yang memiliki nama sesuai dengan isi variabel *dupi*
- `mv "$file" /home/el/Downloads/duplikat/"duplikat_$ber"` memindahkan file yang bersangkutan ke dalam folder *duplikat* dengan nama yang diganti sesuai format pula (duplikat_1, duplikat_2, dst.)


berikut adalah fungsi `ken()` untuk memindahkan file non duplikat :
~~~
 for file in pdkt_kusuma_*
 do
  mv "$file" /home/el/Downloads/kenangan/"kenangan_$num"
  num=$((num + 1))
 done
~~~
dengan penjelasan masing-masing fungsi antara lain:
- `for file in pdkt_kusuma_*` mengecek file di dalam folder *Downloads* yang memiliki format nama *pdkt_kusuma_(terserah)*
- `mv "$file" /home/el/Downloads/kenangan/"kenangan_$num"` memindahkan file yang bersangkutan ke dalam folder *kenangan* dengan nama yang diganti sesuai format pula (kenangan_1, kenangan_2, dst.)


setelah itu, lakukan backup file `wget.log` ke file dengan ekstensi `.log.bak` dengan kodingan sebagai berikut :
~~~
cp wget.log{,.bak}
~~~
