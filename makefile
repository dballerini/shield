#Donde vamos a instalar el shield
install_dir=/etc/shield

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
#	mkdir $(install_dir)
#	cp $< $(install_dir)
#	chmod 755 $(install_dir)/$<
#	cp -R $(modulos_dir) $(install_dir)
#	ln -s $(install_dir)/$< /usr/bin/$< 


desinstalar: $(install_dir)/shield.sh 
	rm -R $(install_dir)
	rm /usr/bin/shield.sh

configurar: 
	echo "Nada para ver"

resetear: 
	echo "Nada para ver"
