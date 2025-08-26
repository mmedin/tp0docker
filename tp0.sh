#!/bin/bash

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Función para mostrar el menú
show_menu() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                    TP0 - Docker Setup                        ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Selecciona una opción:${NC}"
    echo ""
    echo -e "${GREEN}1)${NC} Iniciar containers"
    echo -e "${GREEN}2)${NC} Acceder a server"
    echo -e "${GREEN}3)${NC} Acceder a client"
    echo -e "${GREEN}4)${NC} Detener containers"
    echo -e "${RED}0)${NC} Salir"
    echo ""
    echo -e "${PURPLE}Opción:${NC} "
}

# Función para iniciar containers
start_containers() {
    echo -e "${BLUE}🛠️  Iniciando containers...${NC}"
    
    # Detener containers existentes
    docker-compose -f docker-compose.dev.yml down 2>/dev/null
    
    # Iniciar containers
    docker-compose -f docker-compose.dev.yml up -d
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Containers iniciados correctamente${NC}"
        echo ""
        echo -e "${YELLOW}Próximos pasos:${NC}"
        echo "  1. Selecciona opción 2 para acceder al servidor"
        echo "  2. Dentro del servidor: cd /workspace/server && make debug"
        echo "  3. Ejecuta: ./bin/server"
        echo "  4. Selecciona opción 3 para acceder al cliente (en otra terminal)"
        echo "  5. Dentro del cliente: cd /workspace/client && make debug"
        echo "  6. Ejecuta: ./bin/client"
    else
        echo -e "${RED}❌ Error iniciando containers${NC}"
    fi
    
    echo ""
    read -p "Presiona Enter para continuar..."
}

# Función para acceder al servidor
access_server() {
    echo -e "${BLUE}🔧 Accediendo al servidor...${NC}"
    docker exec -it tp0-server-dev bash
}

# Función para acceder al cliente
access_client() {
    echo -e "${BLUE}🔧 Accediendo al cliente...${NC}"
    docker exec -it tp0-client-dev bash
}

# Función para detener containers
stop_containers() {
    echo -e "${BLUE}⏹️  Deteniendo containers...${NC}"
    
    # Detener containers
    docker-compose -f docker-compose.dev.yml down
    
    echo -e "${GREEN}✅ Containers detenidos${NC}"
    echo ""
    read -p "Presiona Enter para continuar..."
}

# Función principal
main() {
    while true; do
        show_menu
        read -r choice
        
        case $choice in
            1)
                start_containers
                ;;
            2)
                access_server
                ;;
            3)
                access_client
                ;;
            4)
                stop_containers
                ;;
            0)
                echo -e "${GREEN}👋 ¡Hasta luego!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opción inválida. Presiona Enter para continuar...${NC}"
                read
                ;;
        esac
    done
}

# Verificar si Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Error: Docker no está instalado${NC}"
    echo "Por favor, instala Docker Desktop desde: https://www.docker.com/products/docker-desktop"
    exit 1
fi

# Verificar si Docker está ejecutándose
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Error: Docker no está ejecutándose${NC}"
    echo "Por favor, inicia Docker Desktop"
    exit 1
fi

# Verificar si Docker Compose está instalado
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Error: Docker Compose no está instalado${NC}"
    exit 1
fi

# Ejecutar función principal
main
