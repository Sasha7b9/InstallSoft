@echo off
setlocal enabledelayedexpansion

:: Define file paths
set "F1=%COMMANDER_PATH%\bars\Bar_01.bar"
set "F2=%COMMANDER_PATH%\bars\_editors.bar"
set "F3=%COMMANDER_PATH%\Ini\Associations.ini"

:: Expand environment variables
for /f "delims=" %%A in ('powershell -command "[System.IO.Path]::GetFullPath('%F1%')"') do set "F1=%%A"
for /f "delims=" %%A in ('powershell -command "[System.IO.Path]::GetFullPath('%F2%')"') do set "F2=%%A"
for /f "delims=" %%A in ('powershell -command "[System.IO.Path]::GetFullPath('%F3%')"') do set "F3=%%A"

:: Define strings to replace (escaping special characters for regex safety)
set "Str1=button29=wcmicons.dll,225"
set "Str2=button29=wcmicons.dll,224"
set "Str3=\[Associations\]"
set "Str4=\[-Associations\]"

:: Read the current "bCheck" value from a helper INI file
set "sFile=%~dp0config.ini"
if not exist "%sFile%" echo [Config] > "%sFile%" & echo EnableInternalAssoc=0 >> "%sFile%"

for /f "tokens=2 delims==" %%A in ('findstr /i "EnableInternalAssoc=" "%sFile%"') do set "bCheck=%%A"

:: Toggle the bCheck value
if "%bCheck%"=="0" (set "bCheck=1") else (set "bCheck=0")
powershell -command "(Get-Content '%sFile%') -replace 'EnableInternalAssoc=.*', 'EnableInternalAssoc=%bCheck%' | Set-Content '%sFile%'"

:: Replace content in files using PowerShell with escaped regex characters
if "%bCheck%"=="1" (
    powershell -command "(Get-Content '%F1%') -creplace '^%Str2%$', '%Str1%' | Set-Content '%F1%'"
    powershell -command "(Get-Content '%F2%') -creplace '^%Str2%$', '%Str1%' | Set-Content '%F2%'"
    powershell -command "(Get-Content '%F3%') -creplace '^%Str4%$', '[Associations]' | Set-Content '%F3%'"
) else (
    powershell -command "(Get-Content '%F1%') -creplace '^%Str1%$', '%Str2%' | Set-Content '%F1%'"
    powershell -command "(Get-Content '%F2%') -creplace '^%Str1%$', '%Str2%' | Set-Content '%F2%'"
    powershell -command "(Get-Content '%F3%') -creplace '^%Str3%$', '[-Associations]' | Set-Content '%F3%'"
)

:: Call TCFS2.exe to refresh Total Commander
"%COMMANDER_PATH%\Utilites\TCFS2\TCFS2.exe" /ef msg(1045,0,0) tcm(2945)

exit /b
