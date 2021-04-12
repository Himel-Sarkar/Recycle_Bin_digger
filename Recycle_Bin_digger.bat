@Echo Off 
COLOR ec
title Created by Himel Sarkar
net sess>nul 2>&1||(powershell saps '%0'-Verb RunAs&exit)



:rp3



echo ========================
echo # Dig into recycle bin # 
echo                                Created by Himel Sarkar (insta id: himelsarkar137)
echo                                github.com/Himel-Sarkar/
echo ========================
echo Select a task(any error press CTRL+c , y , Enter):
echo =============
echo -
echo 1) Option 1 (Dig more)
echo 2) Option 2 (Visual Digging)[have some limitation]
echo 3) Option 3 (Recover)
echo 4) Option 4 (File Forensic)
echo 5) Option 5 (Network IP Scanner)
echo 6) Option 6 (CPU info)
echo 7) Option 7 (Exit)
echo -
set /p op=Type option:
if "%op%"=="1" goto op11
if "%op%"=="2" goto op22
if "%op%"=="3" goto op33
if "%op%"=="4" goto fi
if "%op%"=="5" goto ipp
if "%op%"=="6" goto cpu
if "%op%"=="7" goto op55
echo Please Pick an option:
goto beginnn


:op11
cd\
cd $Recycle.Bin
dir
echo dig more into it
dir /a /s /w /b
pause
cls
echo you picked option 1
goto rp3

:op22

cd\
cd $Recycle.Bin
dir
set /p op=Type your "full path" of the folder (from Option 1):
echo Wait for (1-120) seconds 
attrib -h -r -s /s /d
cd *%op%*
tree /F /A
pause
cls
echo you picked option 2
goto rp3

:op33
cls

echo Select a task:
echo =============
echo -
echo 1) Option 1 (Would you like to do default recovery)
echo 2) Option 2 (Custom location recovery )[Recommended]
echo 3) Option 3 (Visualize your destination/Recovered folder)
echo 3) Option 4 (Exit)
set /p op=Type your recovery option:
if "%op%"=="1" goto opppp1
if "%op%"=="2" goto opppp2
if "%op%"=="3" goto opppp3
if "%op%"=="4" goto opppp4



:opppp1
cd\
cd %appdata%
cd..
cd..
cd Desktop
mkdir "Himel Sarkar"
cd "Himel Sarkar"
xcopy "C:\$Recycle.Bin\*.*" /o /x /e /h /k


pause
cls
echo you picked option 2
goto rp3

:opppp2
set /p op=Type your source location:
cd\
cd %appdata%
cd..
cd..
cd Desktop
mkdir "Himel Sarkar"
cd "Himel Sarkar"

xcopy "*%op%*" /o /x /e /h /k


pause
cls
echo you picked option 2
goto rp3

:opppp3
cd\
cd $Recycle.Bin
dir
echo visualize your destination folder
cd\
cd %appdata%
cd..
cd..
cd Desktop
mkdir "Himel Sarkar"
cd "Himel Sarkar"
attrib -h -r -s /s /d 
tree /F /A



pause
cls
echo you picked option 3
goto rp3

:opppp4
cls
echo you picked option 4
goto op44


:fi
title File Forensic

if [%1] == [] goto fileIn
set "fileAddress=%1"
set "fileAddress=%fileAddress:~1,-1%"
goto fileCheck

:fileIn
cls
echo Input the file address:
echo.
set /p "fileAddress="
echo.
echo Checking...
if exist "%fileAddress%" goto fileCheck
echo.
echo File does not exist
pause
goto fileIn

:fileCheck
cls
echo File Informations
echo.
for %%f in ("%fileAddress%") do (
    echo Drive Letter   : %%~df
    echo Attributes     : %%~af
    echo Last Modified  : %%~tf
    echo Size           : %%~zf
    echo.
    echo Name       :
    echo %%~nf
    echo.
    echo Extension  : 
    echo %%~xf
    echo.
    echo Path       :
    echo %%~pf
    echo.
    echo Full Path  :
    echo %%~ff
    echo.
)
echo.
pause
goto fileIn
goto fi






