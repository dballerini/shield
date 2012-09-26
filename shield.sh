#!/bin/bash
SHIELD_FOLDER=$(readlink /usr/bin/shield.sh| sed 's@/shield\.sh@@g')
DELAY=15
export SHIELD_FOLDER
. $SHIELD_FOLDER/kernel.sh

ayudaBuiltIn(){
 if [ $# -gt 1 ]; then
	echo "Demasiados parámetros para el Built In ayuda"
	echo "Ejemplo: ayuda [builtIn]"
	return
 fi
 if [ $# -lt 1 ]; then
	echo "info_modulos [nombre_modulo]"
	echo "listar_modulos"
	echo "actualizar_modulos"
	echo "mostrar [variable_shell]"
	echo "salir"
	echo "apagar"
 else
	case $1 in
	info_modulos)
		echo "info_modulos [nombre_modulo]"
		;;
	listar_modulos)	
		echo "listar_modulos"
		;;
	actualizar_modulos)
		echo "actualizar_modulos"
		;;
	mostrar)
		echo "mostrar [variable_shell]"
		;;
	salir)
		echo "salir"
		;;
	apagar)
		echo "apagar"
		;;
	*)
		echo "Built In inexistente"
		;;
	esac
 fi
}

periodicTasks(){
 while true
  do
    tick
    sleep $DELAY
  done
}

periodicTasks&

while [ 1 ]
do

	read -p "$USER:shield$ " command
	echo $command
	case $command in
	ayuda)		
		shift;		
		ayudaBuiltIn $command 
		;;
	info_modulos)
		echo "leer modulos activos para el usuario e invocarlos con informacion"
		;;
	listar_modulos)
		echo "path de los modulos activos para el usuario"
		;;
	actualizar_modulos)
		echo "llamada a la funcion registrar e inicializar modulos"
		;;
	mostrar)
		shift;		
		if [ $command -gt 1 ]; then
			echo "Demasiados parámetros para el Built In mostrar"
			return		
		fi
		if [ $#command -lt 1 ]; then
			echo "Es requerido por lo menos un parámetro para el Built In mostrar"
		return;
		else
			echo "MOSTRAR VARIABLE: $command"
		fi
		;;			
	salir)
		echo "Logout"
		;;	
	apagar)
		echo "Shutdown"
		sudo shutdown -h now  		
		;;
	*)
		execCommandModules $command
		;;
	esac
done
