#!/bin/bash
informacion(){
        echo "informacion"
}
iniciar() {
        echo "iniciar"
}
detener() {
        echo "detener"
}

procesar(){
	config_dir="~/.shield/config/"
	config_name="modulo_seguridad.cfg"

	typed_commands=$(echo "$1" | awk 'BEGIN{FS="|"}{for(i=1;i<=NF;i++)print $i}' | awk -F " " '{ print $1 }')
	disallowed_commands=$(cat $config_dir$config_name)

	for i in $typed_commands; do
		for j in $disallowed_commands; do
			check=$(echo "$j" | grep "$i")
			if [ "$check" != "" ]; then
				echo "Comando no permitido $i"
				exit 1
			fi
		done
	done
}

source $SHIELD_FOLDER/modulos/modulo_interface.sh
