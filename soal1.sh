#!/bash/bin

echo "Soal 1.a : region dengan profit paling sedikit"

region=$(awk '
         FNR == 1 {next}
         BEGIN {FPAT = "([^,]+)|(\"[^\"]+\")"} {arr[$13]+=$21}
         END {for (i in arr) {printf "%s %.2f\n", i, arr[i]}}
         ' Sample-Superstore.csv | sort -nk2 | awk '{print $1}' | head -1)
echo "$region"


echo -e  "\nSoal 1.b : (dari region dengan profit paling sedikit) 2 state dengan profit paling sedikit"

state=$(awk -v region="$region" '
        FNR == 1 {next}
        BEGIN {FPAT = "([^,]+)|(\"[^\"]+\")"} ($13~region) {arr[$11]+=$21}
        END {for (i in arr) {printf "%s %.2f\n", i, arr[i]}}
        ' Sample-Superstore.csv | sort -nk2 | awk '{print $1}' | head -2)
echo "$state"

state1=$(echo -e "$state" | sed -n '1p')
state2=$(echo -e "$state" | sed -n '2p')

#echo "$state1"
#echo "$state2"


echo -e "\nSoal 1.c : (dari state dengan profit paling sedikit) 10 produk dengan profit paling sedikit"

product=$(awk -v state1="$state1" -v state2="$state2" '
        FNR == 1 {next}
        BEGIN {FPAT = "([^,]+)|(\"[^\"]+\")"} ($11~state1) || ($11~state2) {arr[$17]+=$21}
        END {for (i in arr) {printf "%s:%.2f\n", i, arr[i]}}
        ' Sample-Superstore.csv | sort -t $":" -nk2 | awk -F: '{print $1}' | head -10 )
echo "$product"

#awk -F: '{print $1}' $product

