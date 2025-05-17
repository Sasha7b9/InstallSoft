/// NumberCount.js
//// http://tc-image.3dn.ru/forum/9-321-1038-16-1333382768
//// Диалог нумерации строк
//// Руссифицировал Аверин Андрей 02.04.2012
// (c) cnnnc
// version: 0.6 (17.04.2010 - 09.07.2011)
var hMainWnd=AkelPad.GetMainWnd();

if (!hMainWnd) WScript.Quit();

var oSys        =AkelPad.SystemFunction();
var pScriptName =WScript.ScriptName;
var bNum=bRand=false;
var sStr="$1",sNum;
var nFirst=nStep=nWidth=1,sPad="0";
var ArgLen=WScript.Arguments.length;

// Without GUI
if (ArgLen>0)
{
  sStr=WScript.Arguments(0);
  if (ArgLen>1)
  {
    sNum=WScript.Arguments(1).toUpperCase();

    if (sNum=="N" || sNum=="R")
    {
      if (ArgLen>2)
      {
        nFirst=Number(WScript.Arguments(2));
        if (isNaN(nFirst)) nFirst=1;
      }
      if (ArgLen>3)
      {
        nStep=Number(WScript.Arguments(3));
        if (isNaN(nStep)) nStep=1;
      }
      if (ArgLen>4)
      {
        nWidth=parseInt(WScript.Arguments(4));
        if (isNaN(nWidth)) nWidth=1;
      }
      if (ArgLen>5)
      {
        sPad=WScript.Arguments(5);
      }

      bNum=true;
      if (sNum=="R") bRand=true;
    }
  }

  NumberCount();
  WScript.Quit();
}

// With GUI
var hInstanceDLL=AkelPad.GetInstanceDll();
var pClassName  ="AkelPad::Scripts::"+pScriptName+"::"+oSys.Call("kernel32::GetCurrentProcessId");

var hWndDialog;
var lpBuffer;
var nStrings=10;
var lpStrings=[];
var oSet=AkelPad.ScriptSettings();

if (oSet.Begin(WScript.ScriptBaseName, 0x1 /*POB_READ*/))
{
  //Read settings
  bNum  =oSet.Read("Num"  , 1 /*PO_DWORD*/ );
  bRand =oSet.Read("Rand" , 1 /*PO_DWORD*/ );
  nFirst=oSet.Read("First", 3 /*PO_STRING*/);
  nStep =oSet.Read("Step" , 3 /*PO_STRING*/);
  nWidth=oSet.Read("Width", 1 /*PO_DWORD*/ );
  sPad  =oSet.Read("Pad"  , 3 /*PO_STRING*/);

  //String
  for (i=0; i<nStrings; ++i)
  {
    lpStrings[i]=oSet.Read("String"+i, 3 /*PO_STRING*/);
    if (typeof lpStrings[i]=="undefined") break;
  }

  if (typeof lpStrings[0]!="undefined") sStr=lpStrings[0];

  oSet.End();
}

if (typeof lpStrings[0]=="undefined") lpStrings[0]=sStr;

var sTxtStr    ="Строка";
var sTxtSyntax ="Синтаксис:\n \\\\ - Обратный слэш\n \\r  - Перевод строки\n \\t  - Табуляция\n \\N - Нумерация\n $1  - Первоначальная строка";
var sTxtNum    ="Нумерация";
var sTxtRand   ="Случайная";
var sTxtFirst  ="Начать с:";
var sTxtStep   ="Шаг:";
var sTxtEnd    ="End";
var sTxtWidth  ="К-во цифр:";
var sTxtPad    ="Заполнение символом(и):";
var sTxtSeconds="Секунды";
var sTxtOK     ="OK";
var sTxtCancel ="Отмена";

var fso      =new ActiveXObject("Scripting.FileSystemObject");
var pLangFile=WScript.ScriptFullName.substring(0, WScript.ScriptFullName.lastIndexOf("."))+"_"+AkelPad.GetLangId().toString()+".lng";
var nError;

if (fso.FileExists(pLangFile))
{
  try
  {
    eval(AkelPad.ReadFile(pLangFile));
  }
  catch (nError)
  {
  }
}

