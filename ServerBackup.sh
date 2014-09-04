#!/bin/bash
#
#		Script para hacer un Backup del servidor web en Dropbox
#	        creado por:
#		Br. Igor Escalona
#		06 de julio de 2014 - 23 de agosto de 2014
#
#		Si se elimina el read al final, y el verbose (v) de la copia
#		se puede usar para hacer copias automaticas
#
carpeta_dropbox=$HOME/Dropbox
carpeta_google=$HOME/'Google Drive'; #prueba Google Drive
carpeta_server=/var/www

echo "==>Buscando la carpeta del servidor" 
if [ -e $carpeta_server ]; then															#Si se encuentra la carpeta se procede a realizar la copia
	echo "==>Carpeta del servidor encontrada";	
else
	echo "==>Carpeta del servidor no encontrada";											#Si no encuentra la carpeta del servidor
	echo "==>La carpeta de su servidor deberia estar ser: "$carpeta_server;					#termina la ejecución del Script
	cd
	exit
fi

if [ -e $carpeta_dropbox ]; then														#Verifico si existe $HOME/Dropbox, y luego 
	if [ -d $carpeta_dropbox ]; then													#Si existe la dirección verifico que sea un directorio
		cd $carpeta_dropbox;														#Si está instalado procedo a ubicarme en la carpeta
		if  [ -e $carpeta_dropbox/Server ]; then
			if [ -d $carpeta_dropbox/Server ]; then
				echo "==>Actualizando la carpeta del servidor a: "$carpeta_dropbox/Server;				#si existe la carpeta Server en Dropbox
				cp -vfur $carpeta_server/* $carpeta_dropbox/Server;  									#Se copia los ficheros actualizados nada más
				echo "==>Los archivos de la carpeta del servidor han sido actualizados con éxito a: "$carpeta_dropbox/Server;		
			else
				echo "==>Error!!!";															#Si $HOME/Dropbox/Server existe pero es un archivo
				echo "==>"$carpeta_dropbox/Server" no es un directorio";							#y no un directorio debe ser eliminado para continuar
				echo "==>Debe eliminarlo para continuar";
				read;			
				exit;			
			fi
		else		
			echo "==>Creando la carpeta del servidor en Dropbox";   		
			mkdir Server;																	#Si no existe la carpeta se crea
			echo "==>Copiando la carpeta del servidor a: " $carpeta_dropbox/Server;
			cp -vfnr $carpeta_server/* $carpeta_dropbox/Server;									#y se copian todos los archivos de la carpeta
			echo "==>Los archivos de la carpeta del servidor han sido copiados con éxito a: "$carpeta_dropbox/Server;
		fi
	else
		echo "==>Error!!!"																     #Si $HOME/Dropbox existe pero es un archivo
		echo "==>"$carpeta_dropbox/Server" no es un directorio";									#y no un directorio debe ser eliminado para continuar
		echo "==>Debe eliminarlo para continuar";
		read;			
	fi
else
	echo "==>Error!!!";
	echo "==>la carpeta "$carpeta_dropbox" no existe";
	echo "==>Dropbox debe estar instalado para continuar";
fi
cd
read
