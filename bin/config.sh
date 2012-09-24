#!/bin/bash
modulos_dir=modulos
runnable=shield.sh

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

if [ ! `grep $user_to_config /etc/passwd`  ];then
	echo "El usuario especificado no existe"
	exit 1
else
	echo "El usuario esta"
fi

echo "Configurando Shield a: $user_to_config" 
chsh -s /usr/bin/shield.sh $user_to_config
eval "mkdir -p ~$user_to_config/.shield/config" #BDD, se aceptan sugerencias
eval "cp -r default/* ~$user_to_config/.shield/config"
eval "chown $user_to_config ~$user_to_config/.shield" #Esta bueno esto? El usuario podría cambiar su config
