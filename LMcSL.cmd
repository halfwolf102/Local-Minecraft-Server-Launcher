:Modules Compiled Fri 09/20/2019 14:18:44.59
@echo off
:=============INSTALLER MODULE=============
:MODULE UPDATED: 09/20/2019
:=====version info=====
set version=1
set revision=0
set minor=0
:=====PROGRAM INITIALIZATION=====
setlocal enabledelayedexpansion
chcp 65001
set repolink=https://github.com/halfwolf102/Local-Minecraft-Server-Launcher
if exist config.dat goto main
if exist "%programfiles%\LMcSL\config.dat" if /i "%cd%"=="%programfiles%\LMcSL" goto main
:=====INSTALL/UPDATE OPERATIONS=====
set startdir=%cd%
title LMcSL Installer
:==LMcSL LICENSE AND EULA==
cls
echo License Notice
echo:
echo Local Minecraft Server Launcher
echo Copyright (C) 2019  "Halfwolf102"
echo:
echo This program is free software: you can redistribute it and/or modify
echo it under the terms of the GNU Affero General Public License as published
echo by the Free Software Foundation, either version 3 of the License, or
echo (at your option) any later version.
echo: 
echo This program is distributed in the hope that it will be useful,
echo but WITHOUT ANY WARRANTY; without even the implied warranty of
echo MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo GNU Affero General Public License for more details.
echo:
echo You should have received a copy of the GNU Affero General Public License
echo along with this program.  If not, see ^<https://www.gnu.org/licenses/^>.
echo:
echo Additionally, this program also has a End User License Agreement, which
echo will be shown on the next screen. This agreement contains statements that
echo supersede any conflicing statements provided in the GNU AGPLV3 license.
echo:
echo DISCALIMER: This program is NOT in any way affiliated with or endorsed by
echo Mojang AB, Microsoft Corporation, or Microsoft Studios
echo:
choice /c c /n /m "Press C to continue"
cls
if not exist Docs\EULA goto MissingDocs
if not exist Docs\LICENSE goto MissingDocs
if not exist Docs\CONTRIBUTORS goto MissingDocs
type Docs\EULA
echo:
echo Press Y to indicate that you have read, understand, and agree to the terms and conditions above.
echo Press N if you do not agree to the terms above
choice /c yn
if not %errorlevel% equ 1 exit

:==Launcher installation path==
cls
if not exist "%programfiles%\LMcSL\config.dat" echo Please enter the path for the launcher installation or press enter to accept the default.
if not exist "%programfiles%\LMcSL\config.dat" set /p installpath=(Default Path: %programfiles%\LMcSL): 
if not defined installpath installpath=%programfiles%\LMcSL
if not exist "%installpath%\config.dat" goto cleaninstall
echo:
echo An existing installation has been detected or a configuration file already exists in the destination folder.
choice /c cu /m "Would you like to perform a clean installation and overwrite this file (C) or just update LMcSL (U)"
if /i not %errorlevel% equ 1 cls & echo Installing update... & goto update
echo Installation will be overwritten!
:==Server installation path==
:cleaninstall
echo:
echo Please enter the path to the server folder or press enter to accept the default.
echo NOTE: This program will manage individual folders here 
set /p serverpath=(Default Path: %installpath%\servers): 
if not defined serverpath set serverpath=%installpath%\Servers

