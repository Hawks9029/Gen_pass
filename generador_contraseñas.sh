#!/bin/bash

# Verificar si Termux tiene acceso a la tarjeta SD
echo -e "\e[35m
╔╦══╦═╦═╦╦╦═╦═╦═╦═╦╗
║║╔═╣═╣║║║║░║║║╚╣╚╣║
║║╚╝║═╣║║║║╔╣╩╠╗╠╗║║
║╚══╩═╩╩═╝╚╝╚╩╩═╩═╝║
╚══════════════════╝\e[0m"

echo -e "\e[1;33mGENERADOR_DE CONTRASEÑAS\e[0m"


if [ ! -d "/storage/emulated/0" ]; then
  echo "No se encontró acceso a la tarjeta SD. Asegúrate de haber otorgado permisos."
  exit 1
fi

# Archivo de salida en la tarjeta SD
OUTPUT_FILE="/storage/emulated/0/contraseñas_seguras.txt"

# Lista de nombres latinos
NOMBRES=("Lucius" "Marcus" "Julia" "Aurelia" "Flavia" "Tiberius" "Cassius" "Octavia" "Cornelia" "Gaius")

# Función para generar una contraseña
generar_contraseña() {
  NOMBRE=${NOMBRES[$RANDOM % ${#NOMBRES[@]}]}
  RANDOM_CHARS=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()_+-=' | head -c 8)
  echo "${NOMBRE}${RANDOM_CHARS}"
}

# Solicitar al usuario cuántas contraseñas generar
read -p "¿Cuántas contraseñas deseas generar? " NUM

# Validar que la entrada sea un número
if ! [[ "$NUM" =~ ^[0-9]+$ ]]; then
  echo "Por favor, ingresa un número válido."
  exit 1
fi

# Generar las contraseñas y guardarlas en el archivo
echo "Generando $NUM contraseñas seguras..."
> "$OUTPUT_FILE"
for ((i = 1; i <= NUM; i++)); do
  CONTRASEÑA=$(generar_contraseña)
  echo "$CONTRASEÑA" >> "$OUTPUT_FILE"
done

echo "¡Contraseñas generadas y guardadas en $OUTPUT_FILE!"