@goto main

:ipp
rem Network IP Scanner
rem Updated on 2016-11-22


:main
@echo off
prompt $s
cd /d "%~dp0"
setlocal EnableDelayedExpansion EnableExtensions

set "pingTimeout=750"
set "fileAddress=!appdata!\IP_List.bat"

set parameter=%1
if not defined parameter goto detectConnections
if /i "!parameter!" == "QuickScan" goto quickScan_test


:detectConnections
title IP Scanner
cls
echo Detecting network connection...
set "selectedIPv4="
set "adapterConnected=0"
for /f "tokens=* usebackq" %%o in (`ipconfig /all`) do (
    set "output=%%o"
    if "!output:~0,12!" == "IPv4 Address" (
        set "selectedIPv4=!output:~36,62!"
        goto scriptSetup
    )
)
echo No connected adapters detected, cannot scan IP...
pause
exit


:scriptSetup
set "userInput=?"
for /f "tokens=1-3 delims=." %%a in ("!selectedIPv4!") do set "selectedIPv4=%%a.%%b.%%c"
set /a "timeSecMax=!pingTimeout!*256/1000"
set "aliveIP_Num=0"

:mainMenu
cls
echo Selected IP    : %selectedIPv4%.*
echo.
echo 1. Scan for Alive-IPs
echo 2. Quick Scan
echo 3. List IPs according to ping
echo 4. Change selected IP
echo 5. View your IP
echo.
echo T. Change ping timeout [%pingTimeout%ms]
echo 0. Exit
echo.
echo Input your choice:
set /p "userInput="
if "!userInput!" == "0" exit
if "!userInput!" == "1" goto normalScan
if "!userInput!" == "2" goto quickScan
if "!userInput!" == "3" goto sortPing
if "!userInput!" == "4" goto inputIP
if "!userInput!" == "5" goto viewIP
if /i "!userInput!" == "T" goto inputTimeout
goto mainMenu


:viewIP
cls
set "adapterNum=0"
for /f "tokens=* usebackq" %%o in (`ipconfig /all`) do (
    set "output=%%o"
    if "!output:~-1,1!" == ":" (
        set "connectionName=!output:~0,-1!"
        set "adapterConnected=Y"
    )
    if "!output:~36,18!" == "Media disconnected" set "adapterConnected=N"
    if "!output:~0,11!,!adapterConnected!" == "Description,Y" (
        set /a "adapterNum+=1"
        echo !adapterNum:~-2,2!. !output:~36,75!
        echo   =^> !connectionName:~0,74!
    )
    if "!output:~0,12!" == "IPv4 Address" (
        echo   IP: !output:~36,62!
        echo.
    )
)
echo.
pause
goto mainMenu


:inputTimeout
cls
echo Current ping timeout   : !pingTimeout!ms
echo.
echo Input new ping timeout in millisecond :
set /p "pingTimeout="
set /a "pingTimeout+=0"
set /a "timeSecMax=!pingTimeout!*256/1000"
if !pingTimeout! GEQ 500 if !pingTimeout! LEQ 10000 goto mainMenu
echo.
echo Invalid number
echo Ping timeout should be from 500 - 10000 ms
pause
goto inputTimeout


:inputIP
set "userInput=!selectedIPv4!.z"
cls
echo Selected IP    : !selectedIPv4!.*
echo.
echo Input selected IP:
set /p "userInput="
set "validIP=Y"
for /f "tokens=1-5 delims=." %%a in ("!userInput!") do (
    set "userInput=%%a.%%b.%%c"
    for %%n in ( %%a1 %%b1 %%c1) do (
        if %%n LSS 1   set "validIP=N"
        if %%n GTR 2551 set "validIP=N"
    )
    if not "%%e" == "" set "validIP=N"
)
if "!validIP!" == "Y" (
    set "selectedIPv4=!userInput!"
    goto mainMenu
)
echo.
echo Invalid IPv4 address
pause
goto inputIP


