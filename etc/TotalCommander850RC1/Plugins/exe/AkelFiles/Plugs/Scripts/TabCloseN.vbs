' TabCloseN.vbs
'================   Описание   =================
' Закрывает нужное количество вкладок
'================  Параметр  ==================
' число закрываемых вкладок - без параметров выводится диалог ввода
'================    Примеры    ================
' -"Закрыть N вкладок" Call("Scripts::Main", 1, "TabCloseN.vbs")
' -"Закрыть 5 вкладок" Call("Scripts::Main", 1, "TabCloseN.vbs", `"5"`)

' Автор:             Аверин Андрей
' Версия:          1.3 (06.06.2011 - 23.07.2012)
' Mail:                 Averin-And@yandex.ru
' Site:                  http://tc-image.3dn.ru/forum/9-414-1198-16-1333817793
'============================================
If AkelPad.GetEditWnd() = 0 Then WScript.Quit()
If WScript.Arguments.Count > 0 Then
  N = WScript.Arguments(0)
Else
  N = InputBox("Введите нужное количество закрываемых вкладок", "Закрытие вкладок", "20")
  If Len(N) = 0  Or IsEmpty(N) Then WScript.Quit
End If
MainWnd = AkelPad.GetMainWnd() : Call SetRedraw(MainWnd, False)
For ii = 1 To N : Call AkelPad.SendMessage(MainWnd, 273, 4318, 0) : Next
Call SetRedraw(MainWnd, True)

Function SetRedraw(hhWnd, bRedraw)
  With AkelPad .SendMessage hhWnd, 11, bRedraw, 0 : If bRedraw Then : .SystemFunction().Call "user32::InvalidateRect", hhWnd, 0, True : End If : End With
End Function