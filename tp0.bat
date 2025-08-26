@echo off
setlocal enabledelayedexpansion

:: Colores para Windows
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "PURPLE=[95m"
set "CYAN=[96m"
set "NC=[0m"

:: Verificar si Docker está instalado
docker --version >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ Error: Docker no está instalado%NC%
    echo Por favor, instala Docker Desktop desde: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

:: Verificar si Docker está ejecutándose
docker info >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ Error: Docker no está ejecutándose%NC%
    echo Por favor, inicia Docker Desktop
    pause
    exit /b 1
)

:: Verificar si Docker Compose está instalado
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ Error: Docker Compose no está instalado%NC%
    pause
    exit /b 1
)

:menu
cls
echo %CYAN%╔══════════════════════════════════════════════════════════════╗%NC%
echo %CYAN%║                    TP0 - Docker Setup                        ║%NC%
echo %CYAN%╚══════════════════════════════════════════════════════════════╝%NC%
echo.
echo %YELLOW%Selecciona una opción:%NC%
echo.
echo %GREEN%1)%NC% Iniciar containers
echo %GREEN%2)%NC% Acceder a server
echo %GREEN%3)%NC% Acceder a client
echo %GREEN%4)%NC% Detener containers
echo %RED%0)%NC% Salir
echo.
set /p choice=%PURPLE%Opción: %NC%

if "%choice%"=="1" goto start_containers
if "%choice%"=="2" goto access_server
if "%choice%"=="3" goto access_client
if "%choice%"=="4" goto stop_containers
if "%choice%"=="0" goto exit_program
goto invalid_option

:start_containers
echo %BLUE%🛠️  Iniciando containers...%NC%

:: Detener containers existentes
docker-compose -f docker-compose.dev.yml down >nul 2>&1

:: Iniciar containers
docker-compose -f docker-compose.dev.yml up -d
if errorlevel 1 (
    echo %RED%❌ Error iniciando containers%NC%
) else (
    echo %GREEN%✅ Containers iniciados correctamente%NC%
    echo.
    echo %YELLOW%Próximos pasos:%NC%
    echo   1. Selecciona opción 2 para acceder al servidor
    echo   2. Dentro del servidor: cd /workspace/server ^&^& make debug
    echo   3. Ejecuta: ./bin/server
    echo   4. Selecciona opción 3 para acceder al cliente (en otra terminal)
    echo   5. Dentro del cliente: cd /workspace/client ^&^& make debug
    echo   6. Ejecuta: ./bin/client
)
echo.
pause
goto menu

:access_server
echo %BLUE%🔧 Accediendo al servidor...%NC%
docker exec -it tp0-server-dev bash
goto menu

:access_client
echo %BLUE%🔧 Accediendo al cliente...%NC%
docker exec -it tp0-client-dev bash
goto menu

:stop_containers
echo %BLUE%⏹️  Deteniendo containers...%NC%

:: Detener containers
docker-compose -f docker-compose.dev.yml down

echo %GREEN%✅ Containers detenidos%NC%
echo.
pause
goto menu

:invalid_option
echo %RED%❌ Opción inválida. Presiona Enter para continuar...%NC%
pause
goto menu

:exit_program
echo %GREEN%👋 ¡Hasta luego!%NC%
exit /b 0
