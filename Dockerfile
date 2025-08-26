FROM ubuntu:22.04

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    gdb \
    make \
    git \
    wget \
    curl \
    libreadline-dev \
    libpthread-stubs0-dev \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /workspace

# Crear directorios necesarios
RUN mkdir -p /workspace/client/bin /workspace/client/obj \
    && mkdir -p /workspace/server/bin /workspace/server/obj

# Exponer puerto por defecto (se puede cambiar en docker-compose)
EXPOSE 8080

# Comando por defecto
CMD ["/bin/bash"]