:==Console color options==
:colorreset
cls
set textcolor=
set backcolor=
echo ╔══════════════════════════════════════════════════════════╗
echo ║                Console color settings                    ║
echo ╟──────────────────────────────────────────────────────────╢
echo ║ 0 = Black  4 = Red     8 = Grey         C = Light Red    ║
echo ║ 1 = Blue   5 = Purple  9 = Light Blue   D = Light Purple ║
echo ║ 2 = Green  6 = Yellow  A = Light Green  E = Light Yellow ║
echo ║ 3 = Aqua   7 = White   B = Light Aqua   F = Bright White ║
echo ╚══════════════════════════════════════════════════════════╝
set /p textcolor=Please select the color you would like the text to be (Default: 7): 
set /p backcolor=Please select the color you would like the background to be (Default 0): 
if not defined textcolor set textcolor=7
if not defined backcolor set backcolor=0
color %backcolor%%textcolor%
echo:
echo PREVIEW
choice /c yn /m "Would you like to keep this configuration"
if not %errorlevel% equ 1 color 07
if not %errorlevel% equ 1 goto colorreset
:==Installation==
cls
echo Installing...
if not exist "%installpath%" mkdir "%installpath%"
if not exist "%serverpath%" mkdir "%serverpath%"
cd /d "%installpath%"
:==config file generation==
echo :DO NOT EDIT MANUALLY>config.dat
echo set servpath=%serverpath%>>config.dat
echo set skipsplashscreen=false>>config.dat
echo set restartloop=true>>config.dat
echo color %backcolor%%textcolor%>>config.dat
echo set hidevanilla=false>>config.dat
echo set hidebukkit=false>>config.dat
echo set hidespigot=false>>config.dat
:update
xcopy /q /y "%startdir%\*" "%installpath%"  > nul
:xcopy /q /y "%startdir%\LMcSL.cmd" "%installpath%"  > nul
:xcopy /q /y "%startdir%\strlen.cmd" "%installpath%" > nul
choice /c of /m "Installation Complete! Open Launcher (O) or Finish (F)"
if %errorlevel% equ 1 cd /d %installpath% & start "" "LMcSL.cmd"
exit

:MissingDocs
cls
echo WARNING! This copy is missing crucial documents and, as such, is not compliant
echo with the GNU AGPLV3 License and/or this program's EULA.
echo:
echo Please re-download it from a reliable source, such as
echo https://github.com/halfwolf102/Local-Minecraft-Server-Launcher
echo:
echo THIS PROGRAM WILL HALT HERE!
pause
exit

