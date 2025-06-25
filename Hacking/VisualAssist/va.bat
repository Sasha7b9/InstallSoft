@echo off
set tempfile="%temp%\1489AFE4.TMP"
set regkey=HKEY_CURRENT_USER\SOFTWARE\Licenses
set has_error=0

tasklist | find /I "devenv.exe" > NUL
if %errorlevel% == 0 (
	echo Please close Visual Studio and try again.
	exit /B 1
)

echo.

echo Resetting Visual Assist X trial period
echo Deleting registry key %regkey% ...
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.




set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bxLLnRymYof
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cymunghbsrs
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\dbwlpz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ebpwmp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\EflYlh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ensw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ghmHPv
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gzgwoNp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jkqxzlhvvid
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\lzwdczyq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\msoVOw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\onykWy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Psrbzcva
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\quOi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sbEanukzXqza
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uvxdqUwHWvNfu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vxoimpTDeni
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ycykIco
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Zgfqtoae
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\abIyprfitZff
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.





set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cAnevc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cngnal
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.








set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\HbKkrswoNvem
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\icad
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kDbhMPh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

















set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sfawIwjc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\topvudmPeyak
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xCQu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
































































set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\abIyprfitZff
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.





set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cAnevc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cngnal
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.








set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\HbKkrswoNvem
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\icad
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kDbhMPh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

















set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sfawIwjc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\topvudmPeyak
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xCQu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.







































































































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\auphdPcflhr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.




set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Caaq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\elxy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jrnHQeYsCi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ogYa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\szjLqBoBrtTrp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xagjglB
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xYkcm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.













































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\auphdPcflhr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Caaq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\elxy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jrnHQeYsCi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ogYa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\szjLqBoBrtTrp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xagjglB
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xYkcm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.





































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aoBhfczcoyev
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\brNpgUyknQ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bVewMkl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\enzqEcij
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fuyllcFpUeHk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gerFfXzijV
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gsSkirIrRts
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hgnjDzrtuDgO
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hyWz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\iqyp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\isauyquJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\isHSRqHU
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\katbmHWxKao
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ljrn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Ltoh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nrbS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\PAPAOd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pCvNZVw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pixhz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pscrsqsXBs
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qaYxq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qwrqrvTtvb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QYhylnp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qZzr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sadxecpFinkc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\serf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sLpwwwxtuYhxp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UaggiewjtSyv
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\zlwwBTWnztkc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.




































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aoBhfczcoyev
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\brNpgUyknQ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bVewMkl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\enzqEcij
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fuyllcFpUeHk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gerFfXzijV
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gsSkirIrRts
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hgnjDzrtuDgO
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hyWz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\iqyp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\isauyquJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\isHSRqHU
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\katbmHWxKao
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ljrn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Ltoh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nrbS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\PAPAOd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pCvNZVw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pixhz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pscrsqsXBs
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qaYxq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qwrqrvTtvb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QYhylnp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qZzr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sadxecpFinkc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\serf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sLpwwwxtuYhxp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UaggiewjtSyv
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\zlwwBTWnztkc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.















































































































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aeuwzyob
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bfqw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\BungyggrwaVe
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ccGiatza
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\CnaarcfIk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\eacihN
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ecbd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ezai
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fbsaes
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fhktqesImqRz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gqBx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gXfoaNdsxUpdT
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hkdlQsxjqRbb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\honafpdcmQtzA
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrihV
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\IgCknvgofH
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\itFkqz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\KpAoLu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kplfYBZQ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kptbqxnQDppjy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kVfCb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kxxygFnfxmc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\LerQhvvbtv
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nfbhd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pmcKRydBVhhq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rjvwcm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\swwH
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tjvkkqxdk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Trtepfzi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UbyyauItqQpa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\umcgvEqiOt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uSvM
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\voxhz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vrrijMzqy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vRsnuzS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\VSLgfQQIsQS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wbfgvo
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wgphPrzTdHD
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\WyhrgxJju
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\XoJhQTlrMr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xpIJlnle
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yedb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ygneahjmNi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

















































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aeuwzyob
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bfqw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\BungyggrwaVe
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ccGiatza
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\CnaarcfIk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\eacihN
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ecbd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ezai
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fbsaes
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fhktqesImqRz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gqBx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gXfoaNdsxUpdT
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hkdlQsxjqRbb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\honafpdcmQtzA
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrihV
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\IgCknvgofH
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\itFkqz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\KpAoLu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kplfYBZQ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kptbqxnQDppjy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kVfCb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kxxygFnfxmc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\LerQhvvbtv
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nfbhd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pmcKRydBVhhq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rjvwcm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\swwH
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tjvkkqxdk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Trtepfzi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UbyyauItqQpa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\umcgvEqiOt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uSvM
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\voxhz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vrrijMzqy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vRsnuzS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\VSLgfQQIsQS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wbfgvo
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wgphPrzTdHD
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\WyhrgxJju
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\XoJhQTlrMr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xpIJlnle
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yedb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ygneahjmNi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



























































































































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aelctuwokiHd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\AhmiCymkzF
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bFhdacIe
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\biOib
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bthaydPggd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bXqgc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\dLZdyobiqPha
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\duJh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\dzrlexcffuf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\EmmSzCH
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fbkxvzDvKwZd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\FlbOMfIcjt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ftgrmyMCcpm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hpuAhbedDwN
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrkkui
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






































































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\KjbEQeeyl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kyrk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\lsDEg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrYIyc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kAYmw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.













































































































































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nITBt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nwimuZYqLmjh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nxmzybubryrwV
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ohzgyvcz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\oqrw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\paOalX
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QfTCkzkxiwt
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\roncsI
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rxhk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sbrkw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jyridbmvxtl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Sgdklg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\srOoUz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\swcxzkvfvf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tSrtwxC
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\TxyqjrVckalc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Tzyfxev
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vutqcLc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\VVxtThkwf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vWWyf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wgnvzg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xdKJw
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xxkibafgXzoh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yKbrrRxyu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yunLuspovk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\zqfJTQsiScyks
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QfTCkzkxiwt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.














