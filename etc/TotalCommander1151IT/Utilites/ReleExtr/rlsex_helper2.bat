@echo off
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM **************** !! ADJUST YOUR DESTiNATiON-FOLDERS !! ****************
REM ********************* (WiTHOUT TAiLiNG BACKSLASH) *********************
REM ***********************************************************************
SET DIR_TV="D:\0_day\TV"
SET DIR_XXX="D:\0_day\XXX"
SET DIR_ISO="D:\0_day\ISO"
SET DIR_MP3="D:\0_day\MP3"
SET DIR_FIX="D:\0_day\FIXES"
SET DIR_MISC="D:\0_day\MISC"
SET DIR_XVID="D:\0_day\XVID"
SET DIR_DVDR="D:\0_day\DVDR"
SET DIR_0DAY="D:\0_day\0DAY"
SET DIR_DOKU="D:\0_day\DOKU"
SET DIR_MVID="D:\0_day\MVID"
SET DIR_EBOOK="D:\0_day\EBOOK"
SET DIR_HDDVD="D:\0_day\HDDVD"
SET DIR_IMAGE="D:\0_day\IMAGE"
SET DIR_MDVDR="D:\0_day\MDVDR"
SET DIR_CONSOLE="D:\0_day\CONSOLE"
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM ***************** DO YOU USE FTPRush FOR DOWNLOADiNG? *****************
REM ********** IF NOT, THE iNCOMPLETE-STATUS WiLL NOT BE CHECKED **********
REM *************************(SET RUSH TO 0 OR 1)**************************
REM ***********************************************************************
SET RUSH=0
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM ******** LANGUAGE-DEPENDENT iNCOMPLETE-ANNOUNCE FROM FTPRush **********
REM ********************* (Germans: dont use the Ä) ***********************
REM ***********************************************************************
SET INCOMPLETE=[UNVOLLST
REM SET INCOMPLETE=[INCOMPLETE
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM ********** AUTO-WiPE OF COMRESSED FiLES WHEN NO ERROR APPEARS *********
REM ************ (SET TO 0 OR 1) *** !! USE AT YOUR OWN RiSK !! ***********
REM ***********************************************************************
SET DELETE=0
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM ***********************************************************************
REM ********************** < END OF CONFiGURATiON > ***********************



IF "%1"=="" GOTO HELP
IF "%1"=="/?" GOTO HELP
IF "%1"=="-?" GOTO HELP
IF "%1"=="-h" GOTO HELP
IF "%1"=="-help" GOTO HELP
IF "%1"=="--help" GOTO HELP
SET RLSNAME=%1
SET DIR_DL=%2

echo %RLSNAME%

if %RUSH% == 0 goto NOCHECK
 dir /AD /B /S %DIR_DL%%RLSNAME% | grep -q \%INCOMPLETE%
 if %errorlevel% == 0 goto INCOMPLETE
:NOCHECK

if exist %DIR_DL%%RLSNAME%\*.mp3 GOTO MP3

if exist %DIR_DL%%RLSNAME%\*.avi GOTO MVID

echo %RLSNAME% | grep -i -q -E "[\._]DIRFIX|[\._]DIR[\._]FIX|[\._]NFOFIX|[\._]NFO[\._]FIX"
if %errorlevel% == 0 goto FIX

echo %RLSNAME% | grep -i -q -E "[\._]EBOOK"
if %errorlevel% == 0 goto EBOOK

echo %RLSNAME% | grep -i -q -E "[\._]DOKU|[\._]DOCU|[\._]MAGAZIN|^Neues\.200"
if %errorlevel% == 0 goto DOKU

echo %RLSNAME% | grep -i -q -E "[\._]XBOX|[\._]PS[2-3P]|[\._]WII"
if %errorlevel% == 0 goto CONSOLE

echo %RLSNAME% | grep -i -q -E "[\._0-9]E[0-9]{2,4}[\._]|[\._]S[0-9]{2,4}[\._]"
if %errorlevel% == 0 goto TV

echo %RLSNAME% | grep -i -q -E "[\._]BLURAY|[\._]HDDVD|[\._][hx]264"
if %errorlevel% == 0 goto HDDVD

echo %RLSNAME% | grep -i -q -E "[\._]IMAGESET"
if %errorlevel% == 0 goto IMAGE

if exist %DIR_DL%%RLSNAME%\*.zip GOTO 0DAY

echo %RLSNAME% | grep -i -q -E "[\._]XXX|\-PORNOLATiON|\-SWE6RUS"
if %errorlevel% == 0 goto XXX

echo %RLSNAME% | grep -i -q -E "[\._]XVID"
if %errorlevel% == 0 goto XVID

echo %RLSNAME% | grep -i -q -E "[\._]DVDR"
if %errorlevel% == 0 goto DVDR

echo %RLSNAME% | grep -i -q -E "[\._]MDVDR"
if %errorlevel% == 0 goto MDVDR

rar lb -r %DIR_DL%%RLSNAME%\*.rar > files.dat
rar lb -r %DIR_DL%%RLSNAME%\*.001 >> files.dat
grep -i -q -E "\.iso|\.bin|\.cue|\.img|\.mdf|\.mds|\.nrg" files.dat
if %errorlevel% == 0 goto ISO

if exist %DIR_DL%%RLSNAME%\*.rar GOTO MISC

echo Unable to recognize release format!
echo.
GOTO END



:XVID
if exist %DIR_XVID%\%RLSNAME% GOTO EXISTS
echo Extracting to XviD...
echo.
md %DIR_XVID%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_XVID%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_XVID%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XVID%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_XVID%\%RLSNAME%\*.rar %DIR_XVID%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XVID%\%RLSNAME%\*.zip unzip -o -qqq %DIR_XVID%\%RLSNAME%\*.zip -d %DIR_XVID%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XVID%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_XVID%\%RLSNAME%\*.rar %DIR_XVID%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XVID%\%RLSNAME%\*.rar del %DIR_XVID%\%RLSNAME%\*.rar > NUL
if exist %DIR_XVID%\%RLSNAME%\*.zip del %DIR_XVID%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:TV
if exist %DIR_TV%\%RLSNAME% GOTO EXISTS
echo Extracting to TV...
echo.
md %DIR_TV%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_TV%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_TV%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_TV%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_TV%\%RLSNAME%\*.rar %DIR_TV%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_TV%\%RLSNAME%\*.zip unzip -o -qqq %DIR_TV%\%RLSNAME%\*.zip -d %DIR_TV%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_TV%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_TV%\%RLSNAME%\*.rar %DIR_TV%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_TV%\%RLSNAME%\*.rar del %DIR_TV%\%RLSNAME%\*.rar > NUL
if exist %DIR_TV%\%RLSNAME%\*.zip del %DIR_TV%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:DOKU
if exist %DIR_DOKU%\%RLSNAME% GOTO EXISTS
echo Extracting to DOKU...
echo.
md %DIR_DOKU%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_DOKU%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_DOKU%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DOKU%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_DOKU%\%RLSNAME%\*.rar %DIR_DOKU%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DOKU%\%RLSNAME%\*.zip unzip -o -qqq %DIR_DOKU%\%RLSNAME%\*.zip -d %DIR_DOKU%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DOKU%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_DOKU%\%RLSNAME%\*.rar %DIR_DOKU%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DOKU%\%RLSNAME%\*.rar del %DIR_DOKU%\%RLSNAME%\*.rar > NUL
if exist %DIR_DOKU%\%RLSNAME%\*.zip del %DIR_DOKU%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:XXX
if exist %DIR_XXX%\%RLSNAME% GOTO EXISTS
echo Extracting to XXX...
echo.
md %DIR_XXX%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_XXX%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_XXX%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XXX%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_XXX%\%RLSNAME%\*.rar %DIR_XXX%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XXX%\%RLSNAME%\*.zip unzip -o -qqq %DIR_XXX%\%RLSNAME%\*.zip -d %DIR_XXX%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XXX%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_XXX%\%RLSNAME%\*.rar %DIR_XXX%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_XXX%\%RLSNAME%\*.rar del %DIR_XXX%\%RLSNAME%\*.rar > NUL
if exist %DIR_XXX%\%RLSNAME%\*.zip del %DIR_XXX%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:CONSOLE
if exist %DIR_CONSOLE%\%RLSNAME% GOTO EXISTS
echo Extracting to CONSOLE...
echo.
md %DIR_CONSOLE%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_CONSOLE%\%RLSNAME% > NUL
if exist %DIR_DL%%RLSNAME%\*.rar rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_CONSOLE%\%RLSNAME% > NUL
if exist %DIR_DL%%RLSNAME%\*.001 rar x -y -inul -r %DIR_DL%%RLSNAME%\*.001 %DIR_CONSOLE%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:DVDR
if exist %DIR_DVDR%\%RLSNAME% GOTO EXISTS
echo Extracting to DVDR...
echo.
md %DIR_DVDR%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_DVDR%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_DVDR%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DVDR%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_DVDR%\%RLSNAME%\*.rar %DIR_DVDR%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DVDR%\%RLSNAME%\*.zip unzip -o -qqq %DIR_DVDR%\%RLSNAME%\*.zip -d %DIR_DVDR%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DVDR%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_DVDR%\%RLSNAME%\*.rar %DIR_DVDR%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DVDR%\%RLSNAME%\*.rar del %DIR_DVDR%\%RLSNAME%\*.rar > NUL
if exist %DIR_DVDR%\%RLSNAME%\*.zip del %DIR_DVDR%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:MDVDR
if exist %DIR_MDVDR%\%RLSNAME% GOTO EXISTS
echo Extracting to MDVDR...
echo.
md %DIR_MDVDR%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_MDVDR%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_MDVDR%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MDVDR%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_MDVDR%\%RLSNAME%\*.rar %DIR_MDVDR%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MDVDR%\%RLSNAME%\*.zip unzip -o -qqq %DIR_MDVDR%\%RLSNAME%\*.zip -d %DIR_MDVDR%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MDVDR%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_MDVDR%\%RLSNAME%\*.rar %DIR_MDVDR%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MDVDR%\%RLSNAME%\*.rar del %DIR_MDVDR%\%RLSNAME%\*.rar > NUL
if exist %DIR_MDVDR%\%RLSNAME%\*.zip del %DIR_MDVDR%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:HDDVD
if exist %DIR_HDDVD%\%RLSNAME% GOTO EXISTS
echo Extracting to HDDVD...
echo.
md %DIR_HDDVD%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_HDDVD%\%RLSNAME% > NUL
rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_HDDVD%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_HDDVD%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_HDDVD%\%RLSNAME%\*.rar %DIR_HDDVD%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_HDDVD%\%RLSNAME%\*.zip unzip -o -qqq %DIR_HDDVD%\%RLSNAME%\*.zip -d %DIR_HDDVD%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_HDDVD%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_HDDVD%\%RLSNAME%\*.rar %DIR_HDDVD%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_HDDVD%\%RLSNAME%\*.rar del %DIR_HDDVD%\%RLSNAME%\*.rar > NUL
if exist %DIR_HDDVD%\%RLSNAME%\*.zip del %DIR_HDDVD%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:MP3
if exist %DIR_MP3%\%RLSNAME% GOTO EXISTS
if %DELETE% == 0 echo Copying to MP3...
if %DELETE% == 1 echo Moving to MP3...
echo.
md %DIR_MP3%\%RLSNAME%
if %DELETE% == 0 xcopy /s %DIR_DL%%RLSNAME%\*.* %DIR_MP3%\%RLSNAME%\ > NUL
if %DELETE% == 1 move /y %DIR_DL%%RLSNAME%\*.* %DIR_MP3%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MP3%\%RLSNAME%\rushchk.log del %DIR_MP3%\%RLSNAME%\rushchk.log > NUL
if exist %DIR_MP3%\%RLSNAME%\*.missing del %DIR_MP3%\%RLSNAME%\*.missing > NUL
if exist %DIR_MP3%\%RLSNAME%\[* del %DIR_MP3%\%RLSNAME%\[* > NUL
if exist %DIR_MP3%\%RLSNAME%\*.sfv del %DIR_MP3%\%RLSNAME%\*.sfv > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:MVID
if exist %DIR_MVID%\%RLSNAME% GOTO EXISTS
if %DELETE% == 0 echo Copying to MVID...
if %DELETE% == 1 echo Moving to MVID...
echo.
md %DIR_MVID%\%RLSNAME%
if %DELETE% == 0 xcopy /s %DIR_DL%%RLSNAME%\*.* %DIR_MVID%\%RLSNAME%\ > NUL
if %DELETE% == 1 move /y %DIR_DL%%RLSNAME%\*.* %DIR_MVID%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MVID%\%RLSNAME%\rushchk.log del %DIR_MVID%\%RLSNAME%\rushchk.log > NUL
if exist %DIR_MVID%\%RLSNAME%\*.missing del %DIR_MVID%\%RLSNAME%\*.missing > NUL
if exist %DIR_MVID%\%RLSNAME%\[* del %DIR_MVID%\%RLSNAME%\[* > NUL
if exist %DIR_MVID%\%RLSNAME%\*.sfv del %DIR_MVID%\%RLSNAME%\*.sfv > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:FIX
if exist %DIR_FIX%\%RLSNAME% GOTO EXISTS
if %DELETE% == 0 echo Copying to FIX...
if %DELETE% == 1 echo Moving to FIX...
echo.
md %DIR_FIX%\%RLSNAME%
if %DELETE% == 0 xcopy /s %DIR_DL%%RLSNAME%\*.* %DIR_FIX%\%RLSNAME%\ > NUL
if %DELETE% == 1 move /y %DIR_DL%%RLSNAME%\*.* %DIR_FIX%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_FIX%\%RLSNAME%\*.zip unzip -o -qqq %DIR_FIX%\%RLSNAME%\*.zip -d %DIR_FIX%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_FIX%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_FIX%\%RLSNAME%\*.rar %DIR_FIX%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_FIX%\%RLSNAME%\file_id.diz del %DIR_FIX%\%RLSNAME%\file_id.diz > NUL
if exist %DIR_FIX%\%RLSNAME%\FILE_ID.DIZ del %DIR_FIX%\%RLSNAME%\FILE_ID.DIZ > NUL
if exist %DIR_FIX%\%RLSNAME%\rushchk.log del %DIR_FIX%\%RLSNAME%\rushchk.log > NUL
if exist %DIR_FIX%\%RLSNAME%\*.missing del %DIR_FIX%\%RLSNAME%\*.missing > NUL
if exist %DIR_FIX%\%RLSNAME%\[* del %DIR_FIX%\%RLSNAME%\[* > NUL
if exist %DIR_FIX%\%RLSNAME%\*.sfv del %DIR_FIX%\%RLSNAME%\*.sfv > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:0DAY
if exist %DIR_0DAY%\%RLSNAME% GOTO EXISTS
echo Extracting to 0DAY...
echo.
md %DIR_0DAY%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_0DAY%\%RLSNAME% > NUL
unzip -o -qqq %DIR_DL%%RLSNAME%\*.zip -d %DIR_0DAY%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_0DAY%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_0DAY%\%RLSNAME%\*.rar %DIR_0DAY%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_0DAY%\%RLSNAME%\*.001 rar x -y -inul -r %DIR_0DAY%\%RLSNAME%\*.rar %DIR_0DAY%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_0DAY%\%RLSNAME%\*.zip unzip -o -qqq %DIR_0DAY%\%RLSNAME%\*.zip -d %DIR_0DAY%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_0DAY%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_0DAY%\%RLSNAME%\*.rar %DIR_0DAY%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_0DAY%\%RLSNAME%\file_id.diz del %DIR_0DAY%\%RLSNAME%\file_id.diz > NUL
if exist %DIR_0DAY%\%RLSNAME%\FILE_ID.DIZ del %DIR_0DAY%\%RLSNAME%\FILE_ID.DIZ > NUL
if exist %DIR_0DAY%\%RLSNAME%\Thumbs.db del /AH %DIR_0DAY%\%RLSNAME%\Thumbs.db > NUL
if exist %DIR_0DAY%\%RLSNAME%\pH.nfo del %DIR_0DAY%\%RLSNAME%\pH.nfo > NUL
if exist %DIR_0DAY%\%RLSNAME%\crude.exe del %DIR_0DAY%\%RLSNAME%\crude.exe > NUL
if exist %DIR_0DAY%\%RLSNAME%\cff.jpg del %DIR_0DAY%\%RLSNAME%\cff.jpg > NUL
if exist %DIR_0DAY%\%RLSNAME%\cff2ck2.jpg del %DIR_0DAY%\%RLSNAME%\cff2ck2.jpg > NUL
if exist %DIR_0DAY%\%RLSNAME%\CORE10k.EXE del %DIR_0DAY%\%RLSNAME%\CORE10k.EXE > NUL
if exist %DIR_0DAY%\%RLSNAME%\EXPLOSiON.exe del %DIR_0DAY%\%RLSNAME%\EXPLOSiON.exe > NUL
if exist %DIR_0DAY%\%RLSNAME%\nfoviewer.exe del %DIR_0DAY%\%RLSNAME%\nfoviewer.exe > NUL
if exist %DIR_0DAY%\%RLSNAME%\nud.jpg del %DIR_0DAY%\%RLSNAME%\nud.jpg > NUL
if exist %DIR_0DAY%\%RLSNAME%\nud.nfo del %DIR_0DAY%\%RLSNAME%\nud.nfo > NUL
if exist %DIR_0DAY%\%RLSNAME%\CFF_GFX0*.jpg del %DIR_0DAY%\%RLSNAME%\CFF_GFX0*.jpg > NUL
if exist %DIR_0DAY%\%RLSNAME%\TMGNfo.exe del %DIR_0DAY%\%RLSNAME%\TMGNfo.exe > NUL
if exist %DIR_0DAY%\%RLSNAME%\nGen.exe del %DIR_0DAY%\%RLSNAME%\nGen.exe > NUL
if exist %DIR_0DAY%\%RLSNAME%\the_solution_is_whithin_us.jpg del %DIR_0DAY%\%RLSNAME%\the_solution_is_whithin_us.jpg > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.sfv del %DIR_0DAY%\%RLSNAME%\*.sfv > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.rar del %DIR_0DAY%\%RLSNAME%\*.rar > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r0* del %DIR_0DAY%\%RLSNAME%\*.r0* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r1* del %DIR_0DAY%\%RLSNAME%\*.r1* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r2* del %DIR_0DAY%\%RLSNAME%\*.r2* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r3* del %DIR_0DAY%\%RLSNAME%\*.r3* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r4* del %DIR_0DAY%\%RLSNAME%\*.r4* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r5* del %DIR_0DAY%\%RLSNAME%\*.r5* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r6* del %DIR_0DAY%\%RLSNAME%\*.r6* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r7* del %DIR_0DAY%\%RLSNAME%\*.r7* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r8* del %DIR_0DAY%\%RLSNAME%\*.r8* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.r9* del %DIR_0DAY%\%RLSNAME%\*.r9* > NUL
if exist %DIR_0DAY%\%RLSNAME%\*.zip del %DIR_0DAY%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:IMAGE
if exist %DIR_IMAGE%\%RLSNAME% GOTO EXISTS
echo Extracting to IMAGESET...
echo.
md %DIR_IMAGE%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_IMAGE%\%RLSNAME% > NUL
unzip -o -qqq %DIR_DL%%RLSNAME%\*.zip -d %DIR_IMAGE%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_IMAGE%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_IMAGE%\%RLSNAME%\*.rar %DIR_IMAGE%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_IMAGE%\%RLSNAME%\*.zip unzip -o -qqq %DIR_IMAGE%\%RLSNAME%\*.zip -d %DIR_IMAGE%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_IMAGE%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_IMAGE%\%RLSNAME%\*.rar %DIR_IMAGE%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_IMAGE%\%RLSNAME%\file_id.diz del %DIR_IMAGE%\%RLSNAME%\file_id.diz > NUL
if exist %DIR_IMAGE%\%RLSNAME%\FILE_ID.DIZ del %DIR_IMAGE%\%RLSNAME%\FILE_ID.DIZ > NUL
if exist %DIR_IMAGE%\%RLSNAME%\Thumbs.db del /AH %DIR_IMAGE%\%RLSNAME%\Thumbs.db > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.sfv del %DIR_IMAGE%\%RLSNAME%\*.sfv > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.rar del %DIR_IMAGE%\%RLSNAME%\*.rar > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r0* del %DIR_IMAGE%\%RLSNAME%\*.r0* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r1* del %DIR_IMAGE%\%RLSNAME%\*.r1* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r2* del %DIR_IMAGE%\%RLSNAME%\*.r2* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r3* del %DIR_IMAGE%\%RLSNAME%\*.r3* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r4* del %DIR_IMAGE%\%RLSNAME%\*.r4* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r5* del %DIR_IMAGE%\%RLSNAME%\*.r5* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r6* del %DIR_IMAGE%\%RLSNAME%\*.r6* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r7* del %DIR_IMAGE%\%RLSNAME%\*.r7* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r8* del %DIR_IMAGE%\%RLSNAME%\*.r8* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.r9* del %DIR_IMAGE%\%RLSNAME%\*.r9* > NUL
if exist %DIR_IMAGE%\%RLSNAME%\*.zip del %DIR_IMAGE%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:EBOOK
if exist %DIR_EBOOK%\%RLSNAME% GOTO EXISTS
echo Extracting to EBOOK...
echo.
md %DIR_EBOOK%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_EBOOK%\%RLSNAME% > NUL
if exist %DIR_DL%%RLSNAME%\*.rar rar x -y -inul -r %DIR_DL%%RLSNAME% %DIR_EBOOK%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DL%\%RLSNAME%\*.zip unzip -o -qqq %DIR_DL%\%RLSNAME%\*.zip -d %DIR_EBOOK%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_EBOOK%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_EBOOK%\%RLSNAME%\*.rar %DIR_EBOOK%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_EBOOK%\%RLSNAME%\*.zip unzip -o -qqq %DIR_EBOOK%\%RLSNAME%\*.zip -d %DIR_EBOOK%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_EBOOK%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_EBOOK%\%RLSNAME%\*.rar %DIR_EBOOK%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_EBOOK%\%RLSNAME%\file_id.diz del %DIR_EBOOK%\%RLSNAME%\file_id.diz > NUL
if exist %DIR_EBOOK%\%RLSNAME%\FILE_ID.DIZ del %DIR_EBOOK%\%RLSNAME%\FILE_ID.DIZ > NUL
if exist %DIR_EBOOK%\%RLSNAME%\Thumbs.db del /AH %DIR_EBOOK%\%RLSNAME%\Thumbs.db > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.sfv del %DIR_EBOOK%\%RLSNAME%\*.sfv > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.rar del %DIR_EBOOK%\%RLSNAME%\*.rar > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r0* del %DIR_EBOOK%\%RLSNAME%\*.r0* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r1* del %DIR_EBOOK%\%RLSNAME%\*.r1* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r2* del %DIR_EBOOK%\%RLSNAME%\*.r2* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r3* del %DIR_EBOOK%\%RLSNAME%\*.r3* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r4* del %DIR_EBOOK%\%RLSNAME%\*.r4* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r5* del %DIR_EBOOK%\%RLSNAME%\*.r5* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r6* del %DIR_EBOOK%\%RLSNAME%\*.r6* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r7* del %DIR_EBOOK%\%RLSNAME%\*.r7* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r8* del %DIR_EBOOK%\%RLSNAME%\*.r8* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.r9* del %DIR_EBOOK%\%RLSNAME%\*.r9* > NUL
if exist %DIR_EBOOK%\%RLSNAME%\*.zip del %DIR_EBOOK%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:MISC
if exist %DIR_MISC%\%RLSNAME% GOTO EXISTS
echo Extracting to MISC...
echo.
md %DIR_MISC%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_MISC%\%RLSNAME% > NUL
if exist %DIR_DL%%RLSNAME%\*.zip unzip -o -qqq %DIR_DL%%RLSNAME%\*.zip -d %DIR_MISC%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_DL%%RLSNAME%\*.rar rar x -y -inul -r %DIR_DL%\%RLSNAME%\*.rar %DIR_MISC%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MISC%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_MISC%\%RLSNAME%\*.rar %DIR_MISC%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MISC%\%RLSNAME%\*.zip unzip -o -qqq %DIR_MISC%\%RLSNAME%\*.zip -d %DIR_MISC%\%RLSNAME%\ > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MISC%\%RLSNAME%\*.rar rar x -y -inul -r %DIR_MISC%\%RLSNAME%\*.rar %DIR_MISC%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if exist %DIR_MISC%\%RLSNAME%\file_id.diz del %DIR_MISC%\%RLSNAME%\file_id.diz > NUL
if exist %DIR_MISC%\%RLSNAME%\FILE_ID.DIZ del %DIR_MISC%\%RLSNAME%\FILE_ID.DIZ > NUL
if exist %DIR_MISC%\%RLSNAME%\Thumbs.db del /AH %DIR_MISC%\%RLSNAME%\Thumbs.db > NUL
if exist %DIR_MISC%\%RLSNAME%\*.sfv del %DIR_MISC%\%RLSNAME%\*.sfv > NUL
if exist %DIR_MISC%\%RLSNAME%\*.rar del %DIR_MISC%\%RLSNAME%\*.rar > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r0* del %DIR_MISC%\%RLSNAME%\*.r0* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r1* del %DIR_MISC%\%RLSNAME%\*.r1* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r2* del %DIR_MISC%\%RLSNAME%\*.r2* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r3* del %DIR_MISC%\%RLSNAME%\*.r3* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r4* del %DIR_MISC%\%RLSNAME%\*.r4* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r5* del %DIR_MISC%\%RLSNAME%\*.r5* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r6* del %DIR_MISC%\%RLSNAME%\*.r6* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r7* del %DIR_MISC%\%RLSNAME%\*.r7* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r8* del %DIR_MISC%\%RLSNAME%\*.r8* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.r9* del %DIR_MISC%\%RLSNAME%\*.r9* > NUL
if exist %DIR_MISC%\%RLSNAME%\*.zip del %DIR_MISC%\%RLSNAME%\*.zip > NUL
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END


:ISO
if exist %DIR_ISO%\%RLSNAME% GOTO EXISTS
echo Extracting to ISO...
echo.
md %DIR_ISO%\%RLSNAME%
if exist %DIR_DL%%RLSNAME%\*.nfo copy %DIR_DL%%RLSNAME%\*.nfo %DIR_ISO%\%RLSNAME% > NUL
dir /b /s /on %DIR_DL%%RLSNAME% > files.dat
grep -i -q -E "\.rar" files.dat
if %errorlevel% == 0 set rarfile=1
grep -i -q -E "\.001" files.dat
if %errorlevel% == 0 set rarfile=0
if %rarfile% == 1 rar x -y -inul -r %DIR_DL%%RLSNAME%\*.rar %DIR_ISO%\%RLSNAME% > NUL
if %rarfile% == 0 rar x -y -inul -r %DIR_DL%%RLSNAME%\*.001 %DIR_ISO%\%RLSNAME% > NUL
if not %errorlevel% == 0 goto ERROR
if %DELETE% == 1 rmdir /S /Q %DIR_DL%%RLSNAME% > NUL
GOTO END



:EXISTS
echo The folder already exists!
echo.
GOTO END


:INCOMPLETE
echo Download incomplete!
echo.
GOTO END


:ERROR
echo.
echo Error during extraction!
echo.
if exist %DIR_XVID%\%RLSNAME% rmdir /S /Q %DIR_XVID%\%RLSNAME% > NUL
if exist %DIR_DVDR%\%RLSNAME% rmdir /S /Q %DIR_DVDR%\%RLSNAME% > NUL
if exist %DIR_MP3%\%RLSNAME% rmdir /S /Q %DIR_MP3%\%RLSNAME% > NUL
if exist %DIR_0DAY%\%RLSNAME% rmdir /S /Q %DIR_0DAY%\%RLSNAME% > NUL
if exist %DIR_MISC%\%RLSNAME% rmdir /S /Q %DIR_MISC%\%RLSNAME% > NUL
if exist %DIR_ISO%\%RLSNAME% rmdir /S /Q %DIR_ISO%\%RLSNAME% > NUL
if exist %DIR_TV%\%RLSNAME% rmdir /S /Q %DIR_TV%\%RLSNAME% > NUL
if exist %DIR_XXX%\%RLSNAME% rmdir /S /Q %DIR_XXX%\%RLSNAME% > NUL
if exist %DIR_DOKU%\%RLSNAME% rmdir /S /Q %DIR_DOKU%\%RLSNAME% > NUL
if exist %DIR_EBOOK%\%RLSNAME% rmdir /S /Q %DIR_EBOOK%\%RLSNAME% > NUL
if exist %DIR_HDDVD%\%RLSNAME% rmdir /S /Q %DIR_HDDVD%\%RLSNAME% > NUL
if exist %DIR_IMAGE%\%RLSNAME% rmdir /S /Q %DIR_IMAGE%\%RLSNAME% > NUL
if exist %DIR_MDVDR%\%RLSNAME% rmdir /S /Q %DIR_MDVDR%\%RLSNAME% > NUL
if exist %DIR_FIXES%\%RLSNAME% rmdir /S /Q %DIR_FIXES%\%RLSNAME% > NUL
if exist %DIR_CONSOLE%\%RLSNAME% rmdir /S /Q %DIR_CONSOLE%\%RLSNAME% > NUL
GOTO END


:HELP
type header.dat
type help.txt
echo Now use your tits to hit any key...
pause > NUL

:END
if exist files.dat del files.dat