:quickScan
echo.
set "cpuLoad=0"
for /f "skip=1" %%o in ('wmic cpu get loadpercentage') do set /a "cpuLoad+=%%o + 0"
if !cpuLoad! GTR 20 (
    echo.
    echo CPU load is too much to do quick scan 
    echo Load !cpuLoad!%%   ^| Required load ^< 20%%
    pause
    goto mainMenu
)
set "freeMem=0"
for /f "skip=1" %%o in ('wmic os get freephysicalmemory') do set /a "freeMem+=%%o + 0"
set /a "freeMem/=1024"
if !freeMem! LSS 800 (
    echo.
    echo Not enough memory to do quick scan 
    echo Free memory !freeMem!MB   ^| Required memory ^> 800MB
    pause
    goto mainMenu
)

title IP Scanner - Preparing...
cls
echo You must be connected to the network to scan
echo Your computer might freeze for a while during scan
echo.
echo Scanning IPs...

set "startTime=!time!"
echo. > "!fileAddress!"
for /l %%n in (0,1,255) do set "statusIP%%n="
set "statusIP=dead"
set "tempVar1=1"
for /l %%n in (0,1,255) do start "" /b /min /low "%~f0" QuickScan %%n

:readFile
timeout /t 1 /nobreak > nul
call "%fileAddress%"
set "pingTested=0"
for /l %%n in (0,1,255) do if defined statusIP%%n set /a "pingTested+=1"
title IP Scanner - Scanning... [!pingTested!/256]
if not "!pingTested!" == "256" goto readFile
del /f /q "!fileAddress!"

title IP Scanner
set "aliveIP_List="
set "aliveIP_Num=0"
set "deadIP_List="
set "deadIP_Num=0"
for /l %%n in (0,1,255) do (
    set "tempVar1=    %%n"
    for %%s in (!statusIP%%n!) do (
        set "%%sIP_List=!%%sIP_List!!tempVar1:~-4,4!"
        set /a %%sIP_Num+=1
    )
    set "statusIP%%n="
)
goto viewAliveIP


:quickScan_test
(
    title IP Scanner - Testing !selectedIPv4!.%2
    for /f "tokens=* usebackq" %%s in (`ping -n 1 -w !pingTimeout! !selectedIPv4!.%2`) do (
        if "!tempVar1!" == "6" set "statusIP=alive"
        set /a "tempVar1+=1"
    )
    for /l %%n in (0,0,1) do (
        2>nul (
          echo set "statusIP%2=!statusIP!" >> "!fileAddress!"
        ) && exit
    )
)
exit


:normalScan
cls
echo You must be connected to the network to scan
echo This may take up to %timeSecMax% seconds to complete
echo.
echo Scanning IPs...

set "startTime=%time%"
set "aliveIP_List="
set "aliveIP_Num=0"
set "deadIP_List="
set "deadIP_Num=0"
for /l %%n in (0,1,255) do (
    title IP Scanner - Testing %selectedIPv4%.%%n
    set "statusIP=dead"
    set "tempVar1=1"
    for /f "tokens=* usebackq" %%s in (`ping -n 1 -w %pingTimeout% %selectedIPv4%.%%n`) do (
        if "!tempVar1!" == "6" set "statusIP=alive"
        set /a tempVar1+=1
    )
    set "tempVar1=    %%n"
    for %%s in (!statusIP!) do (
        set "%%sIP_List=!%%sIP_List!!tempVar1:~-4,4!"
        set /a %%sIP_Num+=1
    )
)

:viewAliveIP
call :difftime !time! !startTime!
call :ftime !return!

set /a "aliveIP_Percentage= !aliveIP_Num! * 100 / 255"
set /a "deadIP_Percentage= !deadIP_Num! * 100 / 255"

cls
title IP Scanner
echo Selected IP    : !selectedIPv4!.*
echo.
echo Alive-IPs [!aliveIP_Num!] - !aliveIP_Percentage!%%
echo.!aliveIP_List!
echo ================================================================================
echo Dead-IPs  [!deadIP_Num!] - !deadIP_Percentage!%%
echo.!deadIP_List!
echo.
echo Scan Done in !return!
pause > nul
goto mainMenu