set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QfTCkzkxiwt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
























































































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QfTCkzkxiwt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\eRacg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrZol
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Jcboyuq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ncUciwvHBhh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Pqaqz
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qkEl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tWPq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.































































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\CznjuEtakiowa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\eRacg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hrZol
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Jcboyuq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ncUciwvHBhh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Pqaqz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qkEl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tWPq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
















































































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aFcXjMUR
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\BJldyZKtyVq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cavzxng
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cnqkckQx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\czgnntp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ebGDkpA
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\erbz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ezyqypjkuru
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fdmGKpswovau
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\FvtevyvivbqmB
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gzypzq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hKrlEoanld
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kwhr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mlnKGnln
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mvsSpoi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ntiA
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\owLd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ozJqnNYuikef
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pwrEpqpzqutf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pzthtghcLc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qhlkhxh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QoDanadhn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qQkrobypqr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rXddg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\snyhrSinnRwe
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ukAwzzpdsd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uKsIckGmxwqct
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vgtajhqpoeqy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vwpb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wFfszP
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\WPsIqsOmCpin
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wyWG
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xizeda
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Zdrhq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\zMYPzkTmomdXx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ZtWrscc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ZwVqowdFkQt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



























































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\aFcXjMUR
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.



set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\BJldyZKtyVq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cavzxng
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cnqkckQx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\czgnntp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ebGDkpA
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\erbz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ezyqypjkuru
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\fdmGKpswovau
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\FvtevyvivbqmB
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gzypzq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hKrlEoanld
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kwhr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mlnKGnln
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mvsSpoi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ntiA
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\owLd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ozJqnNYuikef
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pwrEpqpzqutf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\pzthtghcLc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qhlkhxh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QoDanadhn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\qQkrobypqr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rXddg
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\snyhrSinnRwe
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ukAwzzpdsd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uKsIckGmxwqct
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vgtajhqpoeqy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vwpb
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wFfszP
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.






set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\WPsIqsOmCpin
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\wyWG
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xizeda
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Zdrhq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\zMYPzkTmomdXx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ZtWrscc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ZwVqowdFkQt
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.































































































echo Deleting temporary file %tempfile% ...
del %tempfile%>NUL

echo.

if %has_error% == 0 (
	echo Done. Visual Assist X should have forgotten about your trial period now.
) else (
	echo Done. However, maybe not everything worked out right.
)































set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bpXConabwlu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cRyjryVFl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\DAwjs
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\dydvgqoaqtgL
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ekqUnnbosmks
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gloks
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hAbjqoegdC
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Iqdwvqz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\JcujtohsvnkMm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\JrkhAtfx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jwjwWtxkq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mogwBdqm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nMuookkcpmmlF
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Rzziqx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tkRzVHCTT
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uQrmvfisf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UzauzQ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vqDk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xbrxBKfI
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xynty
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yqjyhlq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yyYwqwsoGZpj
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_CLASSES_ROOT\WOW6432Node\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\znfxCrtjcej
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.










































set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\bpXConabwlu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cRyjryVFl
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\DAwjs
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\dydvgqoaqtgL
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ekqUnnbosmks
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gloks
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\hAbjqoegdC
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Iqdwvqz
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\JcujtohsvnkMm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\JrkhAtfx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jwjwWtxkq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mogwBdqm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\nMuookkcpmmlF
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Rzziqx
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\tkRzVHCTT
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\uQrmvfisf
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UzauzQ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vqDk
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xbrxBKfI
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xynty
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yqjyhlq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yyYwqwsoGZpj
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.


set regkey=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Classes\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\znfxCrtjcej
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

























































set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\abIyprfitZff
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cAnevc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cngnal
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\HbKkrswoNvem
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\icad
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.















set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kDbhMPh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sfawIwjc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\topvudmPeyak
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xCQu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\icad
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.





















































set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ErVQQsY
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\gWcjOtlYFhsYc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kkNay
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\mdDtul
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ocpgOau
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rljeoukotvmS
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\UguyGGmipa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.























set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\auphdPcflhr
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Caaq
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\elxy
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\jrnHQeYsCi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.

set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ogYa
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.










set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\szjLqBoBrtTrp
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xagjglB
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xYkcm
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.












































set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\blsUqpzd
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ddTAuqwvcn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\Mepwvie
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\ngtlvSks
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\QPqQjZn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\rwIjxVi
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\stkgzoiGkJyfJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\vozmbhihqdPOn
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.































































































set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\abIyprfitZff
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cAnevc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\cngnal
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\HbKkrswoNvem
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\icad
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\kDbhMPh
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\sfawIwjc
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\topvudmPeyak
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\xCQu
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.
set regkey=HKEY_CLASSES_ROOT\CLSID\{11BA27BC-BFB5-5382-0F82-843F8D58A3AC}\yoIHcgulWycJ
reg delete %regkey% /f
if %errorlevel% == 1 (
	echo Registry key was not deleted.
	set has_error=1
)
echo.











exit /B %has_error%













