#!/bin/bash

file1=$1
file2=$2

data1=$(date -d $(stat -c %y $file1 | awk '{print $1}') +%s) # Fecha fichero1 en segundos
data2=$(date -d $(stat -c %y $file2 | awk '{print $1}') +%s) # Fecha fichero2 en segundos

if [ $data1 -eq $data2 ]
then
    data1=$(date -d $(stat -c %y $file1 | awk '{print $2}') +%s) # Fecha y hora fichero1 en segundos
    data2=$(date -d $(stat -c %y $file2 | awk '{print $2}') +%s) # Fecha y hora fichero2 en segundos
    
    if [ $data1 -gt $data2 ]
    then
        echo "$(pwd $file1)/$file1" >> resultat/recents.log 
    else
        echo "$(pwd $file2)/$file2" >> resultat/recents.log
    fi

elif [ $data1 -gt $data2 ]
then
    echo "$(pwd $file1)/$file1" >> resultat/recents.log
else
    echo "$(pwd $file2)/$file2" >> resultat/recents.log
fi