:===========END MODULE CONTAINER===========
:================MAIN MODULE===============
:MODULE UPDATED: 09/20/2019
:main
title LMcSL v%version%.%revision%
for /f "tokens=*" %%a in ('type config.dat') do %%a
set mainpath=%cd%
:=====SPLASH SCREEN=====
cls
if '%skipsplashscreen%'=='true' goto reset
echo Local Minecraft Server Launcher
echo           `      `            
echo          /m      /h.          
echo         :MN      +Md          
echo         .::`     .::          
echo        /mMMm/  `sNMNy`        
echo       -NMMMMN- sMMMMMh        
echo     / yMMMMMM+ mMMMMMM-..     
echo    sM`dMMMMMMo NMMMMMM/oN.    
echo   `dh:+MMMMMN- sMMMMMN.ydo    
echo   `/s+.oNMMN/  `yMMMd-:oo-    
echo  -mMMMN- .-`     .-. oMMMNs`  
echo `mMMMMMs            `NMMMMMo  
echo /MMMMMMy    :ss/`   `MMMMMMm  
echo /MMMMMM+  `hMMMMN:   dMMMMMm` 
echo `hMMMMy   yMMMMMMN:  -mMMMN/  
echo   :os:  :hMMMMMMMMNo. .os+.   
echo      `omMMMMMMMMMMMMMh:       
echo     `mMMMMMMMMMMMMMMMMM+      
echo     :MMMMMMMMMMMMMMMMMMm      
echo     `mMMMMMMMMMMMMMMMMMs      
echo      .dMMMMNy+/sdMMMMNs`      
echo        .::.`     .:/:`
echo        By Halfwolf102
echo:
echo:
echo build %version%.%revision%.%minor%
echo Copyright (C) 2019 - Halfwolf102
ping localhost -n 5 >nul
:=====LAUNCHER OPTIONS=====
:reset
cd /d "%servpath%"
set /a option=0
set jarfile=
set choice=
set servchoice=
set varlen=0
for /f "tokens=*" %%a in ('type "%mainpath%\config.dat"') do %%a
cls
echo         Local MC Server Launcher
echo ╔══════════════════════════════════════╗
if /i '%hidevanilla%'=='true' goto hidev
echo ║              Vanilla                 ║
echo ╟──────────────────────────────────────╢
if not exist server* echo ║ NO SERVERS TO LIST                   ║
if exist server* for /f "tokens=*" %%a in ('dir /b /A:d server*') do (
	set /a option += 1
	set pick!option!=%%a
	call "%mainpath%\strlen" "%%a" varlen
	if !varlen! equ 10 echo ║ !option!^.^) %%a                       ║
	if !varlen! equ 11 echo ║ !option!^.^) %%a                      ║
	if !varlen! equ 12 echo ║ !option!^.^) %%a                     ║
	if !varlen! equ 13 echo ║ !option!^.^) %%a                    ║
	if !varlen! equ 14 echo ║ !option!^.^) %%a                   ║
	if !varlen! equ 15 echo ║ !option!^.^) %%a                  ║
)
echo ║                                      ║
echo ╠══════════════════════════════════════╣
:hidev
if /i '%hidebukkit%'=='true' goto hideb
echo ║               Bukkit                 ║
echo ╟──────────────────────────────────────╢
if not exist bukkit* echo ║ NO SERVERS TO LIST                   ║
if exist bukkit* for /f "tokens=*" %%a in ('dir /b /A:d bukkit*') do (
	set /a option += 1
	set pick!option!=%%a
	call "%mainpath%\strlen" "%%a" varlen
	if !varlen! equ 10 echo ║ !option!^.^) %%a                       ║
	if !varlen! equ 11 echo ║ !option!^.^) %%a                      ║
	if !varlen! equ 12 echo ║ !option!^.^) %%a                     ║
	if !varlen! equ 13 echo ║ !option!^.^) %%a                    ║
	if !varlen! equ 14 echo ║ !option!^.^) %%a                   ║
	if !varlen! equ 15 echo ║ !option!^.^) %%a                  ║
)
echo ║                                      ║
echo ╠══════════════════════════════════════╣
:hideb
if /i '%hidespigot%'=='true' goto hides
echo ║               Spigot                 ║
echo ╟──────────────────────────────────────╢
if not exist spigot* echo ║ NO SERVERS TO LIST                   ║
if exist spigot* for /f "tokens=*" %%a in ('dir /b /A:d spigot*') do (
	set /a option += 1
	set pick!option!=%%a
	call "%mainpath%\strlen" "%%a" varlen
	if !varlen! equ 10 echo ║ !option!^.^) %%a                       ║
	if !varlen! equ 11 echo ║ !option!^.^) %%a                      ║
	if !varlen! equ 12 echo ║ !option!^.^) %%a                     ║
	if !varlen! equ 13 echo ║ !option!^.^) %%a                    ║
	if !varlen! equ 14 echo ║ !option!^.^) %%a                   ║
	if !varlen! equ 15 echo ║ !option!^.^) %%a                  ║
)
echo ║                                      ║
echo ╠══════════════════════════════════════╣
:hides
echo ║ A.) Add New Server                   ║
echo ║ S.) Launcher Settings                ║
echo ║ L.) License info                     ║
echo ║ E.) Exit                             ║
echo ║                                      ║
if /i not '%restartloop%'=='true' echo ║ Restart on server close DISABLED     ║
if /i '%restartloop%'=='true' echo ║ Restart on server close ENABLED      ║
echo ║ (See launcher settings)              ║
echo ╚══════════════════════════════════════╝
set /p choice=Please select an option: 
:=options=
set /a option=0
if exist server* for /f "tokens=*" %%a in ('dir /b /A:d server*') do (
	set /a option += 1
	if !choice! equ !option! goto serveropts
)
if exist bukkit* for /f "tokens=*" %%a in ('dir /b /A:d bukkit*') do (
	set /a option += 1
	if !choice! equ !option! goto serveropts
)
if exist spigot* for /f "tokens=*" %%a in ('dir /b /A:d spigot*') do (
	set /a option += 1
	if !choice! equ !option! goto serveropts
)
:=sorting=
if /I '%choice%'=='A' goto serveradd
if /I '%choice%'=='S' goto launchset
if /I '%choice%'=='L' goto licensing
if /I '%choice%'=='E' exit
cls
echo Invalid option
pause
goto reset

:=====SERVER FILE RETRIEVAL=====
:serveradd
cls
echo Please enter path to source file(s) or press enter to accept the default.
set /p retfile=(Default Path: %userprofile%\Downloads): 
if not defined retfile set retfile=%userprofile%\Downloads