var aWnd            =[];
var IDC_CBB_STR     =1000;
var IDC_STATIC_STR  =1001;
var IDC_SYNTEX      =1002;
var IDC_NUM         =1003;
var IDC_RAND        =1004;
var IDC_STATIC_FIRST=1005;
var IDC_EDT_FIRST   =1006;
var IDC_STATIC_STEP =1007;
var IDC_EDT_STEP    =1008;
var IDC_STATIC_WIDTH=1009;
var IDC_EDT_WIDTH   =1010;
var IDC_STATIC_PAD  =1011;
var IDC_EDT_PAD     =1012;
var IDC_OK          =1013;
var IDC_CANCEL      =1014;

var WNDTYPE =0;
var WND     =1;
var WNDEXSTY=2;
var WNDSTY  =3;
var WNDX    =4;
var WNDY    =5;
var WNDW    =6;
var WNDH    =7;
var WNDTXT  =8;
//0x50000000 - WS_VISIBLE|WS_CHILD
//0x50010000 - WS_VISIBLE|WS_CHILD|WS_TABSTOP
//0x50010003 - WS_VISIBLE|WS_CHILD|WS_TABSTOP|BS_AUTOCHECKBOX
//0x50210042 - WS_VISIBLE|WS_CHILD|WS_TABSTOP|WS_VSCROLL|CBS_DROPDOWN|CBS_AUTOHSCROLL
//0x58010000 - WS_VISIBLE|WS_CHILD|WS_DISABLED|WS_TABSTOP|BS_PUSHBUTTON
//0x58010003 - WS_VISIBLE|WS_CHILD|WS_DISABLED|WS_TABSTOP|BS_AUTOCHECKBOX
//0x58010080 - WS_VISIBLE|WS_CHILD|WS_DISABLED|WS_TABSTOP|ES_AUTOHSCROLL
//Windows                WNDTYPE, WND, WNDEXSTY,     WNDSTY,WNDX,WNDY,WNDW,WNDH,           WNDTXT
aWnd[IDC_CBB_STR     ]=["COMBOBOX", 0,        0, 0x50210042,  95,   5, 228, 160,             sStr];
aWnd[IDC_STATIC_STR  ]=["STATIC",   0,        0, 0x50000000,   5,   8,  85,  20,          sTxtStr];
aWnd[IDC_SYNTEX      ]=["BUTTON",   0,        0, 0x50010000, 303,  30,  20,  20,            " ? "];
aWnd[IDC_NUM         ]=["BUTTON",   0,        0, 0x50010003,   5,  33,  85,  20,          sTxtNum];
aWnd[IDC_RAND        ]=["BUTTON",   0,        0, 0x58010003,  95,  33,  85,  20,         sTxtRand];
aWnd[IDC_STATIC_FIRST]=["STATIC",   0,        0, 0x50000000,   5,  58,  85,  20,        sTxtFirst];
aWnd[IDC_EDT_FIRST   ]=[  "EDIT",   0,    0x200, 0x58010080,  95,  55, 100,  20,nFirst.toString()];
aWnd[IDC_STATIC_STEP ]=["STATIC",   0,        0, 0x50000000,   5,  80,  85,  20,         sTxtStep];
aWnd[IDC_EDT_STEP    ]=[  "EDIT",   0,    0x200, 0x58010080,  95,  80, 100,  20, nStep.toString()];
aWnd[IDC_STATIC_WIDTH]=["STATIC",   0,        0, 0x50000000,   5, 103,  85,  20,        sTxtWidth];
aWnd[IDC_EDT_WIDTH   ]=[  "EDIT",   0,    0x200, 0x58010080,  95, 105, 100,  20,nWidth.toString()];
aWnd[IDC_STATIC_PAD  ]=["STATIC",   0,        0, 0x50000000,   5, 123,  85,  30,          sTxtPad];
aWnd[IDC_EDT_PAD     ]=[  "EDIT",   0,    0x200, 0x58010080,  95, 130,  50,  20,             sPad];
aWnd[IDC_OK          ]=["BUTTON",   0,        0, 0x58010000, 263, 105,  60,  20,           sTxtOK];
aWnd[IDC_CANCEL      ]=["BUTTON",   0,        0, 0x50010000, 263, 130,  60,  20,       sTxtCancel];

