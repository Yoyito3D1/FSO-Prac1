#!/usr/bin/env python3
import os
import subprocess
import shutil
import sys


if os.path.exists("resultat/resultat.txt"):
    os.remove("resultat/resultat.txt")
if os.path.exists("resultat/recents.log"):
    os.remove("resultat/recents.log")

#obtenemos argumentos que se pasan por terminal
dir1 = sys.argv[1]
dir2 = sys.argv[2]

#usamos subprocess para imitar las comandas de bash de terminal
with open("t1.txt", "w") as t1_file:
    subprocess.run(["find", dir1, "-type", "d"], stdout=t1_file)

with open("t2.txt", "w") as t2_file:
    subprocess.run(["find", dir2, "-type", "d"], stdout=t2_file)

n = 0
suma = 0
#iteramos por todos los directorios
with open("t1.txt") as t1_file:
    for root1 in t1_file:
        with open("t2.txt") as t2_file:
            for root2 in t2_file:
                #usamos subproces para simular los comandos de terminal, asi ejecutamos el fichero bash
                subprocess.run(["./compdir.sh", root1.strip(), root2.strip()])
                with open('resultat/resultatDir.txt', 'r') as archivo:
                    #seleccionamos la penultima fila del fichero, despues la columna 7 (indice 6), borramos % 
                    # y pasamos a float para el calculo
                    similitud = float(archivo.read().split("\n")[-2].split()[6].replace("%", ""))   
                suma += similitud
                n += 1

p_similitud = suma / n
print(f"Les rutes [{dir1} || {dir2}] són {p_similitud:.2f}% semblant")

#en modo append para no borrar el contenido anterior y lo ponemos al final
with open("resultat/resultatRoot.txt", "a") as resultat_file:
    resultat_file.write(f"Les rutes [{dir1} || {dir2}] són {p_similitud:.2f}% semblant\n")

#borramos los ficheros temporales
os.remove("t1.txt")
os.remove("t2.txt")
