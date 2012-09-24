#!/bin/bash
case "$1" in
	informacion)
		info $@
	;;
	iniciar)
		iniciar $@
	;;
	detener)
		detener $@
	;;
	procesar)
		procesar $@
	;;
	*)
		echo "informacion/iniciar/detener/procesar/"
	;;

esac