if (AkelPad.WindowRegisterClass(pClassName))
{
  if (lpBuffer=AkelPad.MemAlloc(256 * _TSIZE))
  {
    //Create dialog
    hWndDialog=oSys.Call("user32::CreateWindowEx"+_TCHAR,
      0,               //dwExStyle
      pClassName,      //lpClassName
      0,               //lpWindowName
      0x90CA0000,      //WS_VISIBLE|WS_POPUP|WS_CAPTION|WS_SYSMENU|WS_MINIMIZEBOX
      0,               //x
      0,               //y
      333,             //nWidth
      180,             //nHeight
      hMainWnd,        //hWndParent
      0,               //ID
      hInstanceDLL,    //hInstance
      DialogCallback); //Script function callback. To use it class must be registered by WindowRegisterClass.

    if (hWndDialog)
    {
      //Allow other scripts running
      AkelPad.ScriptNoMutex();
      //Message loop
      AkelPad.WindowGetMessage();
    }
    AkelPad.MemFree(lpBuffer);
  }
  AkelPad.WindowUnregisterClass(pClassName);
}
else if (hWndDialog=oSys.Call("user32::FindWindowEx"+_TCHAR, 0, 0, pClassName, 0))
{
  if (oSys.Call("user32::IsIconic", hWndDialog)) oSys.Call("user32::ShowWindow", hWndDialog, 9 /*SW_RESTORE*/);
  AkelPad.SendMessage(hWndDialog, 7 /*WM_SETFOCUS*/, 0, 0);
}


