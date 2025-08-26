# Sistemas Operativos - TP0

## ¿De qué trata?

El TP0 es una práctica inicial para empezar a familiarizarse con algunas de las herramientas necesarias para el trabajo práctico cuatrimestral de la materia Sistemas Operativos.

Es un ejercicio corto y sirve como base para empezar el TP cuatrimestral.

## 📚 Documentación Oficial

**IMPORTANTE**: Este repositorio contiene la documentación oficial del TP0 en:
**[https://docs.utnso.com.ar/primeros-pasos/tp0](https://docs.utnso.com.ar/primeros-pasos/tp0)**

**Repositorio oficial original**: **[https://github.com/sisoputnfrba/tp0](https://github.com/sisoputnfrba/tp0)**

Sigue la guía oficial para completar el TP0. Este repositorio solo agrega configuración de Docker.

## 🐳 Configuración Docker (Opcional)

Este repositorio incluye una configuración de Docker que permite desarrollar, compilar y ejecutar el TP0 sin necesidad de máquinas virtuales.

### 🚀 Uso Rápido

#### En macOS/Linux:
```bash
./tp0.sh
```

#### En Windows:
```cmd
tp0.bat
```

### 📋 Opciones Disponibles

1. **Iniciar containers** - Levanta el entorno de desarrollo
2. **Acceder a server** - Entra al container del servidor (equivalente a SSH a la VM del servidor)
3. **Acceder a client** - Entra al container del cliente (equivalente a SSH a la VM del cliente)
4. **Detener containers** - Para los containers
0. **Salir** - Cierra el script

### 🔧 Archivos de Configuración Docker

#### `Dockerfile`
Define la imagen base con todas las dependencias necesarias para compilar y ejecutar el TP0:
- Ubuntu 22.04 como sistema base
- Compilador GCC y herramientas de desarrollo
- Librerías necesarias (readline, pthread, etc.)
- Debugger GDB y Valgrind para análisis de memoria

#### `docker-compose.dev.yml`
Orquesta los containers de desarrollo:
- **server-dev**: Container para el servidor con puerto 8080 expuesto
- **client-dev**: Container para el cliente que depende del servidor
- **Volúmenes**: Monta el código fuente para desarrollo en tiempo real
- **Red**: Crea una red interna para comunicación entre containers

### 🎯 Equivalencia con la Propuesta Original

En la [guía oficial](https://docs.utnso.com.ar/primeros-pasos/tp0), se menciona el uso de máquinas virtuales Ubuntu Server y conexión por SSH:

> "Para solucionar esto, nos vamos a conectar a la VM por SSH. Para ello, ni bien iniciemos sesión veremos la IP que se le asignó a la VM"

Las opciones 2 y 3 de nuestros scripts (`Acceder a server` y `Acceder a client`) son equivalentes a conectarse por SSH a las máquinas virtuales del servidor y cliente respectivamente. Dentro de los containers, los alumnos tendrán la misma experiencia que en las VMs originales.

### 🔄 Diferencias con la Propuesta Original

**Desarrollo local vs remoto:**
- **Propuesta original**: Los alumnos clonan el repo dentro de las VMs y usan VS Code desde otra virtual con entorno gráfico
- **Configuración Docker**: Los alumnos clonan el repo en sus máquinas locales, usan VS Code localmente, y los containers tienen mapeadas las carpetas `client` y `server` como volúmenes

## Consigna

Podés encontrar la consigna en el siguiente [link].

[link]: https://faq.utnso.com.ar/tp0-enunciado


