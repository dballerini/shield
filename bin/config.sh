#!/bin/bash
modulos_dir=modulos
runnable=shield.sh
install_dir=/etc/shield

if [ "$(whoami)" != 'root' ]; then
	echo "Solo podra configurar shield el user root"
	exit 1 
fi

if [ ! -f /usr/bin/shield.sh ]; then
	echo "No se encontro el ejecutable de shield."
	exit 1
fi

if [ $# -gt 0 ];then
	user_to_config=$1
else
	echo "Debes especificar a que usuario queres instalarle shield"
	exit 1
fi

echo "Configurando Shield a : $user_to_config"
chsh -s /usr/bin/shield.sh $user_to_config
