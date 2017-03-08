    @echo off
    cls

    :checkPrivileges 
    NET FILE 1>NUL 2>NUL
    if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges ) 

    :getPrivileges 
    if '%1'=='ELEV' (shift & goto gotPrivileges)  

    setlocal DisableDelayedExpansion
    set "batchPath=%~0"
    setlocal EnableDelayedExpansion
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs" 
    echo UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs" 
    "%temp%\OEgetPrivileges.vbs" 
    exit /B

    :gotPrivileges 
    setlocal & pushd .

	REM correr el shell como admin (ejemplo) - luego define el codigo como lo desea
    echo.
    echo ============================
    echo Configurando Red Adhoc ...
    echo ============================
    netsh wlan set hostednetwork mode=allow ssid=WiFiSSID key=WiFiPassword
    netsh wlan start hostednetwork
    pause
    exit
    cls       

    cmd /k