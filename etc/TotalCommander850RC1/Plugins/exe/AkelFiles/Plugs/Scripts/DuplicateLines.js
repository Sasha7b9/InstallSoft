/// DuplicateLines.js
// http://tc-image.3dn.ru/forum/9-257-847-16-1332957790
// http://akelpad.sourceforge.net/forum/viewtopic.php?p=6504#6504
// Version v1.0
// Author: Instructor
// �������������� ���������� �����
//
//// Duplicate selected lines.

var hMainWnd=AkelPad.GetMainWnd();
var pSelText;
var pLinesArray;
var pResultArray=new Array();
var nLinesIndex;
var nResultIndex=0;

if (hMainWnd)
{
  if (pSelText=AkelPad.GetSelText())
  {
    if (pLinesArray=pSelText.split("\r"))
    {
      for (nLinesIndex=0; nLinesIndex < pLinesArray.length; ++nLinesIndex)
      {
        pResultArray[nResultIndex++]=pLinesArray[nLinesIndex];
        pResultArray[nResultIndex++]=pLinesArray[nLinesIndex];
      }
      pSelText=pResultArray.join("\r");
      AkelPad.ReplaceSel(pSelText, true);
    }
  }
}
