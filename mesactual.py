#!/usr/bin/env python

import os
import sys
import datetime
import time

file1 = sys.argv[1]
file2 = sys.argv[2]

data1 = int(os.path.getmtime(sys.argv[1]))  # Fecha fichero1 en segundos
data2 = int(os.path.getmtime(sys.argv[2]))  # Fecha fichero2 en segundos

#aqui como la fecha esta en dia + hora solo hace falta comparar tiempos en segundos
if data1 > data2:
    with open('resultat/data.txt', 'a') as f:
        f.write(os.path.abspath(file1) + '\n')
else:
    with open('resultat/data.txt', 'a') as f:
        f.write(os.path.abspath(file2) + '\n') 