'********************************************************************
' Имя: CreateFolderWithNameDate.vbs
' Язык: VBScript
' Модификация: Шаповалов Арсений aka ApceH Hypocrite
' Описание: Создаёт в указанной папке новую папку с текущей датой в названии.
'           Если папку уже существует, к имени добавляется номер в скобках.
'********************************************************************

Option Explicit
Dim ws,FSO,Target,NewTarget,CurDate,CurTime,DirName,Number

On Error Resume Next 

If (WScript.Arguments.Count <> 1) Then
 MsgBox "Скрипт предназначен для запуска с панели Total Commander!" & vbCrlf & vbCrlf & "Скрипт ожидает ровно 1 параметр:" & vbCrlf & "• папка назначения (обычно ""%P"")" & vbCrlf & vbCrlf & "Внимание!" & vbCrlf & "• Нужно заключать в кавычки параметры, содержащие пробелы.", vbOKOnly+vbCritical, "Неправильное использование" 
 WScript.Quit
End If

Set FSO = CreateObject("Scripting.FileSystemObject")
Target  = WScript.Arguments(0)

CurDate = Date
CurTime = Time
DirName = Year(CurDate) & "-" & Right("0" & Month(CurDate), 2) & "-" & Right("0" & Day(CurDate), 2) & "." & Right("0" & Hour(CurTime), 2) & "-" & Right("0" & Minute(CurTime), 2)

NewTarget = Target & "\" & DirName
If Not FSO.FolderExists(NewTarget) Then 
 FSO.CreateFolder(NewTarget)
Else
 Number = 2
 NewTarget = NewTarget & " ("
 Do While FSO.FolderExists(NewTarget & Number & ")")
  Number = Number + 1
 Loop
 FSO.CreateFolder(NewTarget & Number & ")")
End If

Set ws = WScript.CreateObject("WScript.Shell")
ws.SendKeys "^R"

On Error Goto 0
'************* Конец ************************************************