:==Server List==
cls
set retopt=0
set chooseret=
echo  Found server file list:
if exist "%retfile%\server*.jar" echo ╔══════════════════════════════════════╗
if exist "%retfile%\server*.jar" echo ║              Vanilla                 ║
if exist "%retfile%\server*.jar" echo ╚══════════════════════════════════════╝
if exist "%retfile%\server*.jar" for /f "tokens=*" %%a in ('dir /b "%retfile%\server*.jar"') do (
	set /a retopt += 1
	set pick!retopt!=%%a
	echo   !retopt!^.^) %%a
)
if exist "%retfile%\server*.jar" echo:
if exist "%retfile%\bukkit*.jar" echo ╔══════════════════════════════════════╗
if exist "%retfile%\bukkit*.jar" echo ║               Bukkit                 ║
if exist "%retfile%\bukkit*.jar" echo ╚══════════════════════════════════════╝
if exist "%retfile%\bukkit*.jar" for /f "tokens=*" %%a in ('dir /b "%retfile%\bukkit*.jar"') do (
	set /a retopt += 1
	set pick!retopt!=%%a
	echo   !retopt!^.^) %%a
)
if exist "%retfile%\bukkit*.jar" echo:
if exist "%retfile%\spigot*.jar" echo ╔══════════════════════════════════════╗
if exist "%retfile%\spigot*.jar" echo ║               Spigot                 ║
if exist "%retfile%\spigot*.jar" echo ╚══════════════════════════════════════╝
if exist "%retfile%\spigot*.jar" for /f "tokens=*" %%a in ('dir /b "%retfile%\spigot*.jar"') do (
	set /a retopt += 1
	set pick!retopt!=%%a
	echo   !retopt!^.^) %%a
)
if not exist "%retfile%\server*.jar" if not exist "%retfile%\bukkit*.jar" if not exist "%retfile%\spigot*.jar" echo NO SERVERS FOUND! & pause & goto reset
if exist "%retfile%\spigot*.jar" echo:
echo ════════════════════════════════════════
set /p chooseret=Select a file to import or enter B to return to the menu: 

set retopt=0
set folderpre=
if /i '%chooseret%'=='b' goto reset
for /f "tokens=*" %%a in ('dir /b "%retfile%\server*.jar"') do (
	set /a retopt += 1
	set folderpre=Server
	if !chooseret! equ !retopt! goto retfileops
)
for /f "tokens=*" %%a in ('dir /b "%retfile%\bukkit*.jar"') do (
	set /a retopt += 1
	set folderpre=Bukkit
	if !chooseret! equ !retopt! goto retfileops
)
for /f "tokens=*" %%a in ('dir /b "%retfile%\server*.jar"') do (
	set /a retopt += 1
	set folderpre=Spigot
	if !chooseret! equ !retopt! goto retfileops
)
echo Invalid Selection!
pause
goto serveradd
:==Import Operations==
:retfileops
set servversion=
cls
echo Import %folderpre% server
echo ════════════════════════════════════════
set /p servversion=Please enter server MC version (example: 1.14.2): 
echo Importing...
mkdir "%folderpre% %servversion%"
xcopy /q /y "%retfile%\!pick%retopt%!" "%servpath%\%folderpre% %servversion%\" > nul
echo Done!
choice /c yn /m "Would you like to import another file"
if %errorlevel% equ 1 goto serveradd
goto reset

