#!/bin/bash

source tipus.sh


#reseteamos el fichero resultatDir para que sea mas agradable a la vista de leer cada vez que ejecutemos
if [ -f "resultat/resultatDir.txt" ];then
   rm "resultat/resultatDir.txt"
fi

#SECCION DE COMPROBACION DE ARGUMENTOS
#=====================================

#tres argumentos necesarios
if [ $# -ne 3 ]; then
  echo "Se necesitan exactamente tres argumentos."
  exit 1
fi

#obtenemos los valores de los return por cada fichero
tipus $1
res1=$?

tipus $2
res2=$?

tipus $3
res3=$?


#si son ficheros comparamos a nivel de lineas si son directorios comparamos a nivel de directorios o rutas
if [ $res1 -eq 1 ] && [ $res2 -eq 1 ]; then
    ./compfitxer.sh $1 $2
elif [ $res1 -eq 2 ] && [ $res2 -eq 2 ]; then

   ./comptot.sh $1 $2
else
   echo "Los argumentos deben de ser iguales ya que (ej: no podemos comparar un fichero solo con una ruta)"
   exit 2
fi

#reseteamos el directorio en caso que exista
if [ -d $3 ]; then
  rm -rf $3
fi
#creamos el directorio con la informacion de recents.log
./crearnou.sh $3

