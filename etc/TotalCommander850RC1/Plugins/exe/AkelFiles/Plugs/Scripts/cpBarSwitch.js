// cpBarSwitch.js
// http://tc-image.3dn.ru/forum/9-586-2645-16-1342880326
// http://akelpad.sourceforge.net/forum/viewtopic.php?p=18460#18460
// Version: 1.5 (2012-06-20)
// Author: Visitor7
// Cycling between specified menubar, toolbar, statusbar and tabbar states.
// Переключение между указанным меню, панели инструментов, строки состояния и TabBar
// Usage: Call("Scripts::Main", 1, "cpBarSwitch.js", "m s1 [s2 s3 s4 ...]")
//    m - bar`s mask, integer 1...15:
//      0x0001 (1)  -  process menubar
//      0x0010 (2)  -  process toolbar      (toolbar.dll plugin required)
//      0x0100 (4)  -  process tabbar
//      0x1000 (8)  -  process statusbar
//    s1 [s2 s3 s4 ...] - states, integer 0...31, should not be repeated:
//      0x00001 (1)  -  menubar state       (0 - off, 1 - on)
//      0x00010 (2)  -  toolbar state         (0 - off, 1 - on)
//      0x00100 (4)  -  tabbar state         (0 - off, 1 - on)
//      0x01000 (8)  -  statusbar state      (0 - off, 1 - on)
//      0x10000 (16)  - tabbar position       (0 - top, 1 - bottom)
// Examples:
//    Call("Scripts::Main", 1, "cpBarSwitch.js", "4 4 0")
//       On/Off tabbar(top).
//    Call("Scripts::Main", 1, "cpBarSwitch.js", "1 1 0")
//       On/Off menubar.
//    Call("Scripts::Main", 1, "cpBarSwitch.js", "14 14 0")
//       On/Off tabbar(top), toolbar and statusbar.
//    Call("Scripts::Main", 1, "cpBarSwitch.js", "4 4 20 0")
//       1. Turn on tabbar(top); 2. switches tabbar to bottom; 3. turn off tabbar... then starts from the beginning.
//    Call("Scripts::Main", 1, "cpBarSwitch.js", "11 1 9 10")
//       1. Turn off toolbar and statusbar, turn on menubar; 2. turn on statusbar; 3. turn on toolbar and turn off menubar... then starts from the beginning.
//  -"Вкл./Выкл. отображение вкладок" Call("Scripts::Main", 1, "cpBarSwitch.js", "4 4 0")
//  -"Вкл./Выкл. отображение меню" Call("Scripts::Main", 1, "cpBarSwitch.js", "1 1 0")
//  -"Вкладки Вверху/Внизу" Call("Scripts::Main", 1, "cpBarSwitch.js", "4 4 20")

/////// Variables                  ///////////////////////////////
var hMainWnd = AkelPad.GetMainWnd();
var aMod = !AkelPad.IsMDI();
var bMask;
var xState = 0;
var nState;
var i;

if (hMainWnd && IsArgIntRng(0, 1, 15) && IsArgIntRng(1, 0, 31))
{
   bMask = WScript.Arguments(0);
   if (aMod)
      bMask &= ~4;   //ignore tabbar
   /////// Calculation of the current state      ///////////////////////////////
   if (bMask & 4)                           ///tabbar
   {
      var tState = AkelPad.SendMessage(hMainWnd, 1222 /*AKD_GETMAININFO*/, 157 /*MI_TABOPTIONSMDI*/, 0);
      if (!(tState & 1))
      {                          //  if (tState & 1) TAB_VIEW_NONE
         xState |= 4;           //  if (tState & 2) TAB_VIEW_TOP
         if (tState & 4)         //  if (tState & 4) TAB_VIEW_BOTTOM
            xState |= 16;
      }
   }
   if (bMask & 8)                            ///statusbar
   {
      var sState = AkelPad.SendMessage(hMainWnd, 1222 /*AKD_GETMAININFO*/, 142 /*MI_STATUSBAR*/, 0);
      if (sState)
         xState |= 8;
   }
   if (bMask & 2)                            ///toolbar
   {
      var ptState = AkelPad.IsPluginRunning("ToolBar::Main");
      if (ptState)
         xState |= 2;
   }
   if (bMask & 1)                           ///menubar
   {
      var pmState = AkelPad.IsPluginRunning("ContextMenu::Main");
      var hMainMenu = AkelPad.SendMessage(hMainWnd, 1222 /*AKD_GETMAININFO*/, 21 /*MI_MENUMAIN*/, 0);
      var oSys = AkelPad.SystemFunction();
      var mState = oSys.Call("User32::GetMenu", hMainWnd);
      if (mState)
         xState |= 1;
   }

   ///////Search for the next state in list         ///////////////////////////////
   for (i=1; i < WScript.Arguments.Length; ++i)
   {
      if ((WScript.Arguments(i) == xState) || ((aMod) && ((WScript.Arguments(i) & (~20)) == xState)))
         break;
   }
   if (++i >= WScript.Arguments.Length) i=1;
   if (IsArgIntRng(i, 0, 31))
   {
      nState = (WScript.Arguments(i) & (((bMask&4) << 2) | bMask));

      ///////Set the next state               ///////////////////////////////
      if (((nState & 4) != (xState & 4)) || ((nState & 16) != (xState & 16)))     ///tabbar
      {
         if (!(nState & 4))
            AkelPad.Command(4303 /*IDM_WINDOW_TABVIEW_NONE*/);
         else if (nState & 16)
            AkelPad.Command(4302 /*IDM_WINDOW_TABVIEW_BOTTOM*/);
         else
            AkelPad.Command(4301 /*IDM_WINDOW_TABVIEW_TOP*/);
      }
      if ((nState & 8) != (xState & 8))                         ///statusbar
         AkelPad.Command(4211 /*IDM_VIEW_SHOW_STATUSBAR*/);
      if ((nState & 2) != (xState & 2))                         ///toolbar
         AkelPad.Call("ToolBar::Main");
      if ((nState & 1) != (xState & 1))                         ///menubar
      {
         if (!mState)
         {
            oSys.Call("User32::SetMenu", hMainWnd, hMainMenu);
            if (pmState)   // Menu items of contextMenu.dll does not appear when turn on the menu, restart required.
            {
               AkelPad.Call("ContextMenu::Main", 10);
               // WScript.Sleep(50); // If not restarted, try to uncomment the pause.
               AkelPad.Call("ContextMenu::Main", 10);
            }
         }
         else
            oSys.Call("User32::SetMenu", hMainWnd, 0);
      }
   }
}

function IsArgIntRng(aNum, aFrom, aTo)
{
   if (WScript.Arguments.length > aNum)
   {
      var aValue = +WScript.Arguments(aNum);
      if ((Math.floor(aValue) == aValue) && (aValue >= aFrom) && (aValue <= aTo))
         return true;
   }
   return false;
}