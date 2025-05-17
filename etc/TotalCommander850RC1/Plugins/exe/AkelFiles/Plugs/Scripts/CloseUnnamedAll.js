/// CloseUnnamedAll.js
// http://tc-image.3dn.ru/forum/9-254-839-16-1332920186
// http://akelpad.sourceforge.net/forum/viewtopic.php?p=3370#3370
//
//// Закрыть все указанные MDI документы.
//// Close all unnamed or unexisted MDI documents.
//
// Arguments:
// -CloseUnnamed=false   -Закрыть документы без имени (по умочанию = true).
// -CloseUnexisted=true  -Закрыть документы, если файлы были удалены (по умочанию = false).
//
// Example:
// -"Close only unexisted" Call("Scripts::Main", 1, "CloseUnnamedAll.js", `-CloseUnnamed=false -CloseUnexisted=true`)
 // Version v1.4 16.11.2011 + 26.04.2012
// Author: Instructor

//Arguments
var bCloseUnnamed=AkelPad.GetArgValue("CloseUnnamed", true);
var bCloseUnexisted=AkelPad.GetArgValue("CloseUnexisted", false);

//Variables
var hMainWnd=AkelPad.GetMainWnd();
var oSys=AkelPad.SystemFunction();
var lpFrameInit=0;
var lpFrameCur=0;
var bFrameClose=false;
var pFile;
var dwState=0;

if (AkelPad.IsMDI())
{
  var hMainWnd = AkelPad.GetMainWnd();
  SetRedraw(hMainWnd, false); // Добавил для себя Аверин Андрей (26.04.2012)

  //Turn off watch file
  if (hMenuMain=AkelPad.SendMessage(hMainWnd, 1222 /*AKD_GETMAININFO*/, 21 /*MI_MENUMAIN*/, 0))
  {
    dwState=oSys.Call("user32::GetMenuState", hMenuMain, 4253 /*IDM_OPTIONS_WATCHFILE*/, 0 /*MF_BYCOMMAND*/);
    if (dwState & 0x8 /*MF_CHECKED*/)
      AkelPad.Command(4253 /*IDM_OPTIONS_WATCHFILE*/);
  }

  for (;;)
  {
    if (!lpFrameCur) lpFrameCur=AkelPad.SendMessage(hMainWnd, 1288 /*AKD_FRAMEFIND*/, 1 /*FWF_CURRENT*/, 0);
    if (!lpFrameInit) lpFrameInit=lpFrameCur;

    //Is frame must be closed
    pFile=AkelPad.GetEditFile(0);
    if ((bCloseUnnamed && !pFile) ||
        (bCloseUnexisted && oSys.Call("kernel32::GetFileAttributes" + _TCHAR, pFile) == -1))
    {
      bFrameClose=true;
    }

    if (bFrameClose)
    {
      //Close MDI frame
      if (AkelPad.GetEditModified(0))
        AkelPad.SendMessage(hMainWnd, 1229 /*AKD_SETMODIFY*/, 0, false);
      if (!AkelPad.Command(4318 /*IDM_WINDOW_FRAMECLOSE*/))
        break;
      if (lpFrameInit == lpFrameCur)
        lpFrameInit=0;
      lpFrameCur=0;
      bFrameClose=false;
    }
    else
    {
      //Next MDI frame
      lpFrameCur=AkelPad.Command(4316 /*IDM_WINDOW_FRAMENEXT*/);
      if (!lpFrameCur || lpFrameCur == lpFrameInit)
        break;
    }
  }

  //Turn on watch file
  if (dwState & 0x8 /*MF_CHECKED*/)
    AkelPad.Command(4253 /*IDM_OPTIONS_WATCHFILE*/);

    SetRedraw(hMainWnd, true);
}


function SetRedraw(hWnd, bRedraw)
{
   var oSys = AkelPad.SystemFunction();
   AkelPad.SendMessage(hWnd, 11 /*WM_SETREDRAW*/, bRedraw, 0);
   bRedraw && oSys.Call("user32::InvalidateRect", hWnd, 0, true);
}