function DialogCallback(hWnd, uMsg, wParam, lParam)
{
  if (uMsg==1)  //WM_CREATE
  {
    var hGuiFont=oSys.Call("gdi32::GetStockObject", 17 /*DEFAULT_GUI_FONT*/);

    //Dialog caption
    oSys.Call("user32::SetWindowText"+_TCHAR, hWnd, "Нумерация строк");

    //Create window
    for (i=1000; i<aWnd.length; ++i)
    {
      aWnd[i][WND]=oSys.Call("user32::CreateWindowEx"+_TCHAR,
        aWnd[i][WNDEXSTY], //dwExStyle
        aWnd[i][WNDTYPE],  //lpClassName
        0,                 //lpWindowName
        aWnd[i][WNDSTY],   //dwStyle
        aWnd[i][WNDX],     //x
        aWnd[i][WNDY],     //y
        aWnd[i][WNDW],     //nWidth
        aWnd[i][WNDH],     //nHeight
        hWnd,              //hWndParent
        i,                 //ID
        hInstanceDLL,      //hInstance
        0);                //lpParam
      //Set font and text
      SetWindowFontAndText(aWnd[i][WND], hGuiFont, aWnd[i][WNDTXT]);
    }

    //Fill combobox
    for (i=0; i<nStrings && typeof lpStrings[i]!="undefined"; ++i)
    {
      AkelPad.MemCopy(lpBuffer, lpStrings[i], _TSTR);
      AkelPad.SendMessage(aWnd[IDC_CBB_STR][WND], 0x143 /*CB_ADDSTRING*/, 0, lpBuffer);
    }
    AkelPad.SendMessage(aWnd[IDC_CBB_STR][WND], 0x14E /*CB_SETCURSEL*/, 0, 0);

    //Checks
    if (bNum)
    {
      AkelPad.SendMessage(aWnd[IDC_NUM][WND], 241 /*BM_SETCHECK*/, 1 /*BST_CHECKED*/, 0);
      EnableNumWin(bNum);
    }

    if (bRand)
    {
      AkelPad.SendMessage(aWnd[IDC_RAND][WND], 241 /*BM_SETCHECK*/, 1 /*BST_CHECKED*/, 0);
      oSys.Call("user32::SetWindowText"+_TCHAR, aWnd[IDC_STATIC_STEP][WND], sTxtEnd);
    }

    //Center dialog
    CenterWindow(hMainWnd, hWnd);
  }
  else if (uMsg==7)  //WM_SETFOCUS
  {
    oSys.Call("user32::SetFocus", aWnd[IDC_CBB_STR][WND]);
  }
  else if (uMsg==256)  //WM_KEYDOWN
  {
    if (wParam==27)    //VK_ESCAPE
    {
      //Escape key pushes Cancel button
      oSys.Call("user32::PostMessage"+_TCHAR, hWnd, 273 /*WM_COMMAND*/, IDC_CANCEL, 0);
    }
    else if (wParam==13)  //VK_RETURN
    {
      if (oSys.Call("user32::IsWindowEnabled", aWnd[IDC_OK][WND]))
      {
        //Return key pushes OK button
        oSys.Call("user32::PostMessage"+_TCHAR, hWnd, 273 /*WM_COMMAND*/, IDC_OK, 0);
      }
    }
  }
  else if (uMsg==273)  //WM_COMMAND
  {
    if ((wParam & 0xffff)==IDC_NUM       ||
        (wParam & 0xffff)==IDC_CBB_STR   ||
        (wParam & 0xffff)==IDC_EDT_FIRST ||
        (wParam & 0xffff)==IDC_EDT_STEP  ||
        (wParam & 0xffff)==IDC_EDT_WIDTH)
    {
      if ((wParam & 0xffff)==IDC_NUM)
      {
        bNum=AkelPad.SendMessage(aWnd[IDC_NUM][WND], 240 /*BM_GETCHECK*/, 0, 0);
        EnableNumWin(bNum);
      }

      if (bNum)
      {
        if (DisableBtnOK(aWnd[IDC_EDT_FIRST][WND])) return;
        if (DisableBtnOK(aWnd[IDC_EDT_STEP][WND]))  return;
        if (DisableBtnOK(aWnd[IDC_EDT_WIDTH][WND])) return;
        oSys.Call("user32::EnableWindow", aWnd[IDC_OK][WND], true);
      }
      else
      {
        oSys.Call("user32::EnableWindow", aWnd[IDC_OK][WND], (oSys.Call("user32::GetWindowTextLength"+_TCHAR, aWnd[IDC_CBB_STR][WND])) ? true : false);
      }
    }
    else if ((wParam & 0xffff)==IDC_RAND)
    {
      bRand=AkelPad.SendMessage(aWnd[IDC_RAND][WND], 240 /*BM_GETCHECK*/, 0, 0);
      oSys.Call("user32::SetWindowText"+_TCHAR, aWnd[IDC_STATIC_STEP][WND], (bRand) ? sTxtEnd : sTxtStep);
    }
    else if ((wParam & 0xffff)==IDC_SYNTEX)
    {
      AkelPad.MessageBox(hWnd, sTxtSyntax, "Справка", 0 /*MB_OK*/);
    }
    else if ((wParam & 0xffff)==IDC_OK)
    {
      //String
      sStr=GetWindowText(aWnd[IDC_CBB_STR][WND],sStr);

      if (nStrings)
      {
        for (i=0; i<nStrings && typeof lpStrings[i]!="undefined"; ++i)
        {
          if (lpStrings[i]==sStr)
          {
            AkelPad.SendMessage(aWnd[IDC_CBB_STR][WND], 0x144 /*CB_DELETESTRING*/, i, 0);
            DeleteFromArray(lpStrings, i, 1);
          }
        }

        InsertInArray(lpStrings, sStr, 0);

        if (lpStrings.length>nStrings) DeleteFromArray(lpStrings, -1, 1);

        AkelPad.MemCopy(lpBuffer, sStr, _TSTR);
        AkelPad.SendMessage(aWnd[IDC_CBB_STR][WND], 0x14A /*CB_INSERTSTRING*/, 0, lpBuffer);
        AkelPad.SendMessage(aWnd[IDC_CBB_STR][WND], 0x14E /*CB_SETCURSEL*/, 0, 0);
      }

      if (bNum)
      {
        sPad  =GetWindowText(aWnd[IDC_EDT_PAD][WND]  ,sPad);
        nFirst=GetWindowText(aWnd[IDC_EDT_FIRST][WND],nFirst,"n");
        nStep =GetWindowText(aWnd[IDC_EDT_STEP][WND] ,nStep ,"n");

        nWidth=parseInt(GetWindowText(aWnd[IDC_EDT_WIDTH][WND],nWidth,"n"));
      }

      var d=new Date();
      var t=d.getTime();

      NumberCount();

      var d=new Date();
      t=(d.getTime()-t)/1000;

      if (Math.round(t)>1) AkelPad.MessageBox(hWndDialog, "    "+t.toFixed(3)+" "+sTxtSeconds, pScriptName, 0 /*MB_OK*/);

      oSys.Call("user32::PostMessage"+_TCHAR, hWnd, 16 /*WM_CLOSE*/, 0, 0);
    }
    else if ((wParam & 0xffff)==IDC_CANCEL)
    {
      oSys.Call("user32::PostMessage"+_TCHAR, hWnd, 16 /*WM_CLOSE*/, 0, 0);
    }
  }
  else if (uMsg==16)  //WM_CLOSE
  {
    if (oSet.Begin(WScript.ScriptBaseName, 0x2 /*POB_SAVE*/))
    {
      //Save settings
      oSet.Write("Num"  , 1 /*PO_DWORD*/ ,             bNum);
      oSet.Write("Rand" , 1 /*PO_DWORD*/ ,            bRand);
      oSet.Write("First", 3 /*PO_STRING*/,nFirst.toString());
      oSet.Write("Step" , 3 /*PO_STRING*/, nStep.toString());
      oSet.Write("Width", 1 /*PO_DWORD*/ ,           nWidth);
      oSet.Write("Pad"  , 3 /*PO_STRING*/,             sPad);

      //Save string history
      for (i=0; i<nStrings && typeof lpStrings[i]!="undefined"; ++i)
        oSet.Write("String"+i, 3 /*PO_STRING*/, lpStrings[i]);

      oSet.End();
    }

    //Destroy dialog
    oSys.Call("user32::DestroyWindow", hWnd);
  }
  else if (uMsg==2)  //WM_DESTROY
  {
    //Exit message loop
    oSys.Call("user32::PostQuitMessage", 0);
  }
  return 0;
}

