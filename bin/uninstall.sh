#!/bin/bash
modulos_dir=modulos
runnable=shield.sh
install_dir=/etc/shield
users_with_shield=$(cat /etc/passwd | grep "shield.sh" | awk 'BEGIN {FS=":"} {print $1}')

if [ "$users_with_shield" != "" ]; then
	echo "Usuarios aún usando Shield: "
	for user in $users_with_shield
	do
		echo "$user"
	done
	exit 1
fi

if [ "$(whoami)" != 'root' ]; then
	echo "Solo podra desinstalar shield el user root"
	exit 1 
fi

if [ $# -gt 0 ];then
	install_dir=$1
else
	if [ -f /usr/bin/shield.sh ]; then
		install_dir=$(ls -l /usr/bin/shield.sh | awk '{print $11}' | sed 's/shield\.sh//')
	else
		echo "No se encontro una instalación de Shield"
		exit 1
	fi
fi

echo "Desinstalando de : $install_dir"
rm -R $install_dir
rm /usr/bin/shield.sh
