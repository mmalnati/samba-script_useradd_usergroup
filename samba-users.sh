# /bin/bash
#
#Script para crear usuarios de sistema y samba

#Verifica que el usuario que va a correr el script sea "root"
WHOAMI=`/usr/bin/whoami`
if [ $WHOAMI != "root" ]; then
echo "Hay que ser root para poder correr el script!"
exit 1
fi
##############################################################
#Limpio la pantalla
clear
#Lee el archivo ubicado en /root/names.txt y realiza un cat

NEW_USERS="/root/names.txt"
cat ${NEW_USERS} | \

#Le agrega a cada columna una variable (USER, GROUP, SMBPASS)

while read USER GROUP SMBPASS ; do

#Crea los grupos y agrega los usuarios a esos grupos

   groupadd ${GROUP} 2> /dev/null
   useradd -s /usr/sbin/nologin -G ${GROUP} $USER

# adduser --no-create-home --disabled-password --disabled-login $USER

#Ingresa la clave para el nuevo usuario y envía un mensaje de que se creó

   (echo  "$SMBPASS"; echo "$SMBPASS" ) | passwd $USER
   echo Se creo el usuario $USER

#Habilito los usuarios en samba y le asigna su correspondiente password

   (echo "$SMBPASS"; echo "$SMBPASS" ) | smbpasswd -s -a $USER

done
###############################################################
