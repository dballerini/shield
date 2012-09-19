#!/bin/bash
loadModules(){
        for module in $(grep ":on" ~/.shield/modulos.cfg | awk -F":" '{ print $1 }')
         do
                modules=("${modules[@]}" "$module");
         done
}
startModules(){
        for module in ${modules[@]}
        do
                ERR=$($(. $SHIELD_FOLDER/$module iniciar> /dev/null) 2>&1);
                echo $ERR | tee -a ~/.shield/shell.log;
        done
}
loadModules
startModules
