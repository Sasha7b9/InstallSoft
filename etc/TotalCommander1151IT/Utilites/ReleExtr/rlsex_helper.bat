@echo off
IF "%1"=="" GOTO HELP
IF "%1"=="/?" GOTO HELP
IF "%1"=="-?" GOTO HELP
IF "%1"=="-h" GOTO HELP
IF "%1"=="-help" GOTO HELP
IF "%1"=="--help" GOTO HELP

echo %1 | sed -e s/\\//g > temp.dat
for /f %%i in (temp.dat) do call rlsex_helper2.bat %%i %2
del temp.dat

goto END

:HELP
type header.dat
type help.txt
echo Now use your ass to hit any key...
pause > NUL

:END
