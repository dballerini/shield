#!/bin/bash

echo $1
if [ $# -gt 1 ]; then
	install_dir=$1
fi

if [ -f /usr/bin/shield.sh ]; then
	ejecutable=$(ls -l /usr/bin/shield.sh | awk '{print $11}')
	echo "Ya existe una version de Shield instalada. ($ejecutable)"
	exit 1
fi

mkdir $install_dir

cp $< $(install_dir)
chmod 755 $(install_dir)/$<
cp -R $(modulos_dir) $(install_dir)
ln -s $(install_dir)/$< /usr/bin/$<