function GetWindowText(hWnd,nID,cType)
{
  oSys.Call("user32::GetWindowText"+_TCHAR, hWnd, lpBuffer, 256);
  var pStrExp=AkelPad.MemRead(lpBuffer, _TSTR);

  if (cType=="n")
  {
    if (pStrExp=="") pStrExp="1";
    nID=Number(pStrExp);
    return nID;
  }
  else return pStrExp;
}

function Pad(sPad,nCurrentNum,pNumText,m)
{
  pNumText=nCurrentNum.toFixed(m);

  if (nCurrentNum<0) pNumText="-"+pNumText.substr(1);

  var nLen=Math.abs(nWidth)-pNumText.length+1;
  var cPadding="";

  while (--nLen>0)
  {
    cPadding+=sPad;
  }

  if (nWidth<0) pNumText += cPadding;
  else pNumText=cPadding+pNumText;

  return pNumText;
}

function EnableNumWin(bNum)
{
  oSys.Call("user32::EnableWindow", aWnd[IDC_RAND][WND]     , bNum);
  oSys.Call("user32::EnableWindow", aWnd[IDC_EDT_FIRST][WND], bNum);
  oSys.Call("user32::EnableWindow", aWnd[IDC_EDT_STEP][WND] , bNum);
  oSys.Call("user32::EnableWindow", aWnd[IDC_EDT_WIDTH][WND], bNum);
  oSys.Call("user32::EnableWindow", aWnd[IDC_EDT_PAD][WND]  , bNum);
}

