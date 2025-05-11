#!/data/data/com.termux/files/usr/bin/bash

# Comprueba si se han proporcionado dos argumentos (nuevos IMEIs)
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <nuevo_imei1> <nuevo_imei2>"
    exit 1
fi

NEW_IMEI1=$1
NEW_IMEI2=$2

# Verifica si el dispositivo tiene privilegios de root
if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse con privilegios de root."
    exit 1
fi

# Ruta al archivo de IMEI
IMEI_FILE="/efs/imei/imei"

# Cambia los IMEIs
echo "$NEW_IMEI1" > $IMEI_FILE
echo "$NEW_IMEI2" > $IMEI_FILE

echo "IMEI cambiado a $NEW_IMEI1 y $NEW_IMEI2"

# Reinicia el dispositivo para aplicar los cambios
reboot

