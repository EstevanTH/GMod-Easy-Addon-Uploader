:: Place this file in your addon folder and run it.
:: The "addon.json" is generated automatically.
:: After uploading, the UID must be entered. It is stored in "workshop_id.cmd"
:: Do not remove the generated "workshop_id.cmd"!
:: If the GarrysMod path is incorrect then change it!
:: By Mohamed RACHID.

@echo off

:: Configuration:
set GarrysMod=C:\Program Files (x86)\Steam\steamapps\common\GarrysMod

:: Note: a '+' is prepended for replacements in variables to avoid empty variables, which do not handle replacements.

:: Find path from addon path if GarrysMod path is missing.
if not exist "%GarrysMod%\bin\gmad.exe" goto fixpath
if not exist "%GarrysMod%\bin\gmpublish.exe" goto fixpath
goto name
:fixpath
set GarrysMod=%CD%\..\..\..
if not exist "%GarrysMod%\bin\gmad.exe" goto nobin
if not exist "%GarrysMod%\bin\gmpublish.exe" goto nobin
goto name

:: Get the addon name:
:name
set i=0
:nameloop
echo set name=%%CD:~-%i%%%> Upload.temp.cmd
call Upload.temp.cmd
set /A i=i+1
:: loop until first found backslash
if not "%name:~0,1%"=="\" goto nameloop
del Upload.temp.cmd
set name=%name:~1%

:: Create addon.json if missing
:json
cls
if exist "addon.json" goto gma
echo.
set /P title=Please enter the title of the addon (no accents): 
set title=+%title%
set title=%title:"='%
set title=%title:~1%
echo.
echo List of allowed types:
echo - effects
echo - gamemode
echo - map
echo - model
echo - npc
echo - ServerContent
echo - tool
echo - vehicle
echo - weapon
set /P type=Please enter the type of the addon (case-sensitive): 
set type=+%type%
set type=%type:"=%
set type=%type:~1%
echo.
echo List of allowed tags:
echo - build
echo - cartoon
echo - comic
echo - fun
echo - movie
echo - realism
echo - roleplay
echo - scenic
echo - water
set /P tag1=Please enter the tag 1 of 2 of the addon (optional, case-sensitive): 
set tag1=+%tag1%
set tag1=%tag1:"=%
set tag1=%tag1:~1%
set tag2=
if "%tag1%"=="" goto jsontagprocess
set /P tag2=Please enter the tag 2 of 2 of the addon (optional, case-sensitive): 
set tag2=+%tag2%
set tag2=%tag2:"=%
set tag2=%tag2:~1%
:jsontagprocess
if "%tag1%"=="" goto jsontag0
if "%tag2%"=="" goto jsontag1
goto jsontag2
:jsontag0
set tags=
goto jsontagok
:jsontag1
set tags="%tag1%"
goto jsontagok
:jsontag2
set tags="%tag1%","%tag2%"
goto jsontagok
:jsontagok
echo {> addon.json
echo 	"title" :	"%title%",>> addon.json
echo 	"type"  :	"%type%",>> addon.json
echo 	"tags"  :	[%tags%],>> addon.json
echo 	"ignore":>> addon.json
echo 	[>> addon.json
echo 		"*.cmd",>> addon.json
echo 		"*.ini",>> addon.json
echo 		"*.lnk",>> addon.json
echo 		"*.url",>> addon.json
echo 		"%name%.jpg",>> addon.json
echo 		"%name%.png">> addon.json
echo 	]>> addon.json
echo }>> addon.json
cls
type addon.json
echo.
echo If you need to modify this generated addon.json, close this window now.
pause

:: Create GMA archive
:gma
set target=%GarrysMod%\%name%.gma
del "%target%"> NUL 2>&1
echo.
"%GarrysMod%\bin\gmad.exe" create -out "%target%" -folder "%CD%\\"
if not exist "%target%" goto nogma
echo.
echo If no problem happened, press any key to continue...
pause> NUL

:: Upload GMA
cls
set thumbnail=
if exist "%name%.jpg" set thumbnail=-icon "%CD%\%name%.jpg"
set WorkshopId=
call workshop_id.cmd> NUL 2>&1
if "%WorkshopId%"=="" goto new
goto update
:new
if not exist "%name%.jpg" goto noicon
"%GarrysMod%\bin\gmpublish.exe" create -addon "%target%" %thumbnail%
if errorlevel 1 goto uperror
echo.
set /P WorkshopId=Enter the displayed UID: 
echo set WorkshopId=%WorkshopId%> workshop_id.cmd
goto finished
:update
echo.
echo What have you changed? (single line)
set /P changes=
set changes=+%changes%
set changes=%changes:"='%
set changes=%changes:~1%
"%GarrysMod%\bin\gmpublish.exe" update -addon "%target%" %thumbnail% -id "%WorkshopId%" -changes "%changes%"
if errorlevel 1 goto uperror
goto finished
:finished
goto end

:: Error: Missing binaries!
:nobin
cls
echo.
echo gma.exe or gmpublish.exe could not be located.
echo Please edit this file and fix the path to Garry's Mod.
goto end

:: Error: GMA not created!
:nogma
echo.
echo The GMA file could not be created because of an error.
goto end

:: Error: Icon missing in new GMA!
:noicon
echo.
echo The thumbnail file is missing. It is required for new addons.
echo Please make a picture of 512x512 pixels.
echo Save it in the folder of the addon as JPEG and name it:
echo %name%.jpg
echo Choose quality 100 if you can.
goto end

:: Error: GMA not uploaded!
:uperror
echo.
echo The addon could not be uploaded.
goto end

:: End
:end
del "%target%"> NUL 2>&1
pause

