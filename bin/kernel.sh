#!/bin/bash
#TODO: Tener un solo loadCommand que reciba file y variable donde va a guardar los modules
#RUNME . ./kernel.sh
LAST_REFETCH_CONFIG=`date`
wasConfigChange(){
	SECONDS_DIFF=$(( $(date +%s) - $(date -d"$LAST_REFETCH_CONFIG" +%s)))
	if [[ $SECONDS_DIFF -lt $DELAY ]]
	then
		return
	fi
	MODIFIED_FILES=$(find ~/.shield/config/* -mmin `awk "BEGIN{ print \`echo $DELAY\`/60 }"`)
	for f in $MODIFIED_FILES
	do
		echo $f
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
                ERR=$($(. $SHIELD_FOLDER/$module iniciar> /dev/null) 2>&1);
                echo $ERR | tee -a ~/.shield/shell.log;
        done
}
execCommandModules(){
        for module in ${command_modules[@]}
        do
		RESP=$(. $SHIELD_FOLDER/$module procesar "$@");
		if [ "$RESP"=="error" ]; then
			exit;
		fi
        done
}
execPeriodicModules(){
        for module in ${periodic_modules[@]}
        do
                . $SHIELD_FOLDER/$module procesar "$@"
        done
}
tick(){
	changes=$(wasConfigChange)
	if [[ "$RES" != "" ]];
	then
	        echo $RES
		init
	fi

	execPeriodicModules
}
init(){
	loadCommandModules
	loadPeriodicModules
	startModules
}
init