:sortPing
if "!aliveIP_Num!" == "0" (
    echo Nothing to be listed: No alive-IPs found
    echo Please try to scan IPs
    pause
    goto mainMenu
)
cls
echo Selected IP    : !selectedIPv4!.*
echo.
echo Scanning IPs...
for %%n in (!aliveIP_List!) do (
    set "tempVar1=1"
    set "IP%%n_Ping=dead"
    for /f "tokens=* usebackq" %%o in (`ping -n 1 -w !pingTimeout! !selectedIPv4!.%%n`) do (
        if "!tempVar1!" == "6" for /f "tokens=4 delims==" %%a in ("%%o") do (
            set "IP%%n_Ping=%%a"
            set "IP%%n_Ping=!IP%%n_Ping:ms=!"
            set "IP%%n_Ping=!IP%%n_Ping: =!"
        )
        set /a tempVar1+=1
    )
)
echo Sorting pings...
set "tempVar1=1"
for %%n in (!aliveIP_List!) do (
    set "pingIP!tempVar1!=%%n"
    set /a tempVar1+=1
)
rem Selection Sort
for /l %%s in (1,1,!aliveIP_Num!) do (
    set "bestPing=z"
    set "bestPingNum=?"
    for /l %%l in (%%s,1,%aliveIP_Num%) do for %%n in (!pingIP%%l!) do (
        if !IP%%n_Ping! LSS !bestPing! (
            set "bestPing=!IP%%n_Ping!"
            set "bestPingNum=%%l"
        )
    )
    for %%l in (!bestPingNum!) do (
        set "tempVar1=!pingIP%%s!"
        set "pingIP%%s=!pingIP%%l!"
        set "pingIP%%l=!tempVar1!"
    )
)

cls
echo Selected IP    : %selectedIPv4%.*
echo.
echo   #     IP Address     Ping (ms)
echo ================================
for /l %%s in (1,1,!aliveIP_Num!) do (
    for %%n in (!pingIP%%s!) do (
        set "display=      !IP%%n_Ping!"
        set "tempVar1=!selectedIPv4!.%%n            "
        set "display=   !tempVar1:~0,15!!display:~-8,8!"
        set "display=  %%s!display:~-26,26!"
        echo !display:~-29,29!
    )
)
echo.
pause
goto mainMenu

rem Functions

:difftime [end_time] [start_time] [/n]
set "return=0"
for %%t in (%1:00:00:00:00 %2:00:00:00:00) do (
    for /f "tokens=1-4 delims=:." %%a in ("%%t") do (
        set /a "return+=24%%a %% 24 *360000 +1%%b*6000 +1%%c*100 +1%%d -610100"
    )
    set /a "return*=-1"
)
if /i not "%3" == "/n" if !return! LSS 0 set /a "return+=8640000"
goto :EOF

:ftime [time_in_centisecond]
set /a "tempVar1=%~1 %% 8640000"
set "return="
for %%n in (360000 6000 100 1) do (
    set /a "tempVar2=!tempVar1! / %%n"
    set /a "tempVar1=!tempVar1! %% %%n"
    set "tempVar2=?0!tempVar2!"
    set "return=!return!!tempVar2:~-2,2!:"
)
set "return=!return:~0,-4!.!return:~-3,2!"
goto :EOF





:cpu

title Get CPU Information
set lfn=CPU Info.txt
@echo ------------------------------------------------------------------------>>"%lfn%"
@echo Start: %date% %time%>>"%lfn%"
@echo User: %username%>>"%lfn%"
systeminfo>>"%lfn%"
vol>>"%lfn%"
@echo.>>"%lfn%"
@echo Tasklist:>>"%lfn%"
tasklist>>"%lfn%"
@echo.>>"%lfn%"







:op55
cls
echo you picked option 1
goto rp3
exit