function NumberCount()
{
  //Variables
  var hWndEdit=AkelPad.GetEditWnd();
  var nSelState=SELECTALL=0;
  var NORMALSEL=1;
  var COLUMNSEL=2;
  var pSelText;

  //Esc-sequences
  var sEscStr=sStr.replace(/\\\\/g, "\0");
  sEscStr=sEscStr.replace(/\\r\\n|\\r|\\n/g, "\n");
  sEscStr=sEscStr.replace(/\\t/g, "\t");
  sEscStr=sEscStr.replace(/\0/g, "\\");

  if (bNum) sEscStr=sEscStr.replace(/\\N/g, "\0");

  if (AkelPad.IsAkelEdit()) AkelPad.SendMessage(hWndEdit, 3185 /*AEM_LOCKSCROLL*/, 3 /*SB_BOTH*/, true);

  SetRedraw(hWndEdit, false);

  if (AkelPad.SendMessage(hWndEdit, 3125 /*AEM_GETSEL*/, 0, 0))
  {
    if (AkelPad.SendMessage(hWndEdit, 3127 /*AEM_GETCOLUMNSEL*/, 0, 0))
    {
      nSelState=COLUMNSEL;
      pSelText =AkelPad.GetSelText(2);
    }
    else
    {
      nSelState    =NORMALSEL;
      var nSelStart=AkelPad.GetSelStart();
      var nSelEnd  =AkelPad.GetSelEnd();

      SelCompleteLine(hWndEdit, nSelStart, nSelEnd);

      nSelStart=AkelPad.GetSelStart();
      pSelText =AkelPad.GetSelText(2);

      var pLastStr =pSelText.charAt(pSelText.length-1);

      if (pLastStr=="\n") pSelText=pSelText.substr(0, pSelText.length-1);
    }
  }
  else
  {
    pSelText =AkelPad.GetTextRange(0, -1, 2);
  }

  var oPattern=new RegExp("(^.*$)", "mg");
  pSelText=pSelText.replace(oPattern, sEscStr);

  if (bNum && sEscStr.indexOf("\0")!=-1)
  {
    pSelText=pSelText.split("\0");
    var m=0;

    if (nFirst!=parseInt(nFirst) || nStep!=parseInt(nStep))
    {
      var r1,r2;
      try{r1=nFirst.toString().split(".")[1].length}catch(e){r1=0};
      try{r2=nStep.toString().split(".")[1].length}catch(e){r2=0};
      m=Math.max(r1,r2);
    }

    var nCurrentNum=(bRand) ? nFirst+(nStep-nFirst)*Math.random() : nFirst;

    var pNumText;

    for (i=0; i<pSelText.length-1; i++)
    {
      pNumText=Pad(sPad,nCurrentNum,pNumText,m);
      nCurrentNum=(bRand) ? nFirst+(nStep-nFirst)*Math.random() : nCurrentNum+nStep;
      pSelText[i]=pSelText[i]+pNumText;
    }
    pSelText=pSelText.join("");
  }

  if (nSelState==COLUMNSEL)
  {
    dwOptions=AkelPad.SendMessage(hWndEdit, 3227 /*AEM_GETOPTIONS*/, 0, 0);
    if (!(dwOptions & 0x40 /*AECO_PASTESELECTCOLUMN*/)) AkelPad.SendMessage(hWndEdit, 3228 /*AEM_SETOPTIONS*/, 2 /*AECOOP_OR*/, 0x40 /*AECO_PASTESELECTCOLUMN*/);
    AkelPad.ReplaceSel(pSelText);
    if (!(dwOptions & 0x40 /*AECO_PASTESELECTCOLUMN*/)) AkelPad.SendMessage(hWndEdit, 3228 /*AEM_SETOPTIONS*/, 4 /*AECOOP_XOR*/, 0x40 /*AECO_PASTESELECTCOLUMN*/);
  }
  else if (nSelState==NORMALSEL)
  {
    if (pLastStr=="\n") pSelText=pSelText+"\n";
    AkelPad.ReplaceSel(pSelText);
    var nSelEnd=AkelPad.GetSelEnd();
    AkelPad.SetSel(nSelStart,nSelEnd);
  }
  else if (nSelState==SELECTALL)
  {
    AkelPad.SetSel(0, -1);
    AkelPad.ReplaceSel(pSelText);
  }

  if (AkelPad.IsAkelEdit()) AkelPad.SendMessage(hWndEdit, 3185 /*AEM_LOCKSCROLL*/, 3 /*SB_BOTH*/, false);

  SetRedraw(hWndEdit, true);
}

function DisableBtnOK(hWnd)
{
  oSys.Call("user32::GetWindowText"+_TCHAR, hWnd, lpBuffer, 256);
  var pStrExp=AkelPad.MemRead(lpBuffer, _TSTR);

  if (pStrExp=="") pStrExp="1";

  nID=Number(pStrExp);

  if (isNaN(nID))
  {
    oSys.Call("user32::EnableWindow", aWnd[IDC_OK][WND], false);
    oSys.Call("user32::SetFocus", hWnd);
    return true;
  }
}

function InsertInArray(lpArray, lpItem, nPos)
{
  //For MS JScript backward compatibility
  var i;

  if (nPos<0) nPos=lpArray.length+nPos+1;
  if (nPos<0) nPos=0;
  if (nPos>lpArray.length) nPos=lpArray.length;

  for (i=lpArray.length; i >= 0; --i)
  {
    if (i==nPos)
    {
      lpArray[i]=lpItem;
      break;
    }
    lpArray[i]=lpArray[i-1];
  }
}

