'********************************************************************
' Имя: DuplicateFileTree.vbs
' Язык: VBScript
' Модификация: Шаповалов Арсений aka ApceH Hypocrite 
' .....и небольшое дополнение от DimitarSerg
' Описание: Воссоздаёт в указанной папке назначения структуру файлов и папок указанной папки.
'           Файлы создаются пустыми.
'********************************************************************

Option Explicit
Dim FSO,WSH,List,Target,NewTarget
Dim Selected

Sub DuplicateFolder (Folder, TargetFolder)
 Dim SubFolder, F, NewF
 For Each SubFolder in Folder.SubFolders
  NewF = TargetFolder & SubFolder.Name
  If Not FSO.FolderExists(NewF) Then
   FSO.CreateFolder(NewF)
  End If
  DuplicateFolder SubFolder, NewF & "\"
 Next
 For Each F in Folder.Files 
  NewTarget = TargetFolder & FSO.GetFile(F).Name
  FSO.CreateTextFile NewTarget
 Next
End Sub

On Error Resume Next 

If (WScript.Arguments.Count <> 2) Then
 MsgBox "Скрипт предназначен для запуска с панели Total Commander!" & vbCrlf & vbCrlf & "Скрипт ожидает ровно 2 параметра:" & vbCrlf & "• список файлов (обычно %L)," & vbCrlf & "• папка назначения (обычно ""%T"")" & vbCrlf & vbCrlf & "Внимание!" & vbCrlf & "• Нужно заключать в кавычки параметры, содержащие пробелы.", vbOKOnly+vbCritical, "Неправильное использование" 
 WScript.Quit
End If

Set FSO  = CreateObject("Scripting.FileSystemObject")
Set WSH  = CreateObject("WScript.Shell")
Set List = FSO.OpenTextFile(WScript.Arguments(0), 1)
Target   = WScript.Arguments(1)
Do While Not List.AtEndOfStream
 Selected = List.ReadLine 
 If FSO.FileExists(Selected) Then 
  NewTarget = Target & FSO.GetFile(Selected).Name
  FSO.CreateTextFile NewTarget
 End If
 If FSO.FolderExists(Selected) Then 
  NewTarget = Target & FSO.GetFolder(Selected).Name
  If Not FSO.FolderExists(NewTarget) Then 
   FSO.CreateFolder(NewTarget)
 End If
 DuplicateFolder FSO.GetFolder(Selected), NewTarget & "\"
if (List.AtEndOfStream) Then
 MsgBox "Скрипт успешно завершил свою работу!" & vbCrlf & "В противоположной панели создана структура пустых каталогов с файлами" , vbOKOnly+vbInformation, "Операция завершена"
End If
End If
Loop

On Error Goto 0
'************* Конец ************************************************
