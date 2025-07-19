#!/bin/bash

source tipus.sh

function compdir(){

    local dir1=$1
    local dir2=$2

    let i=1
    suma=0
    for archivo in $(ls $dir1)
    do
        if [ -f $dir2/$archivo ];then
            echo "$archivo"
            ./compfitxer.sh $dir2/$archivo $dir1/$archivo
            ./mesactual.sh $dir2/$archivo $dir1/$archivo
            echo "====================================================================="
            #acumulamos el valor de la suma seleccionando la ultima fila del fichero, sustituyendo %
            # por nada y obteniendo la septima columna, el scale 2 es para obtener dos decimales, sino nos
            #mostraria el resultado en entero sin decimales
            suma=$(echo "scale=2; $suma + $(cat resultat/resultat.txt | sed -n '$p' | sed 's/%//' | awk '{print $7}')" | bc)
            echo $suma
            let i=i+1
        fi
    done

    #obtenemos el numero de ficheros de los archivos y escogemos el mas grande ya que es el valor real de
    #numero de comparaciones. (Ej: no es lo mismo un dir con 3 ficheros que un dir con 4, si los comparamos como maximo
    #obtendremos 75% similitud)

    n_file=$(ls $dir1 | wc -l) 

    if [ $(ls $dir2 | wc -l) -gt $(ls $dir1 | wc -l) ];then
        n_file=$(ls $dir2 | wc -l) 
    fi

    #obtenemos %similitud en scale 2 con dos decimales
    p_similitud=$(echo "scale=2; $suma / $n_file" | bc)
    echo "Els directoris [$dir1 || $dir2]  es $p_similitud% semblant" >> resultat/resultatDir.txt


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
   compdir $1 $2
else
   echo "Los argumentos deben ser directorios."
   exit 2
fi