:=====LAUCHER SETTINGS EDITOR=====
:launchset
cls
set setopt=0
set setchoice=
set boolvar=
set curset=
set com=
set var1=
set var2=
echo Current Settings
echo ════════════════════════════════════════
for /f "tokens=1-3 delims== " %%a in ('type "%mainpath%\config.dat"') do (
	if /i not '%%a'==':do' set /a setopt += 1
	if /i '%%a'=='set' if /i '%%b'=='servpath' echo !setopt!^.^) Server Path
	if /i '%%a'=='set' if /i not '%%b'=='servpath' echo !setopt!^.^) %%b %%c
	if /i '%%a'=='color' echo !setopt!^.^) %%a %%b (back \ text^)
)
echo:
echo ════════════════════════════════════════
set /p setchoice=Enter setting to change or enter B to return to the main menu: 
set setopt=0
if /i '%setchoice%'=='b' goto reset
for /f "tokens=1-3 delims== " %%a in ('type "%mainpath%\config.dat"') do (
	if /i not '%%a'==':do' set /a setopt += 1
	if !setchoice! equ !setopt! set com=%%a
	if !setchoice! equ !setopt! set var1=%%b
	if !setchoice! equ !setopt! set var2=%%c
)
:setsort
if /i '%com%'=='color' goto colorsets
if /i '%var1%'=='servpath' goto pathset
if /i '%com%'=='set' goto boolsets
cls
echo Invalid Choice!
pause
goto launchset
:pathset
cls
set exitloop=0
set newpath=
echo Edit Server Path
echo ════════════════════════════════════════
for /f "tokens=*" %%a in ('type "%mainpath%\config.dat"') do (
	if !exitloop! equ 1 echo %%a
	if !exitloop! equ 1goto pathdispend
	set /a exitloop+=1
)
:pathdispend
echo:
echo ════════════════════════════════════════
set /p newpath=Please enter the new path for your server files, or enter c to cancle: 
if /i "%newpath%"=="c" goto launchset
if exist "%newpath%" goto savesets
if not defined newpath echo Path cannot be blank! & pause & goto pathset
choice /c yn /m "ATTENTION! The path you entered does not exist. Would you like LMcSL to create it"
if not %errorlevel% equ 1 goto launchset
mkdir %newpath%
goto savesets
:boolsets
cls
set boolvar=%var1%
set curset=%var2%
echo Edit %boolvar%
echo ════════════════════════════════════════
if /i '%boolvar%'=='restartloop' echo This setting allows the server to automatically restart after closing/crashing.
if /i '%boolvar%'=='hidevanilla' echo This setting hides the Vanilla Server option from the main menu.
if /i '%boolvar%'=='hidebukkit' echo This setting hides the Bukkit Server option from the main menu.
if /i '%boolvar%'=='hidespigot' echo This setting hides the Spigot Server option from the main menu.
echo:
if /i '%curset%'=='true' echo Setting ENABLED
if /i not '%curset%'=='true' echo Setting DISABLED
echo:
echo ════════════════════════════════════════
choice /c ced /m "Enable or Disable setting, or press C to cancle"
if %errorlevel% equ 1 goto launchset
if %errorlevel% equ 2 set curset=true
if %errorlevel% equ 3 set curset=false
goto savesets
:colorsets
set curset=%var1%
set textcolor=
set backcolor=
cls
echo ╔══════════════════════════════════════════════════════════╗
echo ║                Console color settings                    ║
echo ╟──────────────────────────────────────────────────────────╢
echo ║ 0 = Black  4 = Red     8 = Grey         C = Light Red    ║
echo ║ 1 = Blue   5 = Purple  9 = Light Blue   D = Light Purple ║
echo ║ 2 = Green  6 = Yellow  A = Light Green  E = Light Yellow ║
echo ║ 3 = Aqua   7 = White   B = Light Aqua   F = Bright White ║
echo ║                                                          ║
echo ║ Current Text Color: %curset:~1,1%                                    ║
echo ║ Current Background Color: %curset:~0,1%                              ║
echo ╚══════════════════════════════════════════════════════════╝
echo Enter X to cancle
set /p textcolor=Please select the color you would like the text to be: 
if /i '%textcolor%'=='x' goto launchset
set /p backcolor=Please select the color you would like the background to be:
if /i '%backcolor%'=='x' goto launchset
color %backcolor%%textcolor%
echo:
echo PREVIEW
set /p colorsel=Would you like to keep this configuration (Y/N?): 
if /i not '%colorsel%'=='y' color %curset% & goto colorsets
set curset=%backcolor%%textcolor%

