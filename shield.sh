#!/bin/bash
SHIELD_FOLDER=$(readlink /usr/bin/shield.sh| sed 's@/shield\.sh@@g')
export SHIELD_FOLDER
./kernel.sh
while [ 1 ]
do
	read -p "$USER:shield$ " command
	echo $command
done