function DeleteFromArray(lpArray, nPos, nCount)
{
  //For MS JScript backward compatibility
  var i;

  if (nPos<0) nPos=lpArray.length+nPos;
  if (nPos<0 || nPos >= lpArray.length) return;
  if (nPos+nCount >= lpArray.length) nCount=lpArray.length-nPos;

  for (i=nPos; i+nCount<lpArray.length; ++i)
  {
    lpArray[i]=lpArray[i+nCount];
  }
  lpArray.length-=nCount;
}

function SetWindowFontAndText(hWnd, hFont, pText)
{
  if (hFont) AkelPad.SendMessage(hWnd, 48 /*WM_SETFONT*/, hFont, true);

  AkelPad.MemCopy(lpBuffer, pText.substr(0, 255).replace(/\r$/, ""), _TSTR);
  oSys.Call("user32::SetWindowText"+_TCHAR, hWnd, lpBuffer);
}

function SetRedraw(hWnd, bRedraw)
{
  AkelPad.SendMessage(hWnd, 11 /*WM_SETREDRAW*/, bRedraw, 0);
  if (bRedraw) oSys.Call("user32::InvalidateRect", hWnd, 0, true);
}

function RectToArray(lpRect, rcRect)
{
  rcRect.left  =AkelPad.MemRead(lpRect   , 3 /*DT_DWORD*/);
  rcRect.top   =AkelPad.MemRead(lpRect+4 , 3 /*DT_DWORD*/);
  rcRect.right =AkelPad.MemRead(lpRect+8 , 3 /*DT_DWORD*/);
  rcRect.bottom=AkelPad.MemRead(lpRect+12, 3 /*DT_DWORD*/);
  return rcRect;
}

function CenterWindow(hWndParent, hWnd)
{
  var lpRect;
  var rcWndParent=[];
  var rcWnd=[];
  var X;
  var Y;

  if (lpRect=AkelPad.MemAlloc(16))  //sizeof(RECT)
  {
    if (!hWndParent) hWndParent=oSys.Call("user32::GetDesktopWindow");

    oSys.Call("user32::GetWindowRect", hWndParent, lpRect);
    RectToArray(lpRect, rcWndParent);

    oSys.Call("user32::GetWindowRect", hWnd, lpRect);
    RectToArray(lpRect, rcWnd);

    //Center window
    X=rcWndParent.left+((rcWndParent.right-rcWndParent.left)/2-(rcWnd.right-rcWnd.left)/2);
    Y=rcWndParent.top +((rcWndParent.bottom-rcWndParent.top)/2-(rcWnd.bottom-rcWnd.top)/2);

    oSys.Call("user32::SetWindowPos", hWnd, 0, X, Y, 0, 0, 0x15 /*SWP_NOSIZE|SWP_NOZORDER|SWP_NOACTIVATE*/);

    AkelPad.MemFree(lpRect);
  }
}

function SelCompleteLine(hWnd, nMinSel, nMaxSel)
{
  if (nMinSel<nMaxSel)
  {
    var nMinLine      =AkelPad.SendMessage(hWnd, 1078 /*EM_EXLINEFROMCHAR*/,        0, nMinSel);
    var nMaxLine      =AkelPad.SendMessage(hWnd, 1078 /*EM_EXLINEFROMCHAR*/,        0, nMaxSel);
    var nMinLineIndex =AkelPad.SendMessage(hWnd, 187       /*EM_LINEINDEX*/, nMinLine,       0);
    var nMaxLineIndex =AkelPad.SendMessage(hWnd, 187       /*EM_LINEINDEX*/, nMaxLine,       0);
    var nMaxLineLength=AkelPad.SendMessage(hWnd, 193      /*EM_LINELENGTH*/,  nMaxSel,       0);
    if (nMaxLineIndex==nMaxSel) --nMaxLine;
    else if (nMaxLineLength) nMaxSel=nMaxLineIndex+nMaxLineLength+1;
    nMinSel=nMinLineIndex;
    AkelPad.SetSel(nMinSel, nMaxSel);
    return nMaxLine-nMinLine+1;
  }
  return 0;
}
