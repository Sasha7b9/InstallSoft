' SettingContextMenuFont.vbs
'========================   ��������   =====================================
' �������� ��������� ���� (ContextMenu) � ������ ������� 
'=======================   ���������  =====================================
' 1-� ��������: ����� ����������� ���� 
'    0 - ����������� ����
'    1 - ������� ����
'    2 - ���� ��������������
'    3 - ���� �������
'    4 - ���� ������
' 2-� ��������: ������, ������� ����� � �������� � ������������� ���� (�� ��������� "")
'========================   �������   =====================================
' -"�������� &����..." Call("Scripts::Main", 1, "SettingContextMenuFont.vbs", `"1" "�������"`) Icon("%a\AkelPadImage.dll",93)
' �����:             ������ ������
' ������:          1.1 (15.09.2011 - 01.11.2011)
' Mail:                 Averin-And@yandex.ru
' Site:                  http://tc-image.3dn.ru/forum/9-294-1187-16-1333798315
'=======================   ����������   ====================================
' - ������������ ������ PlugContextMenuAkelFont.js http://tc-image.3dn.ru/forum/9-294-928-16-1333094169
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