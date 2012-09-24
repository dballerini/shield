#!/bin/bash
log(){
        echo `date` $@ >> /tmp/shield.log
}

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
	log "Procesando...$@"
	config_dir="/home/$USER/.shield/config/"
	config_name="modulo_seguridad.cfg"

	withoutCommand=$(echo "$@" | sed -e 's/procesar//g')

	log "Comandos introducidos: " $withoutCommand
	typed_commands=$(echo "$withoutCommand" | awk 'BEGIN{FS="|"}{for(i=1;i<=NF;i++)print $i}' | awk -F " " '{ print $1 }')
	disallowed_commands=$(cat $config_dir$config_name)
	log "Comandos parseados: " $typed_commands
	log "Comandos no permitidos: "$disallowed_commands
	for i in $typed_commands; do
		for j in $disallowed_commands; do
			check=$(echo "$j" | grep "$i")
			if [ "$check" != "" ]; then
				echo "Comando no permitido $i"
				exit 1
			fi
			
		done
	done
	exit;
}

source $SHIELD_FOLDER/modulos/modulo_interface.sh
