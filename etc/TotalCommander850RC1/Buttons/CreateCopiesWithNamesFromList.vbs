'======================================================
' �������� � ����� � ������ ��� �������� ��� ����� � ������� �� �����-������
' ���������: "%N" "<���� � ����� �� ������� ���>"
'
' TOTALCMD#BAR#DATA
' %COMMANDER_PATH%\Buttons\CreateCopiesWithNamesFromList.vbs
' ?"%N" "%%COMMANDER_PATH%%\Buttons\List\%N.txt"
' WcmIcons.dll,94
' �������� ����� ����� � ������� �� �����-������
'======================================================
 With CreateObject("WScript.Shell") 
 L=.ExpandEnvironmentStrings(WScript.Arguments(1)) 
 D=.CurrentDirectory 
 End With 
 With CreateObject("Scripting.FileSystemObject") 
 List=.OpenTextFile(L, 1).ReadAll 
   For Each F In Split(List, vbNewLine) 
     If F>vbNullString Then .GetFile(WScript.Arguments(0)).Copy D _ 
     & "\" & F & "." & .GetExtensionName(WScript.Arguments(0)) 
   Next 
 End With