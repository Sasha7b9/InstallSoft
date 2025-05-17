' TabCloseExts.vbs
'========================   Описание   =====================================
' Закрыть вкладки только определённых типов файлов
'=======================   Параметры  =====================================
' Строка типов файлов, вкладки которых необходимо закрыть (типы заключаются в ;)
'========================   Примеры   =====================================
' -"Закрыть вкладки файлов .vbs" Call("Scripts::Main", 1, "TabCloseExts.vbs", `";vbs;"`)
' -"Закрыть вкладки файлов .txt и .ini" Call("Scripts::Main", 1, "TabCloseExts.vbs", `";txt;ini;"`)

' Автор:             Аверин Андрей
' Версия:          1.2 (12.03.2012 - 01.05.2012)
' Mail:                 Averin-And@yandex.ru
' Site:                  http://tc-image.3dn.ru/forum/9-413-1197-16-1333817670
'======================================================================
If AkelPad.GetEditWnd() = 0 Then WScript.Quit()
If WScript.Arguments.Count = 0 Then MsgBox "Не хватает параметров! Должен быть один параметр ", 64, "" : WScript.Quit
xLine = WScript.Arguments(0) : xxx = 1 : xText = ""
With AkelPad MainWnd = .GetMainWnd() : Call SetRedraw(MainWnd, False)
  Do While xxx = 1
    xFile = .GetEditFile(0)
    If Len(xFile) > 0 Then
      If InStr(LCase(xText), LCase(xFile)) > 0 Then
        Exit Do
      Else
        xText = xText & xFile & vbNewLine
        If InStr(xLine, ";" & LCase(CreateObject("Scripting.FileSystemObject").GetExtensionName(xFile)) & ";") Then Call .SendMessage(.GetMainWnd(), 273, 4318, 0)
        Call .SendMessage(MainWnd, 273, 4316, 0)
      End If
    Else
      Call .SendMessage(MainWnd, 273, 4316, 0)
    End If
  Loop
  Call SetRedraw(MainWnd, True)
End With

Function SetRedraw(hhWnd, bRedraw)
  With AkelPad .SendMessage hhWnd, 11, bRedraw, 0 : If bRedraw Then : .SystemFunction().Call "user32::InvalidateRect", hhWnd, 0, True : End If : End With
End Function