@echo off
setlocal enabledelayedexpansion
REM Creamos el apartado menu principal y 3 opciones para seleccionar
:menu_principal
cls
echo Menu Principal
echo 1. Registrarse
echo 2. Iniciar Sesion
echo 3. Salir
REM usamos variable %opcion% para dar valores a los numeros anteriores
set /p opcion="Seleccione una opcion: "
if "%opcion%"=="1" goto registrar_usuario
if "%opcion%"=="2" goto iniciar_sesion
if "%opcion%"=="3" exit /b
REM creamos el apartado registar usuario y set p para que el usuario escriba
:registrar_usuario
cls
echo Registro de Usuario
set /p username="Crea un nombre de usuario: "
set /p password="Introduce una contrasena: "
set /p rep_password="Repita la contrasena: "
REM usamos if y neq para decir que si las contraseñas no coinciden lo intente de nuevo llevandolo con goto a registrar usuario
if "%password%" neq "%rep_password%" (
    echo Las contrasenas no coinciden. Intentalo de nuevo.
    pause
    goto registrar_usuario
)
REM ligamos el usuario con la variable que introduce el usuario y tambien el nombre de usuario con la variable de la contraseña y con goto volvemos al principio
set "usuarios=!usuarios!;%username%"
set "contrasenas[!username!]=%password%"
echo Usuario registrado con exito.
pause
goto menu_principal
REM creamos apartado iniciar sesion y con set p pedimos que ingrese nombre y contraseña
:iniciar_sesion
cls
echo Inicio de Sesion
set /p username="Ingrese su nombre de usuario: "
set /p password="Ingrese su contrasena: "
REM si el nombre no esta guardado en la variable usuarios no lo reconocerá y le diremos que no se ha encontrado con un echo y volveremos al menu principal
if "!usuarios:%username%=!"=="%usuarios%" (
    echo Nombre de usuario no encontrado.
    pause
    goto menu_principal
)
REM con if == comprobamos que el usuario y la contraseña sean las guardadas de ser asi le damos a bienvenida sino le saldrá contraseña incorrecta, con call lo dirigimos a la siguiente pestaña y cerramos sesion de usuario con exit y volveremos al principio
if "!contrasenas[%username%]!"=="%password%" (
    echo ¡Bienvenido, %username%! 
	call :opciones_despues_inicio_sesion
) else (
    echo Contrasena incorrecta.
    pause
    goto menu_principal
)
exit /b
REM creamos apartado de despues de inicio ponemos 3 opciones
:opciones_despues_inicio_sesion
cls
echo Opciones despues de Iniciar Sesion
echo 1. Modificar contrasena
echo 2. Eliminar usuario
echo 3. Cerrar sesion
REM set p para que el usuario selecione la opcion que quiere
set /p opcion="Seleccione una opcion: "
REM introducimos 3 opciones con sus goto respectivos
if "%opcion%"=="1" goto modificar_contrasena
if "%opcion%"=="2" goto eliminar_usuario
if "%opcion%"=="3" goto menu_principal
REM creamos modificar contraseña y hacemos la contraseña de la variable usuario se remplace por la nueva contraseña que cree con la variable nueva contraseña le aparecera un mensaje de contraseña creada correctamente y con goto volvera a la ventana anterior
:modificar_contrasena
cls
set /p new_password="Ingrese la nueva contrasena: "
set "contrasenas[%username%]=%new_password%"
echo Contrasena modificada exitosamente.
pause
goto opciones_despues_inicio_sesion
REM creamos elimiar usuario 
:eliminar_usuario
cls
REM al presionar esta opcion con : hacemos que el usuario creado se borre de los usuarios guardados y le pondremos un mensaje de usuario eliminado y con goto le mandamos a menu principal
set "usuarios=!usuarios:%username%=!"
set "contrasenas[%username%]="
echo Usuario eliminado exitosamente.
pause
goto menu_principal
pause