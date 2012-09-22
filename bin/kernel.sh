#!/bin/bash
#TODO: Tener un solo loadCommand que reciba file y variable donde va a guardar los modules
loadCommandModules(){
        for command_module in $(grep ":on" ~/.shield/modulos_comando.cfg | awk -F":" '{ print $1 }')
         do
                modules=("${modules[@]}" "$module");
                command_modules=("${command_modules[@]}" "$command_module");
         done
	 export modules
	 export command_modules
}
loadPeriodicModules(){
        for periodic_module in $(grep ":on" ~/.shield/modulos_periodicos.cfg | awk -F":" '{ print $1 }')
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
loadCommandModules
loadPeriodicModules
startModules
