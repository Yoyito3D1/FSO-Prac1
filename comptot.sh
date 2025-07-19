#!/bin/bash

source tipus.sh

rm resultat/resultat.txt
rm resultat/recents.log


function comptot(){

  #guardamos los parametros que se pasan al llamar la funcion
  local dir1=$1
  local dir2=$2
  
  #buscamos todos los directorios y subdirectorios de las rutas y los guardamos en dos ficheros temporales
  find $dir1 -type d  > t1.txt
  find $dir2 -type d  > t2.txt

  n=0
  suma=0
  #iteramos por los ficheros
  while IFS= read -r root1
  do

    while IFS= read -r root2
    do
      
      ./compdir.sh $root1 $root2
      #acumulamos el valor de la suma seleccionando la ultima fila del fichero, sustituyendo %
      # por nada y obteniendo la septima columna. El scale 2 es para obtener dos decimales, sino nos
      #mostraria el resultado en entero sin decimales
      suma=$(echo "scale=2; $suma + $(cat resultat/resultatDir.txt | sed -n '$p' | sed 's/%//' | awk '{print $7}')" | bc)
      
      let n=n+1
      #contamos el numero de combinaciones de comparaciones entre directorios (ej: por cada directorio de la ruta1 se compara
      #con todos los directorios y subdirectorios de la otra ruta)
      
      echo $n
    done < t2.txt

  done < t1.txt

  #obtenemos el valor de %de similitud entre dos rutas dividiendo la suma acumulada por el numero de comparaciones hechas
  p_similitud=$(echo "scale=2; $suma / $n" | bc)
  echo "Les rutes [$dir1 || $dir2]  son $p_similitud% semblant" >> resultat/resultatRoot.txt

  #borramos ficheros temporales
  rm t1.txt t2.txt

}

#SECCION DE COMPROBACION DE ARGUMENTOS
#=====================================

#dos argumentos necesarios
if [ $# -ne 2 ]; then
  echo "Se necesitan exactamente dos argumentos."
  exit 1
fi

#obtenemos los valores de los return por cada fichero
tipus $1
res1=$?

tipus $2
res2=$?

#comprobamos si son ficheros y ejecutamos codigo
if [ $res1 -eq 2 ] && [ $res2 -eq 2 ]; then
   comptot $1 $2
else
   echo "Los argumentos deben ser directorios."
   exit 2
fi

