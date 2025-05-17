' ReturnsTabs.vbs
'========================   Описание   =======================
' Возвращает N вкладок
'=======================   Параметры  =======================
' N - число возвращаемых вкладок (по умолчанию N=2)
' если N=-1 - выводится диалог ввода

' Автор:             Аверин Андрей
' Версия:          1.3 (25.09.2011 - 23.07.2012)
' Mail:                 Averin-And@yandex.ru
' Site:                  http://tc-image.3dn.ru/forum/9-394-1173-16-1333738852
'==========================================================

N = 2 : If WScript.Arguments.Count > 0 Then N = WScript.Arguments(0)
If N = "-1" Then
  N = InputBox("Введите число возвращаемых вкладок", "Вернуть вкладки", "5")
  If IsEmpty(N) Then WScript.Quit
End If  
If Len(N) = 0 Then WScript.Quit
If AkelPad.GetEditWnd() = 0 Then N = N - 1
MainWnd = AkelPad.GetMainWnd() : Call SetRedraw(MainWnd, False)
For ii = 1 To N + 1 : Call AkelPad.Command(5001 + ii) : Next
Call SetRedraw(MainWnd, True)

Function SetRedraw(hhWnd, bRedraw)
  With AkelPad .SendMessage hhWnd, 11, bRedraw, 0 : If bRedraw Then : .SystemFunction().Call "user32::InvalidateRect", hhWnd, 0, True : End If : End With
End Function