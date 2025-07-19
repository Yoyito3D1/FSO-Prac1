#!/bin/bash

# Obtener el directorio recibido como parámetro
dir=$1

# Crear el directorio si no existe
mkdir -p "$dir"

# Leer el archivo recents.log línea por línea
cat resultat/recents.log | while read line
do
  #Obtener la ruta del archivo original
  orig=$(echo "$line")
  #borro hasta el directorio actual y luego elimino FSO-prac1
  orig=$(echo $orig | grep -o "/FSO-prac1.*" | sed 's/FSO-prac1\///')
  #borro la primera barra inicial ya que impide que lo detecte como directorio
  orig=${orig#"/"}
  


  echo $orig
  #Obtenemos la ruta del archivo de destino
  dest="$dir/$(dirname "$orig")"
  # Creamos el directorio destino si no existe
  mkdir -p "$dest"
  # Copiamos el archivo original al directorio destino
  cp -p "$orig" "$dest"

done
