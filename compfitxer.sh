#!/bin/bash

#s: que queremos buscar y remplazar
#g: sustitucion global
# -i: cambiamos el fichero directamente

#   for arg in "${args[@]}"
#   do            
#        sed -i "s/ //g" $arg 
#        sed -i '/^$/d' $arg 
#        sed -i 's/[A-Z]/\L&/g' $arg 
#        sed -i ':a; N; s/\n//; ta' $arg 
#   done

#importamos tipus
source tipus.sh

#lista argumentos
args=("$@")

function compfitxer(){

   #con el local obtenemos los parametros que se le pasan por compfitxer
   local file1=$1
   local file2=$2
   
   #nos muestra lineas diferentes en un fichero y nos retorna el numero de lineas
   diff -Bbiw $file1 $file2 >&2
   
   #eliminamos los espacios vacios + lineas en blanco
   i=1
   for arg in "${args[@]}"
   do            
        sed -e "s/ //g; /^$/d" $arg  > temp${i}.txt
        let i=i+1
   done
   
   #obtenemeos el numero de lineas iguales y cogemos la mas pequeña ya que es la autentica,
   #ya que el grep solo coge las lineas comparadas del primer fichero de argumento, por eso hay que comprobar
   #los dos ficheros al reves y coger la mas pequeña. 
   let iguales=$(grep -i -Fxf temp1.txt temp2.txt | wc -l)
   let iguales2=$(grep -i -Fxf temp2.txt temp1.txt | wc -l)
      if [ $iguales2 -lt $iguales ];then 
      iguales=$iguales2
   fi

   #obtenemos las lineas comparadas, obtenemos solo el numero y lo convertimos a entero con el let
   let lineas1=$(cat temp1.txt | wc -l)
   let lineas2=$(cat temp2.txt | wc -l)

   #escogemos la mas grande para hacer el calculo porque no es lo mismo comparar 3 lineas com 4 lineas,
   #por mucho que esas 3 lineas sean exactamente iguales como mucho el fichero podra parecerse en 75%
   if [ $lineas1 -gt $lineas2 ];then 
      lineas2=$lineas1
   fi
   
   #operacion final amb scale 2 obtenim 2 decimals
   echo "$iguales / $lineas2 * 100"
   operacion=$(echo "scale=2; $iguales / $lineas2 * 100" | bc)
   echo "Els fitxers [$file1 || $file2]  es $operacion% semblant" >> resultat/resultat.txt

   #borramos ficheros temporales
   rm temp1.txt temp2.txt

}


#SECCION DE COMPROBACION DE ARGUMENTOS
#=====================================

#necesitamos dos argumentos de entrada
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
if [ $res1 -eq 1 ] && [ $res2 -eq 1 ]; then
   compfitxer $1 $2
else
   echo "Los argumentos deben ser ficheros."
   exit 2
fi








