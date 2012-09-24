#!/bin/bash
modulos_dir=modulos
runnable=shield.sh
kernel=bin/kernel.sh
if [ "$(whoami)" != 'root' ]; then
	echo "Solo podra instalar shield el user root"
	exit 1 
fi

if [ $# -lt 1 ]; then
	echo "Necesitamos que nos digan donde instalar"
	exit 1
else
	install_dir=$1
fi

if [ -f /usr/bin/shield.sh ]; then
	ejecutable=$(ls -l /usr/bin/shield.sh | awk '{print $10}') # 11->10 muestra el shield
	echo "Ya existe una version de Shield instalada. ($ejecutable)"
	exit 1
fi

if [ ! -d $install_dir ]; then
	mkdir $install_dir;
	if [ $? -ne 0 ]; then
		echo "No se pudo crear el dir para instalar Shield"
		exit 1
	fi
fi
cp $runnable $install_dir
chmod 755 $install_dir/$runnable
cp -R $modulos_dir $install_dir
cp $kernel $install_dir
ln -s $install_dir/$runnable /usr/bin/$runnable
