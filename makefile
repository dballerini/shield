#Donde vamos a instalar el shield
install_dir=/etc/shield
#user=coco

#Directorio donde tenemos los comandos
modulos_dir=modulos
comandos_dir=$(modulos_dir)/comando
periodicos_dir=$(modulos_dir)/periodicos

#Comandos que proveemos
modules=$(comandos_dir)/auditoria/modulo_auditoria.sh \
	$(comandos_dir)/seguridad/modulo_seguridad.sh \
	$(comandos_dir)/sesiones/modulo_sesiones.sh \
	$(periodicos_dir)/limitacion/modulo_limitacion.sh
	

instalar: shield.sh $(modules) 
	./bin/install.sh $(install_dir)

desinstalar:  
	./bin/uninstall.sh $(install_dir)

configurar: 
	@./bin/config.sh $(user)

resetear: 
	echo "Nada para ver"