:savesets
cls
echo Saving settings...
type "%mainpath%\config.dat">"%mainpath%\config.old"
del /q "%mainpath%\config.dat"
echo :DO NOT EDIT MANUALLY>"%mainpath%\config.dat"
set setopt=0
for /f "tokens=1-2 delims==" %%a in ('type "%mainpath%\config.old"') do (
	if /i not "%%a"==":DO NOT EDIT MANUALLY" set /a setopt += 1
	if /i not "%%a"==":DO NOT EDIT MANUALLY" if not !setchoice! equ !setopt! echo set servpath=%%b>>"%mainpath%\config.dat"
	if /i not "%%a"==":DO NOT EDIT MANUALLY" if !setchoice! equ !setopt! echo set servpath=!newpath!>>"%mainpath%\config.dat"
	if !setopt! equ 1 goto endpathset
)
:endpathset
for /f "tokens=1-3 delims== " %%a in ('type "%mainpath%\config.old"') do (
	if /i not '%%b'=='servpath' if /i not "%%a"==":DO" set /a setopt += 1
	if not !setchoice! equ !setopt! if /i not "%%a"==":DO" if /i '%%a'=='set' if /i not '%%b'=='servpath' echo %%a %%b=%%c>>"%mainpath%\config.dat"
	if not !setchoice! equ !setopt! if /i not "%%a"==":DO" if /i '%%a'=='color' echo %%a %%b>>"%mainpath%\config.dat"
	if !setchoice! equ !setopt! if /i not "%%a"==":DO" if /i '%%a'=='set' if /i not '%%b'=='servpath' echo %%a %%b=%curset%>>"%mainpath%\config.dat"
	if !setchoice! equ !setopt! if /i not "%%a"==":DO" if /i '%%a'=='color' echo %%a %curset%>>"%mainpath%\config.dat"
)
del /q "%mainpath%\config.old"
echo Done!
choice /c ms /n /m "To edit another setting, select S, otherwise select M to return to the main menu [S,M]: "
if %errorlevel% equ 2 goto launchset
goto reset

:=====LICENSING INFO=====
:licensing
cls
echo This work is release under a GNU AGPLV3 license and a supplamental EULA.
choice /c egb /n /m "Enter G to see the full GNU AGPLV3 license, E to see the full EULA, or B to return to the main menu: "
if %errorlevel% equ 1 goto liceula
if %errorlevel% equ 2 goto licgagpl
if %errorlevel% equ 3 goto reset
:licgagpl
cls
type "%mainpath%\Docs\LICENSE"
echo:
pause
goto licensing
:liceula
cls
type "%mainpath%\Docs\EULA"
echo:
pause
goto licensing
:===========END MODULE CONTAINER===========
:===============SERVER MODULE==============
:MODULE UPDATED: 09/20/2019
:=====SERVER OPTIONS=====
:serveropts
cd "!pick%option%!"
for /f "tokens=*" %%a in ('dir /B *.jar') do (
	set jarfile=%%a
)
:optsreset
set servchoice=
chcp 65001
cls
echo ╔══════════════════════════════════════╗
call "%mainpath%\strlen" "!pick%option%!" varlen
if !varlen! equ 10 echo ║ !pick%option%!                           ║
if !varlen! equ 11 echo ║ !pick%option%!                          ║
if !varlen! equ 12 echo ║ !pick%option%!                         ║
if !varlen! equ 13 echo ║ !pick%option%!                        ║
if !varlen! equ 14 echo ║ !pick%option%!                       ║
if !varlen! equ 15 echo ║ !pick%option%!                      ║
echo ╟──────────────────────────────────────╢
echo ║ 1.) Start Server                     ║
echo ║ 2.) Start Server (Variable Memory)   ║
echo ║ 3.) View/edit Server Settings        ║
:echo ║ 4.) View/edit world list             ║
echo ║ B.) Back                             ║
echo ║ E.) Exit                             ║
echo ╚══════════════════════════════════════╝
set /p servchoice=Please select an option: 
if "%servchoice%"=="1" goto mjeula
if "%servchoice%"=="2" goto mjeula
if "%servchoice%"=="3" goto editor
:if "%servchoice%"=="4" goto worldsel
if /i "%servchoice%"=="B" goto reset2
if /i "%servchoice%"=="E" exit
cls
echo Invalid option
pause
goto optsreset
:reset2
cd ..
goto reset

:=====SETTINGS EDITOR=====
:editor
cls
echo ╔══════════════════════════════════════╗
echo ║   Server settings editor open^^!       ║
echo ║    please close to continue...       ║
echo ╚══════════════════════════════════════╝
start /WAIT notepad.exe server.properties
goto optsreset

