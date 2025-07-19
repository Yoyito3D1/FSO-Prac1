import os
import sys
import subprocess


# reseteamos el archivo resultat/resultatDir.txt para que sea más fácil de leer cada vez que ejecutamos
if os.path.exists("resultat/resultatDir.txt"):
    os.remove("resultat/resultatDir.txt")

# SECCION DE COMPROBACION DE ARGUMENTOS
# =====================================

# tres argumentos necesarios
if len(sys.argv) != 4:
    print("Se necesitan exactamente tres argumentos.")
    sys.exit(1)

# obtener las rutas de los dos argumentos
ruta1 = sys.argv[1]
ruta2 = sys.argv[2]

# comprobar si son ficheros
if os.path.isfile(ruta1) and os.path.isfile(ruta2):
    subprocess.run(["./compfitxer.sh", sys.argv[1], sys.argv[2]])
    
# comprobar si son directorios
elif os.path.isdir(ruta1) and os.path.isdir(ruta2):
    subprocess.run(["./comptot.sh", sys.argv[1], sys.argv[2]])

# si no son ni ficheros ni directorios, imprimir un mensaje de error
else:
    print("Los argumentos deben ser iguales ya que no podemos comparar un fichero solo con una ruta.")
    sys.exit(2)

# reseteamos el directorio en caso que exista
if os.path.exists(sys.argv[3]):
    os.system("rm -rf " + sys.argv[3])

# creamos el directorio con la información de recents.log
subprocess.run(["./crearnou.sh", sys.argv[3]])
