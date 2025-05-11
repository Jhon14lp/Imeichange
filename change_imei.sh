#!/data/data/com.termux/files/usr/bin/bash

# Verificar si el dispositivo tiene permisos de root
if ! [ $(id -u) = 0 ]; then
   echo "Este script necesita permisos de root. Ejecútalo como superusuario."
   exit 1
fi

# Función para obtener el IMEI actual
get_current_imei() {
    IMEI=$(cat /sys/class/imei/imei)
    echo "IMEI actual: $IMEI"
}

# Función para cambiar el IMEI
change_imei() {
    local new_imei=$1
    echo $new_imei > /sys/class/imei/imei
    echo "IMEI cambiado a: $new_imei"
}

# Obtener el IMEI actual
get_current_imei

# Solicitar al usuario los nuevos tres últimos dígitos del IMEI
read -p "Introduce los tres nuevos últimos dígitos del IMEI: " new_last_digits

# Verificar que los dígitos introducidos sean válidos
if ! [[ $new_last_digits =~ ^[0-9]{3}$ ]]; then
    echo "Los dígitos introducidos no son válidos. Deben ser exactamente tres números."
    exit 1
fi

# Obtener el IMEI actual nuevamente para asegurarse de que no ha cambiado
get_current_imei

# Construir el nuevo IMEI
new_imei="${IMEI:0:11}${new_last_digits}"

# Cambiar el IMEI
change_imei $new_imei


