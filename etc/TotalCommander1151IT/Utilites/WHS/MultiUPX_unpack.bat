@echo off   
:loop  
if -%1==- pause && cls && goto :EOF  
"%COMMANDER_PATH%\Utilites\UPXgui\upx\upx.exe" -d --no-backup %1  
shift  
goto loop