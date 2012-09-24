#!/bin/bash
modulos_dir=modulos
runnable=shield.sh

if [ "$(whoami)" != 'root' ]; then
        echo "Solo podra configurar shield el user root"
        exit 1
fi

if [ $# -gt 0 ];then
        user_to_config=$1
else
        echo "Debes especificar a que usuario queres desinstalarle shield"
        exit 1
fi

shell_user=$(cat /etc/passwd | grep "$user_to_config" | awk 'BEGIN {FS=":"} {print $7}')
echo "Shell: $shell_user"

if [ $shell_user != "/usr/bin/shield.sh" ]; then
	echo "$shell_user esta usando otro shell."
	exit 1		
fi

echo "Desinstalando Shield a : $user_to_config"
chsh -s /bin/bash $user_to_config
eval "rm -R ~$user_to_config/.shield"
