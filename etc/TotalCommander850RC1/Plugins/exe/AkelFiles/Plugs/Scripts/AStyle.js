/// Процесс текущего файла в AStyle
// Version 1.1
//
// Usage:
// Call("Scripts::Main", 1, "AStyle.js", "`flags`")
//-"AStyle форматирование кода" Call("Scripts::Main", 1, "AStyle.js", `"-b -N -o -t -S -w -Y -M -H -U -p"`)
// Или поддержки ShowMenuEx.js если вы не укажете флаг в аргумент:
// Call("Scripts::Main", 1, "AStyle.js")

var WshShell = new ActiveXObject("WScript.shell");
var fso = new ActiveXObject("Scripting.FileSystemObject");

var pToolPath = AkelPad.GetAkelDir() + "\\AkelFiles\\Tools\\AStyle\\AStyle.exe";
var pToolFlags = "";

if (WScript.Arguments.length)
{
	pToolFlags += WScript.Arguments(0);
}
else if (pToolFlags == "")
{
	eval(AkelPad.ReadFile(AkelPad.GetAkelDir() + "\\AkelFiles\\Plugs\\Scripts\\ShowMenuEx.js"));
	var pFlags = getSelectedMenuItem(POS_CURSOR, "", 0);

	if (pFlags == "")
		WScript.Quit();

	pToolFlags += pFlags;
}

var hEditWnd = AkelPad.GetEditWnd();
var pTmpFile;
var pText;

if (pTmpFile = CreateTempFile())
{
	AkelPad.SaveFile(hEditWnd, pTmpFile, 65001 /*UTF-8*/, true, false);

	pToolPath = correctCommandLine(pToolPath);
	pTmpFile = correctCommandLine(pTmpFile);

	WshShell.Run("%COMSPEC% /c " + pToolPath + " " + pToolFlags + " " + pTmpFile, 0, true);
	pText = AkelPad.ReadFile(pTmpFile);

	setRedraw(hEditWnd, false);
	var nCaretPos = AkelPad.GetSelStart();
	AkelPad.SetSel(0, -1);
	AkelPad.ReplaceSel(pText);
	AkelPad.SetSel(nCaretPos, nCaretPos);
	setRedraw(hEditWnd, true);

	fso.DeleteFile(pTmpFile);
}

//Functions
function CreateTempFile()
{
	var oTmpFolder;
	var oTmpFile;
	var pTmpName;

	if (oTmpFolder = fso.GetSpecialFolder(2 /*TemporaryFolder*/))
	{
		pTmpName = fso.GetTempName();

		if (oTmpFile = oTmpFolder.CreateTextFile(pTmpName))
			oTmpFile.Close();

		return (oTmpFolder.Path + "\\" + pTmpName);
	}
	return "";
}

function correctCommandLine(pPath)
{
	if (pPath.search(/ /) != -1)
		return "\"" + pPath + "\"";
	else
		return pPath;
}

function setRedraw(hWnd, bRedraw)
{
	var oSys = AkelPad.SystemFunction();
	AkelPad.SendMessage(hWnd, 11 /*WM_SETREDRAW*/, bRedraw, 0);
	bRedraw && oSys.Call("user32::InvalidateRect", hWnd, 0, true);
}