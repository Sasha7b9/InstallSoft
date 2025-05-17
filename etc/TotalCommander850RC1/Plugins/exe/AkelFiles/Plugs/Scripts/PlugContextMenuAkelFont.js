/// PlugContextMenuAkelFont.js
// http://tc-image.3dn.ru/forum/9-294-928-16-1333094169
// Run ContextMenu plugin with font, that is set in AkelPad or modified
// Скрипт увеличивает шрифта в окне настройки ContextMenu плагина 
// Call("Scripts::Main", 1, "PlugContextMenuAkelFont.js") - set font from AkelPad 
// or 
// Call("Scripts::Main", 1, "PlugContextMenuAkelFont.js", 'pFont nStyle nSize') - set modified font 
// Arguments (as in AkelPad.Font() method): 
//  pFont 
//    Font face, for example, "Courier". Unchanged, if "". 
//  nStyle 
//    0 ignored. 
//    1 normal. 
//    2 bold. 
//    3 italic. 
//    4 bold italic. 
//  nSize 
//    Font size in pixels. Unchanged, if 0. 
// Example: 
// Call("Scripts::Main", 1, "PlugContextMenuAkelFont.js", '"Lucida Console" 3 14 1')
// Добавлен 4-й аргумент вызов № меню 
//  (c) KDJ & Аверин Андрей
// version: 1.1 (11.09.2011 - 01.11.2011)

var oSys = AkelPad.SystemFunction(); 
var hMainWnd = AkelPad.GetMainWnd(); 
var sPlugFunc = "ContextMenu::Main"; 
var sPlugWndName = "ContextMenu "; 
var nStopTime = new Date().getTime() + 1000; 
var hPlugWnd; 
var hCtrlWnd; 
var lpLOGFONT; 
var sFontName; 
var nFontStyle; 
var nFontSize; 
var hDC; 
var nDevCap; 
var nHeight; 
var nWeight; 
var bItalic; 
var hFont; 
var nMenu = 1
if (AkelPad.GetLangId(1 /*LANGID_PRIMARY*/) == 0x19 /*LANG_RUSSIAN*/) 
  sPlugWndName += "плагин"; 
else 
  sPlugWndName += "plugin"; 

if (WScript.Arguments.length >= 4)
  nMenu = Number(WScript.Arguments(3));
  
AkelPad.Call(sPlugFunc, 1, nMenu); 

while(! (hPlugWnd = oSys.Call("user32::FindWindow" + _TCHAR, 0, sPlugWndName)) || 
      ! (hCtrlWnd = oSys.Call("user32::FindWindowEx" + _TCHAR, hPlugWnd, 0, "RichEdit20" + _TCHAR, 0))) 
{ 
  if (new Date().getTime() > nStopTime) 
    WScript.Quit(); 

  WScript.Sleep(5); 
} 

lpLOGFONT = AkelPad.MemAlloc(28 + 32 * _TSIZE); //sizeof(LOGFONT) 
AkelPad.SendMessage(hMainWnd, 1231 /*AKD_GETFONT*/, 0, lpLOGFONT); 

if (WScript.Arguments.length >= 1) 
{ 
  if (sFontName = WScript.Arguments(0)) 
    AkelPad.MemCopy(lpLOGFONT + 28, sFontName, _TSTR); //lfFaceName 
} 

if ((WScript.Arguments.length >= 2) && isFinite(WScript.Arguments(1))) 
{ 
  nFontStyle = Number(WScript.Arguments(1)); 
  if ((nFontStyle > 0) && (nFontStyle < 5)) 
  { 
    nWeight = 400; 
    bItalic = 0; 
    if (nFontStyle == 2) 
      nWeight = 700; 
    else if (nFontStyle == 3) 
      bItalic = 1; 
    else if (nFontStyle == 4) 
    { 
      nWeight = 700; 
      bItalic = 1; 
    } 
    AkelPad.MemCopy(lpLOGFONT + 16, nWeight, 3 /*DT_DWORD*/); //lfWeight 
    AkelPad.MemCopy(lpLOGFONT + 20, bItalic, 5 /*DT_BYTE*/);  //lfItalic 
  } 
} 

if ((WScript.Arguments.length >= 3) && isFinite(WScript.Arguments(2))) 
{ 
  nFontSize = Number(WScript.Arguments(2)); 
  if (nFontSize > 0) 
  { 
    hDC     = oSys.Call("user32::GetDC", hCtrlWnd); 
    nDevCap = oSys.Call("gdi32::GetDeviceCaps" , hDC, 90 /*LOGPIXELSY*/); 
    nHeight = -oSys.Call("kernel32::MulDiv", nFontSize, nDevCap, 72); 
    oSys.Call("user32::ReleaseDC", hCtrlWnd, hDC); 
    AkelPad.MemCopy(lpLOGFONT, nHeight, 3 /*DT_DWORD*/); //lfHeight 
  } 
} 

hFont = oSys.Call("gdi32::CreateFontIndirect" + _TCHAR, lpLOGFONT); 
AkelPad.MemFree(lpLOGFONT); 

AkelPad.SendMessage(hCtrlWnd, 48 /*WM_SETFONT*/, hFont, true);