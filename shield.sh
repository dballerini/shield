#!/bin/bash
SHIELD_FOLDER=$(readlink /usr/bin/shield.sh| sed 's@/shield\.sh@@g')
DELAY=3
export SHIELD_FOLDER
. $SHIELD_FOLDER/kernel.sh

periodicTasks(){
 while true
  do
    execPeriodicModules
    sleep $DELAY
  done
}
while [ 1 ]
do
 	periodicTasks&

	read -p "$USER:shield$ " command
	echo $command
	execCommandModules $command
done
