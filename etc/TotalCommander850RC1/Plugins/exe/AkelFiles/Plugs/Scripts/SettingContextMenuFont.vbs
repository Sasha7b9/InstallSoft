' SettingContextMenuFont.vbs
'========================   Описание   =====================================
' Вызывает настройку меню (ContextMenu) с другим шрифтом 
'=======================   Параметры  =====================================
' 1-й параметр: Номер вызываемого меню 
'    0 - контекстное меню
'    1 - главное меню
'    2 - меню редактирования
'    3 - меню вкладок
'    4 - меню ссылок
' 2-й параметр: Строка, которую найти и выделить в редактируемом меню (по умолчанию "")
'========================   Примеры   =====================================
' -"Изменить &меню..." Call("Scripts::Main", 1, "SettingContextMenuFont.vbs", `"1" "Плагины"`) Icon("%a\AkelPadImage.dll",93)
' Автор:             Аверин Андрей
' Версия:          1.1 (15.09.2011 - 01.11.2011)
' Mail:                 Averin-And@yandex.ru
' Site:                  http://tc-image.3dn.ru/forum/9-294-1187-16-1333798315
'=======================   Дополнение   ====================================
' - используется скрипт PlugContextMenuAkelFont.js http://tc-image.3dn.ru/forum/9-294-928-16-1333094169
'=======================================================================
aIndex = 1 : aString = ""

With WScript
  Cnt = .Arguments.Count
  If Cnt > 0 Then
    aIndex = .Arguments(0) : If Cnt > 1 Then aString = .Arguments(1)
  End If
End With

Call AkelPad.Call("ContextMenu::Main", 1, CInt(aIndex), aString)
Call AkelPad.Call("Scripts::Main", 1, "PlugContextMenuAkelFont.js", "'Arial' '1' '12' " & aIndex)