:=====EXISTING WORLD INFO=====
:worldsel
cls
if not exist "worlds.txt" echo. >worlds.txt
echo -This will open the worlds list in your default text editor program.
echo -You must add and edit the worlds list if you choose to use it to keep track of your server(s).
echo -Each server will have it's own world list to make seeing where that world is easier.
echo -To edit it manually, goto %cd%\worlds.txt
pause
start worlds.txt
goto optsreset

:=====Mojang EULA=====
:mjeula
cls
if exist eula.txt goto skipeula
echo IMPORTANT! Please Read.
echo:
echo:
echo By agreeing to this dialog, you are indicating your agreement to Mojang AB's EULA, which can be found at
echo https://account.mojang.com/documents/minecraft_eula
echo:
echo Note that this is NOT an agreement with the developer of LMcSL and is required to operate Minecraft servers,
echo which are developed and maintained by Mojang AB and Microsft Studios
echo:
echo:
echo Press Y to indicate that you have read, understand, and agree to the terms and conditions above.
echo Press N if you do not agree to the terms above
echo Press V to view these terms and conditions (This will open in a web browser)
choice /c ynv
if %errorlevel% equ 1 goto mjeulaaccept
if %errorlevel% equ 2 goto reset
if exist "%programfiles%\Mozilla Firefox" start "" Firefox.exe https://account.mojang.com/documents/minecraft_eula || if exist "%ProgramFiles(x86)%\Mozilla Firefox" start "" Firefox.exe https://account.mojang.com/documents/minecraft_eula || if exist "%programfiles%\google\chrome" start "" Chrome.exe https://account.mojang.com/documents/minecraft_eula || if exist "%ProgramFiles(x86)%\google\chrome" start "" Chrome.exe https://account.mojang.com/documents/minecraft_eula || if exist "C:\Windows\SystemApps\Microsoft.MicrosoftEdge*" start "" microsoftedge.exe https://account.mojang.com/documents/minecraft_eula || if exist "%programfiles%\Internet Explorer" start "" iexplore.exe https://account.mojang.com/documents/minecraft_eula || if exist "%ProgramFiles(x86)%\Internet Explorer" start "" iexplore.exe https://account.mojang.com/documents/minecraft_eula
goto mjeula

:mjeulaaccept
tzutil /g > tmp.txt
set /p timezone=<tmp.txt
del /q tmp.txt
echo #By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).>eula.txt
echo #This eula file was generated by third-party server manager Local Minecraft Server Launcher (%repolink%) upon user agreement >>eula.txt
echo #Created %date%-%time% %timezone%>>eula.txt
echo eula=true>>eula.txt
:skipeula
chcp 437
if "%servchoice%"=="1" goto serverstart
if "%servchoice%"=="2" goto incram

:=====RUN SERVER=====
:==Default RAM==
:serverstart
cls
java -jar %jarfile% nogui

if /i '%restartloop%'=='true' goto serverloop
echo The server will now close...
ping localhost -n 2 >nul
goto optsreset

:serverloop
cls
echo The server has crashed/ closed, restarting...
choice /t 3 /c cn /d n /n /m "PRESS C TO CANCEL RESTART"
if not %errorlevel% EQU 1 goto serverstart
goto optsreset

:==Custom RAM==
:incram
rammin=
rammax=
cls
echo Examples: (512MB is entered as 512M, 1GB is entered as 1024M or 1G)
echo Defaults: Min=1G Max=1G
set /p rammin=Please enter the minimum amount of RAM to use: 
set /p rammax=Please enter the maximum amount of RAM to use: 
if not defined rammin set rammin=1G
if not defined rammax set rammax=1G

:incramrestart
cls
java -Xmx%rammax% -Xms%rammin% -jar %jarfile% nogui
if '%restartloop%'=='true' goto serverloop2
echo The server will now close...
ping localhost -n 2 >nul
goto optsreset

:serverloop2
cls
echo The server has crashed/ closed, restarting...
choice /t 3 /c cn /d n /n /m "PRESS C TO CANCEL RESTART"
if not %errorlevel% EQU 1 goto incramrestart
goto optsreset

:===========END MODULE CONTAINER===========
