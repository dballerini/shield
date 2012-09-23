#!/bin/bash
#TODO: Tener un solo loadCommand que reciba file y variable donde va a guardar los modules
#RUNME . ./kernel.sh
LAST_REFETCH_CONFIG=`date`
log(){
	echo `date` $@ >> /tmp/shield.log
}
wasConfigChange(){
	SECONDS_DIFF=$(( $(date +%s) - $(date -d"$LAST_REFETCH_CONFIG" +%s)))
	if [[ $SECONDS_DIFF -lt $DELAY ]]
	then
		log "wait!, time was decremented "$SECONDS_DIFF 
		return
	fi
	MODIFIED_FILES=$(find ~/.shield/config/* -mmin `awk "BEGIN{ print \`echo $DELAY\`/60 }"`)
	for f in $MODIFIED_FILES
	do
		echo "The file "$f " was changed"
		log "modified files: "$f
	done
	LAST_REFETCH_CONFIG=`date`
}
loadCommandModules(){
        for command_module in $(grep ":on" ~/.shield/config/modulos_comando.cfg | awk -F":" '{ print $1 }')
         do
                modules=("${modules[@]}" "$module");
                command_modules=("${command_modules[@]}" "$command_module");
         done
	 export modules
	 export command_modules
}
loadPeriodicModules(){
        for periodic_module in $(grep ":on" ~/.shield/config/modulos_periodicos.cfg | awk -F":" '{ print $1 }')
         do
                modules=("${modules[@]}" "$module");
                periodic_modules=("${periodic_modules[@]}" "$periodic_module");
         done
         export modules
         export command_modules
}

startModules(){
        for module in ${modules[@]}
        do
                RESP=$(. $SHIELD_FOLDER/$module iniciar 2> &1)
                log "startModules" $module "answer" $RESP
		if [[ "$RESP" == "error*" ]]; then
	                echo $ERR | tee -a ~/.shield/shell.log;
                        log "exiting for " $module
                        exit;
                fi
        done
}
execCommandModules(){
	log "execCommandModules - ShieldFolder" $SHIELD_FOLDER
        for module in ${command_modules[@]}
        do
		RESP=$(. $SHIELD_FOLDER/$module procesar "$@");
		log "onProcess" $module "answer" $RESP
		if [[ "$RESP" == "error*" ]]; then
			log "exiting for " $module
			exit;
		fi
        done
}
execPeriodicModules(){
	log "running modules: "${periodic_modules[@]}
        for module in ${periodic_modules[@]}
        do
                . $SHIELD_FOLDER/$module procesar
        done
}
stopModules(){
        for module in ${modules[@]}
        do
                . $SHIELD_FOLDER/$module detener
        done

}
tick(){
	local changes=$(wasConfigChange)
	if [[ "$changes" != "" ]];
	then
	        echo $changes
		log "some change in " $changes
		stopModules
		init
	fi

	execPeriodicModules
}
init(){
	log "initiating..."
	modules=()
	command_modules=()
	periodic_modules=()
	loadCommandModules
	loadPeriodicModules
	startModules
}
init
