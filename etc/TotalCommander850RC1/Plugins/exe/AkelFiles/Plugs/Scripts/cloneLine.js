/// cloneLine.js
/// http://tc-image.3dn.ru/forum/9-356-1108-16-1333563384
///Дублицирование строк(и)
// Version: 1.2
// Author: Instructor
var hWndEdit = AkelPad.GetEditWnd();
if (hWndEdit == 0) WScript.Quit(); // Добавил для себя Аверин Андрей (30.04.2012)
var oSys = AkelPad.SystemFunction();

var ss = AkelPad.GetSelStart();
var se = AkelPad.GetSelEnd();

var line1Start = GetOffset(hWndEdit, 18 /*AEGI_WRAPLINEBEGIN*/, ss);
var line2End   = GetOffset(hWndEdit, 19 /*AEGI_WRAPLINEEND*/,   se);

setRedraw(hWndEdit, false);
AkelPad.SetSel(line1Start, line2End);
var pText = AkelPad.GetSelText();
AkelPad.ReplaceSel(pText + "\r" + pText);
var selAdd = pText.length + 1;
AkelPad.SetSel(ss + selAdd, se + selAdd);
setRedraw(hWndEdit, true);
if (AkelPad.GetEditFile(0))
  {
    AkelPad.Command(4105); // Добавил для себя Аверин Андрей (04.04.2012)
  }

// GetOffset.js -- http://akelpad.sourceforge.net/forum/viewtopic.php?p=11382#11382
function GetOffset(hWndEdit, nType /*AEGI_*/, nOffset)
{
  var lpIndex;

  if (lpIndex=AkelPad.MemAlloc(_X64?24:12 /*sizeof(AECHARINDEX)*/))
  {
    if (nOffset != -1)
      AkelPad.SendMessage(hWndEdit, 3137 /*AEM_RICHOFFSETTOINDEX*/, nOffset, lpIndex);
    AkelPad.SendMessage(hWndEdit, 3130 /*AEM_GETINDEX*/, nType, lpIndex);
    nOffset=AkelPad.SendMessage(hWndEdit, 3136 /*AEM_INDEXTORICHOFFSET*/, 0, lpIndex);
    AkelPad.MemFree(lpIndex);
  }
  return nOffset;
}
function setRedraw(hWnd, bRedraw) {
   AkelPad.SendMessage(hWnd, 11 /*WM_SETREDRAW*/, bRedraw, 0);
   bRedraw && oSys.Call("user32::InvalidateRect", hWnd, 0, true);
}