#!/bin/bash

filename=$1;
index=0;
ogrenci=0;
gecenOgrenciler=0;
kalanOgrenciler=0;
classAverage=0;
standarDeviation=0;
baraj=0;

if [ -f $filename ]; then
	if [ $# -eq 1 ]; then 
		vizeNotlari=( $(awk '{print $2}' notlar.txt) )
		finalNotlari=( $(awk '{print $3}' notlar.txt) )
		
		for ((i=0; i<=9; i++))
		do
			ortalamalar[$i]="$(echo ${vizeNotlari[$i]} / 2 + ${finalNotlari[$i]} / 2 | bc -l)"
			
			if (( $(echo "${ortalamalar[$i]} >= 35" | bc -l) )); then
				inBDS[$index]=${ortalamalar[$i]}
				inBDSfinal[$index]=${finalNotlari[$i]}
				ogrenci=$(($ogrenci+1))
				index=$(($index+1))
			else
				kalanOgrenciler=$(($kalanOgrenciler+1))
			fi
		done
		
		toplam=0;

		for index in ${!inBDS[*]}
		do
			toplam="$(echo $toplam+${inBDS[$index]} | bc -l)"
			classAverage="$(echo $toplam/${#inBDS[*]} | bc -l)"		
		done
		
		islem=0;
		karesi=0;
		toplama=0;
		bolme=0;
		N="$(echo ${#inBDS[*]}-1 | bc -l)";

		for index in ${!inBDS[*]}
		do
			islem="$(echo ${inBDS[$index]}-$classAverage | bc -l)"
			karesi="$(echo $islem\*$islem | bc -l)"
			toplama="$(echo $toplama+$karesi | bc -l)"
		done
		
		bolme="$(echo $toplama/$N | bc -l)"
		standardDeviation="$(echo sqrt "($bolme)" | bc -l)"
		
		islem1="$(echo $standardDeviation\*1.645 | bc -l)"
		baraj="$(echo $classAverage-$islem1 | bc -l)"

		if (( $ogrenci < 10 )) || (( $standardDeviation < 8 )) ; then
			baraj=45
		fi

		for index in ${!inBDSfinal[*]}
		do
			if (( $(echo "${inBDSfinal[$index]} >= 45" | bc -l) )) && (( $(echo "${inBDS[$index]} >= $baraj" | bc -l) )); then
				gecenOgrenciler=$(($gecenOgrenciler+1))
			else
				kalanOgrenciler=$(($kalanOgrenciler+1))
			fi
		done

		echo "$kalanOgrenciler students failed in this course"

	else
		echo "THE NUMBER OF ARGUMENTS IS MISSING !";
	fi
else
echo "$filename IS NOT EXISTS !";
fi

