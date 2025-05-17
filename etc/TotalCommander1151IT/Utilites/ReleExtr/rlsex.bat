@echo off
type header.dat
IF "%1"=="" GOTO HELP
IF "%1"=="/?" GOTO HELP
IF "%1"=="-?" GOTO HELP
IF "%1"=="-h" GOTO HELP
IF "%1"=="-help" GOTO HELP
IF "%1"=="--help" GOTO HELP

for /f %%r in (%1) do call rlsex_helper.bat %%r %2

echo.
echo Done.
echo.
goto END

:HELP
type help.txt

:END
echo Now use your nose to hit any key...
pause > NUL
