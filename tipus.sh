#!/bin/bash

#utilitzaremos el return para retornar el valor de la funcion
function tipus() {

    #cogemos el parametro que se nos pasa por la funcion
    local file=$1

    if [ -f $file ]
    then 
        echo "es fitxer"
        return 1
    elif [ -d $file ]
    then
        echo "es directori"
        return 2
    else
        echo "es una altre cosa"
        return 3
    fi 

}

#exportamos la funcio
export -f tipus