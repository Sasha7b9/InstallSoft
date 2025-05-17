// encoding: UTF-8 without BOM

// CCompletion plugin for Notepad++, (C) 2007-2010 Boštjan Mihorič

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either
// version 2 of the License, or (at your option) any later version.




//
// Note from original author: this code is a mess. It was thrown together with minimal time investment.
// New features were just quickly patched into the existing code. All kinds of bad programming practices are used.
// I am painfully aware of this and was reluctant to release the code for this reason since I never found
// the time to rewrite it. Therefore, the code is released AS-IS, with this apology included. This also means
// I won't be running some kind of technical support for this code, so:
// Please do not email me with questions on workings or structure of this code.
// For some of the comments, you can use Google Translate from Slovenian ;)
//
// Boštjan Mihorič
//

//
// Just a quick explanation of terms used in this code:
// identifier: a name of function, variable, macro, class, etc., that identifies some entity (Ctags calls them "tags")
// execute: run the ctags.exe in order to create ctags.tmp; Exuberant Ctags finds the identifiers (tags) for us
// parse: go through ctags.tmp in order to fill an IDENTIFIERS structure
// rebuild: put together appropriate IDENTIFIERS structures into _identifiers, which holds currently visible identifiers
// CCompletion efficiently uses the three steps of executing, parsing and rebuilding, in order to finally show the identifiers.
//



#define UNICODE
#define _UNICODE




#include "resfile.h"


#include <windows.h>
#include <tchar.h>
#include <stdio.h>
#include <stdarg.h>
#include <limits.h>
#include <malloc.h>
#include <ctype.h>
#include <shlobj.h>
#include <shlwapi.h>
#include <float.h>

#include "Scintilla.h"
#include "PluginInterface.h"

#define HNPP  nppData._nppHandle
#define HNPP1 nppData._scintillaMainHandle
#define HNPP2 nppData._scintillaSecondHandle
//#define FAILURE(MSG)	MessageBox(HNPP, (MSG), "Failure", MB_OK | MB_ICONEXCLAMATION)
#define MESSAGE(CAPTION, MSG)	MessageBox(HNPP, (MSG), (CAPTION), MB_OK | MB_ICONEXCLAMATION)
#define SETTINGS_FILE TEXT("NppCCompletionPlugin.ini")
#define CCOMPLETION_DLL_FILENAME TEXT("NppCCompletionPlugin.dll")
#define CTAGSFILENAME TEXT("ctags.tmp")

#define COLOR_SELECTED		RGB(225, 255, 205)/*RGB(255, 255, 230)*//*RGB(160, 200, 190)*/
#define COLOR_UNSELECTED	RGB(255, 255, 210)/*RGB(230, 230, 210)*//*RGB(225, 235, 180)*/
#define COLOR_TEXT		RGB(0, 0, 0)
#define COLOR_GROUP_TEXT	RGB(0, 0, 255)	//barva teksta za grupiranje
#define COLOR_LIBRARY_TEXT	RGB(128, 128, 128) // color for library paths


static HWND hwndDialog = NULL;
#define MAX(a, b) (((a) > (b)) ? (a) : (b))
#define MIN(a, b) (((a) < (b)) ? (a) : (b))


static TCHAR _ctagsParameters[1024] = {L'\0'};
static BOOL _useLargeDPI = FALSE; // če TRUE, se uporabi dpi 163 namesto dpi 96
static inline int getLineHeight(void) { return _useLargeDPI ? 27 : 15; }



static int _numLinesDisplayed;


typedef struct Identifier
{
	TCHAR* tag;
	const TCHAR* tagType;
	TCHAR* filename;
	unsigned int lineNum;
	int index;		// če -1, identifier ni prikazan na listi
	int limitCharsShown;	// število znakov, ki naj se jih prikaže
	BOOL isLimitedClass;	// če TRUE, se prikazuje omejen identifier (kot razred v hierarhiji)
	int tagStrLen;
	COLORREF tagTextColor;
	unsigned int flags;	// all purpose flags
	
	// these two are used if they are defined and go to is triggered when we are already at filename, lineNum
	TCHAR* alternativeFilename;
	unsigned int alternativeLineNum;
}
IDENT;


typedef struct IDENTIFIERS
{
	IDENT* arr;
	int count;
	int capacity;
}
IDENTIFIERS;


static IDENTIFIERS _identifiers;


#define MAX_LIBS 32

typedef struct PROJECT
{
	IDENTIFIERS ids;
	TCHAR path[MAX_PATH];
	int pathLen;
	BOOL mustReexecute;
	BOOL mustReparse;
	PROJECT* libs[MAX_LIBS];
	int libsCount;
	BOOL recursiveParsing;
}
PROJECT;


#define MAX_PROJECTS 64
static int _projectsCount = 0;
static PROJECT _projects[MAX_PROJECTS];
static PROJECT _nonProject;



#define MAX_HISTORY 128

// zgodovina za vračanje nazaj po goto identifier ukazu
typedef struct HistoryOfGotoActions
{
	BOOL isValid;
	TCHAR filename[MAX_PATH];	// datoteka
	int lineNum;			// vrstica
}
HISTORY;

static HISTORY _history1[MAX_HISTORY];
static HISTORY _history2[MAX_HISTORY];
static int _histIndex1 = 0;
static int _histIndex2 = 0;





static unsigned int scrollLinesPerWheelTurn;
static TCHAR _groupingSeparatorChar = TEXT('_');

#define MAX_GROUP_INDEXES_REMEMBERED 16
#define MAX_REGEX_SIZE 132
static int _groupHistoryStrings[MAX_GROUP_INDEXES_REMEMBERED][MAX_REGEX_SIZE];
static int _groupHistoryCaretPositions[MAX_GROUP_INDEXES_REMEMBERED][2];
static int _groupHistoryIndexes[MAX_GROUP_INDEXES_REMEMBERED];
static int _groupHistoryCurrent = -1;

static NppData nppData;

static HWND hwndEdit = NULL;
static HWND hwndList = NULL;
static HWND hwndCB = NULL;
static HBRUSH _hbrushBg = NULL;

static RECT _sizePos = {20, 20, 700, 250};//default položaj in velikost
static BOOL _enableAutoLookup = TRUE;
static BOOL _autoRegenerateTagsOnSaveForProject = TRUE;
static BOOL _autoRegenerateTagsOnSaveForNonProject = FALSE;
static BOOL _ignoreInvalidTagsAndContinueParsing = FALSE;
static BOOL _savesettingsrequired = FALSE;

static BOOL _deleteCtagsTmpForProject = FALSE;
static BOOL _deleteCtagsTmpForNonProject = TRUE;


static BOOL _skipTypedefWhenSameNameStructPreceedesIt = TRUE;
static BOOL _skipFunctionWhenSameNamePrototypePreceedesIt = TRUE;
static BOOL _groupIdentifiers = TRUE;

static BOOL _onDialogSpaceInsertsSeparatorCharacter = FALSE;
static BOOL _doNotShowOutOfScopeIdentifiers = TRUE;


static BOOL _stringInputMode = FALSE;
static TCHAR _getStringResult[128];


static void pushHistoryEntry(BOOL primaryView,BOOL insertAfterCurrent);
static BOOL isThereOnlyWhitespaceBeforeSelection(void);
static void insertSnippetAndSetCursorPosition(const TCHAR*, int);



// consts to suppress compiler warnings
#define FLAG_DEFAULT		0
#define FLAG_IS_LIBRARY		(1<<0) // is identifier in a library?
#define FLAG_IS_FUNCTION_LIKE	(1<<1) // for functions and function-like macros
#define FLAG_IS_INTERNAL	(1<<2) // if identifier is internal, it is only shown within the same file; e.g., it has file-scope, and is internal to that module

/*
#define FLAG_UNKNOWN		(1<<9)
#define FLAG_MACRO		(1<<10)
#define FLAG_FUNCTION		(1<<11)
#define FLAG_PROTOTYPE		(1<<12)
#define FLAG_VARIABLE		(1<<13)
#define FLAG_EXTERNVAR		(1<<14)
#define FLAG_LOCAL		(1<<15)
#define FLAG_STRUCT		(1<<16)
#define FLAG_TYPEDEF		(1<<17)
#define FLAG_ENUMERATOR		(1<<18)
#define FLAG_ENUM		(1<<19)
#define FLAG_UNION		(1<<20)
#define FLAG_MEMBER		(1<<21)
#define FLAG_NAMESPACE		(1<<22)
#define FLAG_CLASS		(1<<23)
#define FLAG_METHOD		(1<<24)
*/


static const TCHAR* const STR_macro = TEXT("macro");
static const TCHAR* const STR_function = TEXT("function");
static const TCHAR* const STR_prototype = TEXT("prototype");
static const TCHAR* const STR_variable = TEXT("variable");
static const TCHAR* const STR_externvar = TEXT("externvar");
static const TCHAR* const STR_local = TEXT("local");
static const TCHAR* const STR_struct = TEXT("struct");
static const TCHAR* const STR_typedef = TEXT("typedef");
static const TCHAR* const STR_enumerator = TEXT("enumerator");
static const TCHAR* const STR_enum = TEXT("enum");
static const TCHAR* const STR_union = TEXT("union");
static const TCHAR* const STR_member = TEXT("member");
static const TCHAR* const STR_namespace = TEXT("namespace");
static const TCHAR* const STR_class = TEXT("class");
static const TCHAR* const STR_method = TEXT("method");




//#include "tracer.c"



// za qsort, case insensitive
static int cmpIdent(const void* a, const void* b)
{
	return StrCmpI(((IDENT*)a)->tag, ((IDENT*)b)->tag);
}


static void FAILURE(
	const TCHAR* format,
	...)
{
	va_list arguments;
	TCHAR tmp[512];
	
	va_start(arguments, format);
	_vsntprintf(tmp, 511, format, arguments);
	tmp[511] = TEXT('\0');
	va_end(arguments);
	MessageBox(HNPP, tmp, TEXT("Failure"), MB_OK | MB_ICONEXCLAMATION);
}


static BOOL getCurrentFileFullPath(TCHAR* buf)
{
	SendMessage(HNPP, NPPM_GETFULLCURRENTPATH, 0, (LPARAM)buf);
	
	if (_tcslen(buf) == 0)
	{
		FAILURE(TEXT("failed getting path of current file (no files opened?)"));
		return FALSE;
	}
	
	return TRUE;
}

static BOOL getSettingsFileFullpath(TCHAR* fullpath)//ob uspehu vrne TRUE
{
	fullpath[0] = TEXT('\0');
	
	// dobi path NPP
	SendMessage(HNPP, NPPM_GETPLUGINSCONFIGDIR, MAX_PATH, (LPARAM)fullpath);
	
	if (_tcslen(fullpath) == 0) {FAILURE(TEXT("failed getting path of config directory")); return FALSE;}
	
	if (!PathAppend(fullpath, SETTINGS_FILE))
	{
		FAILURE(TEXT("failed making path of settings file"));
		return FALSE;
	}
	
	
	return TRUE;
}

static BOOL getCtagsExePath(TCHAR* fullpath) // prebere path ctags.exe datoteke v podani buffer
{
	fullpath[0] = TEXT('\0');
	
	// dobi path NPP
	SendMessage(HNPP, NPPM_GETNPPDIRECTORY, 0, (LPARAM)fullpath);
	
	if (_tcslen(fullpath) == 0) {FAILURE(TEXT("failed getting path of N++")); return FALSE;}
	
	if (!PathAppend(fullpath, TEXT("plugins")) || !PathAppend(fullpath, TEXT("ctags.exe")))
	{
		FAILURE(TEXT("failed making path of ctags executable"));
		return FALSE;
	}
	
	return TRUE;
}



// a path container function
static BOOL pathChanged1(const TCHAR* newPath)
{
	static TCHAR currentPath[MAX_PATH] = {TEXT('\0')};
	
	if (lstrcmpi(newPath, currentPath) == 0)	return FALSE;
	
	_tcscpy(currentPath, newPath);
	return TRUE;
}


// returns NULL if project not found
static PROJECT* ProjectFindForFile(const TCHAR* fileFullpath)
{
	int i, commonPrefixLen, currentFileDirPathLen;
	TCHAR tmpPath[MAX_PATH];
	TCHAR fullpath[MAX_PATH];
	
	_tcscpy(fullpath, fileFullpath);
	
	// odstrani ime datoteke in trailing slash (get base path)
	PathRemoveFileSpec(fullpath);
	currentFileDirPathLen = _tcslen(fullpath);
	
	// check if file within a known project
	for (i = 0; i < _projectsCount; i++)
	{
		commonPrefixLen = PathCommonPrefix(fullpath, _projects[i].path, tmpPath);
		
		if ((commonPrefixLen == _projects[i].pathLen) // the project path is at the same time the common prefix
			&& ((_projects[i].recursiveParsing) // recursive parsing is enabled
				|| (commonPrefixLen == currentFileDirPathLen))) // the file is located directly in the project directory (not subdirectory)
		{
			// project found
			return (&_projects[i]);
		}
	}
	
	return (NULL);
}

// returns NULL upon failure only, a project is always retrieved (&_nonProject if current file not within a project)
static PROJECT* getCurrentProject(void)
{
	PROJECT* p;
	TCHAR fullpath[MAX_PATH];
	
	if (!getCurrentFileFullPath(fullpath))	return (NULL);
	
	// a project file
	if ((p = ProjectFindForFile(fullpath)))	return (p);
	
	// a non-project file
	
	// odstrani ime datoteke in trailing slash (get base path)
	PathRemoveFileSpec(fullpath);
	
	// _nonProject holds identifiers for a non-project, so it must be reparsed if the base path changed, or it would
	// still hold the identifiers of the previous non-project (different base path means different ctags.tmp file)
	if (pathChanged1(fullpath))
	{
		_tcscpy(_nonProject.path, fullpath);
		_nonProject.pathLen = _tcslen(_nonProject.path);
		_nonProject.mustReexecute = FALSE;
		_nonProject.mustReparse = TRUE;
		_nonProject.recursiveParsing = FALSE;
	}
	
	return (&_nonProject);
}


//izprazni strukturo
static void IdentifiersReset(IDENTIFIERS* ids)
{
	if (ids->capacity)
	{
		while (ids->count)
		{
			ids->count--;
			free(ids->arr[ids->count].tag);
			free(ids->arr[ids->count].filename);
			
			if (ids->arr[ids->count].alternativeFilename)	free(ids->arr[ids->count].alternativeFilename);
		}
		free(ids->arr);
	}
	memset(ids, 0, sizeof(IDENTIFIERS));
}


static BOOL IdentifiersExpand(IDENTIFIERS* ids)
{
	if (ids->capacity)
	{
		IDENT* tmp;
		if (!(tmp = (IDENT*)realloc(ids->arr, sizeof (IDENT) * ids->capacity * 2)))
		{
			FAILURE(TEXT("failed reallocating memory"));
			return FALSE;
		}
		else
		{
			ids->arr = tmp;
			ids->capacity *= 2;
			return (TRUE);
		}
	}
	else
	{
		if (!(ids->arr = (IDENT*)malloc(sizeof (IDENT) * 1024)))
		{
			FAILURE(TEXT("failed allocating memory"));
			return FALSE;
		}
		ids->capacity = 1024;
		ids->count = 0;
		return (TRUE);
	}
}

//add all in ids2 to ids1
static BOOL IdentifiersAdd(IDENTIFIERS* ids1, IDENTIFIERS* ids2, BOOL isLibrary)
{
	int i;
	for (i = 0; i < ids2->count; i++)
	{
		// doda prostor
		if ((ids1->count == ids1->capacity)
			&& (!IdentifiersExpand(ids1)))
		{
			goto LABEL_FAIL;
		}
		
		memcpy(&ids1->arr[ids1->count], &ids2->arr[i], sizeof(IDENT));
		ids1->arr[ids1->count].tag = NULL;
		ids1->arr[ids1->count].filename = NULL;
		ids1->arr[ids1->count].alternativeFilename = NULL;
		
		int len = _tcslen(ids2->arr[i].tag) + 1;
		if (!(ids1->arr[ids1->count].tag = (TCHAR*)malloc(len * sizeof(TCHAR))))
		{
			goto LABEL_FAIL;
		}
		memcpy(ids1->arr[ids1->count].tag, ids2->arr[i].tag, len * sizeof(TCHAR));
		
		len = _tcslen(ids2->arr[i].filename) + 1;
		if (!(ids1->arr[ids1->count].filename = (TCHAR*)malloc(len * sizeof(TCHAR))))
		{
			goto LABEL_FAIL;
		}
		memcpy(ids1->arr[ids1->count].filename, ids2->arr[i].filename, len * sizeof(TCHAR));
		
		if (ids2->arr[i].alternativeFilename)
		{
			len = _tcslen(ids2->arr[i].alternativeFilename) + 1;
			if (!(ids1->arr[ids1->count].alternativeFilename = (TCHAR*)malloc(len * sizeof(TCHAR))))
			{
				goto LABEL_FAIL;
			}
			memcpy(ids1->arr[ids1->count].alternativeFilename, ids2->arr[i].alternativeFilename, len * sizeof(TCHAR));
		}
		
		if (isLibrary)
		{
			ids1->arr[ids1->count].flags |= FLAG_IS_LIBRARY;
		}
		ids1->count++;
	}
	
	return (TRUE);
	
LABEL_FAIL:
	if (ids1->arr[ids1->count].tag)
	{
		free(ids1->arr[ids1->count].tag);
		ids1->arr[ids1->count].tag = NULL;
	}
	if (ids1->arr[ids1->count].filename)
	{
		free(ids1->arr[ids1->count].filename);
		ids1->arr[ids1->count].filename = NULL;
	}
	if (ids1->arr[ids1->count].alternativeFilename)
	{
		free(ids1->arr[ids1->count].alternativeFilename);
		ids1->arr[ids1->count].alternativeFilename = NULL;
	}
	return (FALSE);
}

static void IdentifiersSort(IDENTIFIERS* ids)
{
	qsort(ids->arr, ids->count, sizeof(IDENT), &cmpIdent);
}


static void setDefaultSettings(void)
{
	_groupingSeparatorChar = TEXT('_'); // default group separator character
	_tcscpy(_ctagsParameters, TEXT("--fields=-aiklmnSzt+fsK --c-kinds=+lp --excmd=number -f")); // default CTAGS parameters
	_sizePos = (RECT){20, 20, 700, 250};//default položaj in velikost
	_enableAutoLookup = TRUE;
	_autoRegenerateTagsOnSaveForProject = TRUE;
	_autoRegenerateTagsOnSaveForNonProject = FALSE;
	_deleteCtagsTmpForProject = FALSE;
	_deleteCtagsTmpForNonProject = TRUE;
	_ignoreInvalidTagsAndContinueParsing = FALSE;
	_skipTypedefWhenSameNameStructPreceedesIt = TRUE;
	_skipFunctionWhenSameNamePrototypePreceedesIt = TRUE;
	_groupIdentifiers = TRUE;
	_useLargeDPI = FALSE;
	_onDialogSpaceInsertsSeparatorCharacter = FALSE;
	_doNotShowOutOfScopeIdentifiers = TRUE;
}


static void saveSettings(void)
{
	TCHAR path[MAX_PATH];
	unsigned int count = 0;
	
	#define BUF_SIZE 1024*1024
	TCHAR* buf = (TCHAR*)malloc(BUF_SIZE);
	FILE* f = NULL;
	
	if (!buf)
	{
		FAILURE(TEXT("failed allocating buffer, unable to save settings"));
		return;
	}
	
	if (!getSettingsFileFullpath(path))	goto CLEANUP;
	
	// prebere project path-e, da jih prepiše naprej (datoteka morda še ne obstaja)
	if ((f = _tfopen(path, TEXT("rt"))))
	{
		// zavrže nepomembne
		_fgetts(buf, BUF_SIZE / sizeof(TCHAR), f);
		_fgetts(buf, BUF_SIZE / sizeof(TCHAR), f);
		_fgetts(buf, BUF_SIZE / sizeof(TCHAR), f);
		_fgetts(buf, BUF_SIZE / sizeof(TCHAR), f);
		// prebere pathe
		count = fread(buf, sizeof(TCHAR), BUF_SIZE / sizeof(TCHAR), f);
		fclose(f);
	}
	
	if (!(f = _tfopen(path, TEXT("wt"))))
	{
		FAILURE(TEXT("failed opening settings file: \"%s\""), path);
		goto CLEANUP;
	}
	
	if ((!_ftprintf(f,
			TEXT("%c\n%s\n%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\nadd project paths as new lines below this text"),
			_groupingSeparatorChar,
			_ctagsParameters,
			(int)_sizePos.left, (int)_sizePos.right, (int)_sizePos.top, (int)_sizePos.bottom,
			_enableAutoLookup,
			_autoRegenerateTagsOnSaveForProject,
			_autoRegenerateTagsOnSaveForNonProject,
			_deleteCtagsTmpForProject,
			_deleteCtagsTmpForNonProject,
			_ignoreInvalidTagsAndContinueParsing,
			_skipTypedefWhenSameNameStructPreceedesIt,
			_skipFunctionWhenSameNamePrototypePreceedesIt,
			_groupIdentifiers,
			_useLargeDPI,
			_onDialogSpaceInsertsSeparatorCharacter,
			_doNotShowOutOfScopeIdentifiers))
		|| (_puttc(TEXT('\n'), f) == _TEOF)
		|| ((count > 0)
			&& (fwrite(buf, sizeof(TCHAR), count, f) != count)))
	{
		FAILURE(TEXT("failed writing to settings file"));
	}
	
	fclose(f);
	
CLEANUP:
	free(buf);
	#undef BUF_SIZE
}




#define MENUOPTIONSCOUNT 30
static FuncItem _funcItem[MENUOPTIONSCOUNT];


static void setMenuCheckItems(void)
{
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[15]._cmdID, _autoRegenerateTagsOnSaveForProject);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[16]._cmdID, _autoRegenerateTagsOnSaveForNonProject);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[17]._cmdID, _deleteCtagsTmpForProject);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[18]._cmdID, _deleteCtagsTmpForNonProject);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[19]._cmdID, _ignoreInvalidTagsAndContinueParsing);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[20]._cmdID, _skipTypedefWhenSameNameStructPreceedesIt);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[21]._cmdID, _skipFunctionWhenSameNamePrototypePreceedesIt);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[22]._cmdID, _groupIdentifiers);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[23]._cmdID, _useLargeDPI);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[24]._cmdID, _onDialogSpaceInsertsSeparatorCharacter);
	SendMessage(HNPP, NPPM_SETMENUITEMCHECK, _funcItem[25]._cmdID, _doNotShowOutOfScopeIdentifiers);
}



// finds a project with a matching path, hits user with warning if overlapping found
static PROJECT* ProjectFindProject(
	const TCHAR* path,
	BOOL isRecursivelyParsed)// if TRUE, it will cause a warning in certain cases
{
	int i, commonPrefixLen, oldProjectLen, newProjectLen = _tcslen(path);
	TCHAR tmpPath[MAX_PATH];
	
	for (i = 0; i < _projectsCount; i++)
	{
		commonPrefixLen = PathCommonPrefix(path, _projects[i].path, tmpPath);
		oldProjectLen = _projects[i].pathLen;
		
		if ((commonPrefixLen == oldProjectLen)
			&& (commonPrefixLen == newProjectLen))
		{
			return (&_projects[i]);
		}
		
		if ((commonPrefixLen == oldProjectLen)
			|| (commonPrefixLen == newProjectLen))
		{
			// if the superdirectory project is not recursive, there is no problem
			if ((commonPrefixLen == oldProjectLen)
				&& (!_projects[i].recursiveParsing))
			{
				continue;
			}
			if ((commonPrefixLen == newProjectLen)
				&& (!isRecursivelyParsed))
			{
				continue;
			}
			
			FAILURE(TEXT("This project: \"%s\" overlaps with ")
				TEXT("another project: \"%s\".\nPlease resolve this and reload the ")
				TEXT("settings file in order to avoid unspecified behaviour.")
				, path, _projects[i].path);
		}
	}
	
	return (NULL);
}

static PROJECT* ProjectAddProject(
	const TCHAR* path,//if successful, return the PROJECT addresss
	BOOL isRecursivelyParsed)
{
	PROJECT* newProject = ProjectFindProject(path, isRecursivelyParsed);
	
	if (newProject)			return (newProject);
	if (_projectsCount == MAX_PROJECTS)	return (NULL);
	
	memset(&_projects[_projectsCount], 0, sizeof(PROJECT));
	_tcscpy(_projects[_projectsCount].path, path);
	_projects[_projectsCount].pathLen = _tcslen(path);
	_projects[_projectsCount].mustReexecute = FALSE;
	// must reparse because this is the first parse after reloading settings
	_projects[_projectsCount].mustReparse = TRUE;
	_projects[_projectsCount].recursiveParsing = isRecursivelyParsed;
	
	//FAILURE(TEXT("added project %s to index %d"), _projects[_projectsCount].path, _projectsCount);
	
	return (&_projects[_projectsCount++]);
}

static void ProjectAddLibrary(
	PROJECT* project,//add to this project
	const TCHAR* path,//this library
	BOOL isRecursivelyParsed)
{
	if (!project)	return;
	
	PROJECT* lib = ProjectFindProject(path, isRecursivelyParsed);
	
	if (!lib)	lib = ProjectAddProject(path, isRecursivelyParsed);
	if (!lib)	return;
	
	if (project->libsCount == MAX_LIBS)	return;
	
	//FAILURE(TEXT("added library %s to project %s"), lib->path, project->path);
	
	project->libs[project->libsCount++] = lib;
}




static void loadSettings(void)
{
	RECT r;
	TCHAR path[MAX_PATH];
	int pathLen;
	FILE* fp = NULL;
	PROJECT* lastAddedProject = NULL;
	
	if (!getSettingsFileFullpath(path))
	{
		setDefaultSettings();
		goto DONE;
	}
	
	if (!(fp = _tfopen(path, TEXT("rt"))))
	{
		// no warning of failure, since it's probably just first run and the file still needs to be created
		setDefaultSettings();
		goto DONE;
	}
	
	TCHAR line[4096];
	
	// sparsa datoteko
	
	// najprej razne nastavitve
	if ((!_fgetts(line, 4095, fp))
		|| (_stscanf(line, TEXT("%c\n"), // also demant newline following
			&_groupingSeparatorChar) != 1)
		|| (!_fgetts(_ctagsParameters, 1023, fp)) // scan CTAGS parameters
		|| (!_fgetts(line, 4095, fp))
		|| (_stscanf(line, TEXT("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d"),
			(int*)&r.left, (int*)&r.right, (int*)&r.top, (int*)&r.bottom,
			&_enableAutoLookup,
			&_autoRegenerateTagsOnSaveForProject,
			&_autoRegenerateTagsOnSaveForNonProject,
			&_deleteCtagsTmpForProject,
			&_deleteCtagsTmpForNonProject,
			&_ignoreInvalidTagsAndContinueParsing,
			&_skipTypedefWhenSameNameStructPreceedesIt,
			&_skipFunctionWhenSameNamePrototypePreceedesIt,
			&_groupIdentifiers,
			&_useLargeDPI,
			&_onDialogSpaceInsertsSeparatorCharacter,
			&_doNotShowOutOfScopeIdentifiers) != 16)
		)
	{
		fclose(fp);
		
		if (MessageBox(HNPP, TEXT("Corrupted settings file (") SETTINGS_FILE TEXT("), Delete it?"), TEXT(""),
			MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 /*| MB_TOPMOST | MB_TASKMODAL*/) == IDYES)
		{
			DeleteFile(path);
		}
		
		setDefaultSettings();
		goto DONE;
	}
	
	// clear newlines from ctags parameters line
	pathLen = _tcslen(_ctagsParameters);
	while (pathLen && (_ctagsParameters[--pathLen] == TEXT('\n')))	_ctagsParameters[pathLen] = TEXT('\0');
	
	// skip next line as it only contains instruction for adding project paths
	_fgetts(line, 4095, fp);
	
	//dealokacija in reset globalnih _projects struktur
	while (_projectsCount)
	{
		_projectsCount--;
		IdentifiersReset(&_projects[_projectsCount].ids);
		memset(&_projects[_projectsCount], 0, sizeof(PROJECT));
	}
	// strogo gledano tole ni potrebno, a se izvede, da loadSettings deluje tudi kot cache flush
	IdentifiersReset(&_nonProject.ids);
	_nonProject.mustReparse = TRUE;
	IdentifiersReset(&_identifiers);
	
	// nato še v vsaki vrstici en base path za nek projekt
	for (int i = MAX_PROJECTS; i--;) 
	{
		if (!_fgetts(line, 4095, fp))	break;
		
		line[4095] = TEXT('\0');
		pathLen = _tcslen(line);
		
		while (pathLen && (line[--pathLen] == TEXT('\n')))	line[pathLen] = TEXT('\0');
		
		TCHAR* projectPath = line;
		BOOL isLibraryPath = FALSE;
		BOOL isRecursivelyParsed = FALSE;
		
	loadSettings_AGAIN:
		if (projectPath[0] == TEXT('@'))
		{
			isLibraryPath = TRUE;
			projectPath++;
			goto loadSettings_AGAIN;
		}
		if (projectPath[0] == TEXT('&'))
		{
			isRecursivelyParsed = TRUE;
			projectPath++;
			goto loadSettings_AGAIN;
		}
		
		if (PathIsDirectory(projectPath))
		{
			PathRemoveBackslash(projectPath);
			
			if (isLibraryPath)	ProjectAddLibrary(lastAddedProject, projectPath, isRecursivelyParsed);
			else			lastAddedProject = ProjectAddProject(projectPath, isRecursivelyParsed);
			
			//MESSAGE(TEXT("Dodan path:"), projectPath);
		}
		else if (_tcslen(projectPath) > 0)
		{
			MESSAGE(TEXT("Invalid project directory:"), projectPath);
		}
	}
	
	fclose(fp);
	_sizePos = r;
	
DONE:
	setMenuCheckItems();
}


// paths for known ctags.tmp files
static TCHAR** _paths = NULL;
static int _maxPaths = 0, _numPaths = 0;



static void AddAKnownCtagsTmpPath(PROJECT* project)
{
	TCHAR fullpath[MAX_PATH];
	_tcscpy(fullpath, project->path);
	
	// doda novo ime (avtomatsko doda backslash)
	if (!PathAppend(fullpath, CTAGSFILENAME))
	{
		FAILURE(TEXT("failed making path of ") CTAGSFILENAME);
		return;
	}
	
	// preveri, ali je path že dodan
	for (int i = 0; i < _numPaths; i++)
	{
		if (lstrcmpi(_paths[i], fullpath) == 0)
		{
			//FAILURE(TEXT("was already added for deletition: %s"), project->path);
			return;	// path je že dodan
		}
	}
	
	//MESSAGE(TEXT("dodajam"), fullpath);
	
	if (_maxPaths == 0)
	{
		if (!(_paths = (TCHAR**)malloc(sizeof(TCHAR*) * 32)))
		{
		 	FAILURE(TEXT("failed allocating memory"));
			return;
		}
		
		_maxPaths = 32;
	}
	else if (_numPaths == _maxPaths)
	{
		if (!(_paths = (TCHAR**)realloc(_paths, sizeof(TCHAR*) * _maxPaths * 2)))
		{
			_maxPaths = _numPaths = 0;
		 	FAILURE(TEXT("failed reallocating memory"));
			return;
		}
		
		_maxPaths *= 2;
	}
	
	if (!(_paths[_numPaths] = (TCHAR*)malloc(sizeof(TCHAR) * (_tcslen(fullpath) + 1))))
	{
	 	FAILURE(TEXT("failed allocating memory"));
		return;
	}
	
	_tcscpy(_paths[_numPaths], fullpath);
	_numPaths++;
	
	//FAILURE(TEXT("added for deletition: %s"), project->path);
}


// Warning! this regex parser is reluctant and possessive. Not recommended for use elsewhere!
static int regexMatchIndex(TCHAR* regEx, TCHAR* string)
{
	unsigned int i, n = 0, r = 0, groupLen;	// skupina naj bo >= 1 znakov v regEx, ki jih omejujejo začetek, konec in znaki TEXT('*')
	BOOL star = FALSE;
	TCHAR c;
	unsigned int stringLength = _tcslen(string);
	
	for (;;)
	{
		switch (regEx[r])
		{
			case TEXT('\0'):
			{
				return ((star || (n >= stringLength)) ? (int)(min(n, stringLength-1)) : (-1));
			}
			break;
			
			case TEXT('*'):
			{
				r++;
				star = TRUE;
			}
			break;
			
			// najdena je bila skupina
			default:
			{
				groupLen = 0;
				
				// ugotovi dolžino skupine
				do
				{
					groupLen++;
					c = regEx[r + groupLen];
				}
				while ((c != TEXT('\0')) && (c != TEXT('*')));
				
				while ((n + groupLen) <= stringLength)
				{
					for (i = groupLen; i--;)
					{
						if ((regEx[r + i] != TEXT('?'))
							&& (_totlower(regEx[r + i]) != _totlower(string[n + i])))
						{
							// če pred skupino ni bilo znaka '*', neujemanje takoj vrne rezultat
							if (!star)	return (-1);
							
							n++;
							break;
						}
					}
					
					// preveri, ali se je zanka uspešno odvrtela
					if (i == (unsigned int)-1)	break;
				}
				
				if ((n += groupLen) > stringLength)	return (-1);
				
				r += groupLen;
				star = FALSE;
			}
		}
	}
}


// funkcija vrne TRUE, če je potrebno identifier skriti zaradi grupiranja identifierjev
static BOOL identifierGrouping(TCHAR* regex, int i)
{
	TCHAR* tag = _identifiers.arr[i].tag;
	
	// default: ne gre za omejen identifier
	int tagLen = _identifiers.arr[i].tagStrLen;
	_identifiers.arr[i].isLimitedClass = FALSE;
	
	int searchLen = regexMatchIndex(regex, tag);
	
	if (searchLen < 0)	return FALSE;
	
	int j, k;
	BOOL found = FALSE;
	
	for (k = searchLen; k < tagLen; k++)
	{
		if (tag[k] == _groupingSeparatorChar)
		{
			found = TRUE;
			break;
		}
	}
	
	if (!found)	return FALSE;
	
	found = FALSE;
	
	for (j = searchLen-1; j >= 0; j--)
	{
		if (tag[j] == _groupingSeparatorChar)
		{
			found = TRUE;
			break;
		}
	}
	
	if (!found)	j = 0;
	
	int l;
	
	found = FALSE;
	for (l = i - 1; l >= 0; l--)
	{
		if (_identifiers.arr[l].index != -1)
		{
			found = TRUE;
			break;
		}
	}
	
	if (!found)	return FALSE;
	
	int m;
	
	for (m = j; m <= k; m++)
	{
		if (tolower(_identifiers.arr[i].tag[m]) != tolower(_identifiers.arr[l].tag[m]))
		{
			return FALSE;
		}
	}
	
	//nastavi limitCharsShown za _identifiers[l] (tako, da je prikazana samo zadnja grupa, preostanek imena pa ne)
	_identifiers.arr[l].limitCharsShown = m;//k+1
	_identifiers.arr[l].isLimitedClass = TRUE;
	return TRUE;
}



static void deleteCtagsTmpFiles(BOOL unconditionally)
{
	for (int i = 0; i < _numPaths; i++)
	{
		PROJECT* p = ProjectFindForFile(_paths[i]);
		
		// check user settings
		if ((unconditionally)
			|| (((_deleteCtagsTmpForProject)
					&& (p))
				|| ((_deleteCtagsTmpForNonProject)
					&& (!p))))
		{
			//MESSAGE(TEXT("brišem"), _paths[i]);
			DeleteFile(_paths[i]);
		}
		
		free(_paths[i]);
	}
	
	_numPaths = 0;
	free(_paths);
	_maxPaths = 0;
}

static void unconditionallyDeleteAllKnownCtagsTmpFile(void)
{
	deleteCtagsTmpFiles(TRUE);
}



static void checkSizePos(HWND hwnd)
{
	RECT r;
	
	if (GetWindowRect(hwnd, &r))
	{
		r.right -= r.left;
		r.bottom -= r.top;
		
		if (memcmp(&r, &_sizePos, sizeof(RECT)) != 0)
		{
			_sizePos = r;
			_savesettingsrequired = TRUE;
		}
	}
}


#define MSG_TITLE TEXT("CCompletion plugin help")

BOOL CALLBACK HelpDialogProcedure(
    HWND hwndDlg,	// handle to dialog box
    UINT uMsg,	// message
    WPARAM wParam,	// first message parameter
    LPARAM lParam 	// second message parameter
   )
{
	switch (uMsg)
	{
		// get white background for the readonly textbox
		case WM_CTLCOLORSTATIC:
		{
			if (lParam == (int)GetDlgItem(hwndDlg, IDD_HELP_DIALOG_EDIT))
			{
				static HBRUSH hBackground = NULL;
				if (hBackground == NULL)
				{
					hBackground = CreateSolidBrush(RGB(255, 255, 255));
				}
				SetTextColor((HDC)wParam, RGB(0, 0, 0));
				SetBkColor((HDC)wParam, RGB(255, 255, 255));
				return ((LONG)hBackground);
			}
		}
		return (FALSE);
		
		case WM_INITDIALOG:
		{
			SendMessage(hwndDlg, WM_SETTEXT, 0, (LPARAM)MSG_TITLE);
			HWND hwndEdit = GetDlgItem(hwndDlg, IDD_HELP_DIALOG_EDIT);
			SendMessage(hwndEdit, WM_SETTEXT, 0, (LPARAM)lParam);
			PostMessage(hwndEdit, EM_SETSEL, (WPARAM)0, (LPARAM)0);
		}
		return (TRUE);
		
		case WM_COMMAND:
		{
			switch (LOWORD(wParam))
			{
				case IDD_HELP_DIALOG_OK:
				{
					EndDialog(hwndDlg, FALSE);
				}
				return (TRUE);
			}
		}
		break;
		
		case WM_CLOSE:
		{
			EndDialog(hwndDlg, FALSE);
		}
		return (TRUE);
	}
	
	return (FALSE);
}

static void showHelp(HWND owner)
{///
	const TCHAR* msg =
		TEXT("1. Please reassign keyboard shortcuts as you like. With so many of them, collisions are unavoidable, so I ")
		TEXT("left potential good defaults, rather than trying to figure out which mediocre shortcuts are still available. ")
		TEXT("Notepad++ has a good Shortcut Mapper for this purpose (see \"Settings\" menu). ")
		TEXT("CCompletion dialog remembers its size and position. Feel free to set it up the way you like it.\r\n")
		TEXT("\r\n")
		TEXT("2. The dialog keyboard commands are handled logically, regardless of whether textbox or listbox has focus. ")
		TEXT("UP, DOWN, PGUP, PGDN, HOME, END are all assigned to the listbox. LEFT, RIGHT, SHIFT+HOME, SHIFT+END ")
		TEXT("are assigned to the textbox. Any commands that do not seem to apply to the listbox, ")
		TEXT("will return focus to the textbox.\r\n")
		TEXT("\r\n")
		TEXT("With CCompletion dialog opened, you can:\r\n")
		TEXT("use ENTER to insert the identifier (code completion functionality),\r\n")
		TEXT("use ESC to cancel (identifier lookup functionality),\r\n")
		TEXT("use SPACE / F11 / F12 to move to the identifier in the current / first / second view (go to identifier functionality),\r\n")
		TEXT("use ENTER / SPACE to go to the line number you entered (go to line functionality that also adds a history entry).\r\n")
		TEXT("NOTE: with F11 and F12, hold down SHIFT or CONTROL key to keep the dialog opened.\r\n")
		TEXT("\r\n")
		TEXT("Go to identifier functionality can also be triggered directly in Notepad++ editor, by ")
		TEXT("moving keyboard caret on the identifier word and then using a direct shortcut ")
		TEXT("(F11 and F12 by default). Selecting the identifier word works just as well. ")
		TEXT("This can be reinvoked to cycle among same-named identifiers. ")
		TEXT("For example, if CCompletion moves you to a function prototype instead of function definition, ")
		TEXT("just press the button again.\r\n")
		TEXT("\r\n")
		TEXT("3. The list displays closest matches for what is typed in the textbox. ")
		TEXT("You can input ? for any one character and * for any sequence of zero or more characters. ")
		TEXT("Note that * is always appended at the end anyway. ")
		TEXT("CCompletion can automatically open the function definition when you insert a function identifier. ")
		TEXT("You can enable this feature with the option \"enable function auto-lookup\" on the dialog. ")
		TEXT("A history entry is added, so you can quickly return to previously displayed content.\r\n")
		TEXT("\r\n")
		TEXT("4. If some global identifiers are not shown even after regenerating tags, ")
		TEXT("you most likely have syntax errors in your code.\r\n")
		TEXT("\r\n")
		TEXT("5. You can add base paths for your projects in the \"") SETTINGS_FILE TEXT("\". Make a new line for each path. ")
		TEXT("Do not create this settings file yourself. Simply use the menu option to edit it and CCompletion will ")
		TEXT("create it if necessary. ")
		TEXT("After you finish editing it, select the menu option to reload settings (or restart Notepad++). ")
		TEXT("When a base project directory is supplied, CCompletion will store one \"") CTAGSFILENAME TEXT("\" for the ")
		TEXT("whole project. It will also display all the identifiers of the project, when triggered in any file ")
		TEXT("within that project.\r\n")
		TEXT("\r\n")
		TEXT("If a project path is prefixed with '@' (for example, \"@c:\\gcc\\include\"), ")
		TEXT("it is considered a library path. It is treated as any other project path, ")
		TEXT("except that its identifiers are visible in another ")
		TEXT("project. To add library paths to a project path, first specify the project path, then add the ")
		TEXT("library paths in the immediate following lines. Specifying the same library for several ")
		TEXT("projects will not cause additional performance penalties.\r\n")
		TEXT("NOTE: The maximum number of unique project paths is currently limited ")
		TEXT("to 64 and they must not overlap (CCompletion will detect this and will warn you).\r\n")
		TEXT("\r\n")
		TEXT("If a project path is prefixed with '&', it is parsed recursively and will also ")
		TEXT("include identifiers from subdirectories. This also goes for library paths, so you ")
		TEXT("must add '&' if you want them to parse recursively (for example \"@&c:\\gcc\\include\"). ")
		TEXT("If you specify the same project several ")
		TEXT("times, only the first definition will decide if it is parsed recursively.\r\n")
		TEXT("\r\n")
		TEXT("When CCompletion is triggered in a file that isn't located within one of the project directories, ")
		TEXT("CCompletion automatically creates \"") CTAGSFILENAME TEXT("\" in the directory where ")
		TEXT("the file is located. All the files in the directory 'see' all the identifiers of that directory and ")
		TEXT("subdirectories.\r\n")
		TEXT("\r\n")
		TEXT("6. If identifier grouping is enabled, you can use RIGHT and LEFT to quickly expand / collapse groups. ")
		TEXT("You can set the separating character for groups by manually editing the first character in settings file. ")
		TEXT("Default: '_'. ")
		TEXT("Name your identifiers accordingly, for example: \"GUI_Create_Button()\". This would group all begining ")
		TEXT("with \"GUI_\" and then all begining with \"Create_\".\r\n")
		TEXT("\r\n")
		TEXT("7. Both views have an independent history record (up to 128 entries each), that holds entries for ")
		TEXT("all go-to-identifier actions. You can also add ")
		TEXT("an entry explicitly (bookmark functionality). Use the shortcuts to move through history entries. ")
		TEXT("History only lasts until you close Notepad++.\r\n")
		TEXT("\r\n")
		TEXT("8. Snippets are inserted according to the word to the left of the caret. They apply to C syntax and ")
		TEXT("are not configurable. Valid keywords are: ")
		TEXT("0, 1, a, b, c, cb, cr, crv, d, db, dr, drv, e, f, g, i, n, r, rv, s, t, ts, te, v, w. ")
		TEXT("If the keyword is ')' or ':', the rest of the current line is moved to a compound. ")
		TEXT("\"&&\" and \"||\" build multiline boolean logic. '?' builds fully bracketed conditional expression. ")
		TEXT("\"(<caret>)\" inserts another brackets: \"((<caret>))\".\r\n")
		TEXT("The snippets are not the main functionality of this plugin and were left included just in case you would ")
		TEXT("find them useful.\r\n")
	;
	
	HANDLE h = GetModuleHandle(CCOMPLETION_DLL_FILENAME);
	if (NULL == h)
	{
		MessageBox(owner, msg, MSG_TITLE, MB_OK);
	}
	else
	{
		DialogBoxParam((HINSTANCE)h, MAKEINTRESOURCE(IDD_HELP_DIALOG), owner, &HelpDialogProcedure, (LPARAM)msg);
	}
}

static void showAbout(HWND owner)
{
	MessageBox(owner,
		TEXT("CCompletion 1.19 (") TEXT(__DATE__) TEXT(") ")
		TEXT("for Notepad++ v5.3.1 (or later)")
#if defined(UNICODE)
		TEXT(" (UNICODE)")
#endif
		TEXT("\n\n")
		TEXT("CCompletion is a code autocompletion plugin.\nIt can display all the identifiers that Exuberant Ctags recognizes.\n")
		TEXT("\n")
		TEXT("This plugin is provided as free software, but WITHOUT ANY WARRANTIES.\n")
		TEXT("This plugin is powered by Exuberant Ctags (http://ctags.sourceforge.net).\n")
		TEXT("\n")
		TEXT("Author: Boštjan Mihorič (ccompletion@gmail.com)\n"),
		
		TEXT("About CCompletion plugin"), MB_OK);
}


static BOOL getCurrentView(void)//returns TRUE if primary view, FALSE if secondary view
{
	int i;
	
	SendMessage(HNPP, NPPM_GETCURRENTSCINTILLA, 0, (LPARAM)&i);
	
	return (i == MAIN_VIEW);
}


static HWND getCurrentScintillaHandle(void)
{
	return (getCurrentView() ? HNPP1 : HNPP2);
}


static IDENT* getIdentAtListIndex(int index)
{
	int i;
	
	if (SendMessage(hwndList, LB_GETCOUNT, 0, 0))
	{
		for (i = 0; i < _identifiers.count; i++)
		{
			if (_identifiers.arr[i].index == index)	return (&_identifiers.arr[i]);
		}
	}
	
	return (NULL);
}

static int getCurrentListIndex()
{
	return SendMessage(hwndList, LB_GETCURSEL, 0, 0);
}

static IDENT* getSelectedIdent(void)
{
	return getIdentAtListIndex(getCurrentListIndex());
}

static BOOL getInputtedNumber(int* outNumber)//vrne TRUE, če uspe dobiti iz dialoga številko
{
	SendMessage(hwndEdit, WM_GETTEXT, (WPARAM)(128-1), (LPARAM)_getStringResult);
	_getStringResult[128-1] = TEXT('\0');
	
	if (1 == _stscanf(_getStringResult, TEXT("%d"), outNumber))
	{
		return (TRUE);
	}
	
	return (FALSE);
}





static BOOL ConvertUnicodeToAnsi(const TCHAR* s, char* buf, int bufLen)
{
	if (_tcslen(s) == 0)
	{
		buf[0] = '\0';
		return (TRUE);
	}
	if (WideCharToMultiByte(CP_ACP, 0, s, -1, buf, bufLen, NULL, NULL))
	{
		buf[bufLen-1] = '\0';
		return (TRUE);
	}
	
	FAILURE(TEXT("failed converting unicode string to ANSI"));
	return (FALSE);
}

static BOOL ConvertAnsiToUnicode(const char* s, TCHAR* buf, int bufLen)
{
	if (strlen(s) == 0)
	{
		buf[0] = TEXT('\0');
		return (TRUE);
	}
	if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED | MB_ERR_INVALID_CHARS, s, -1, buf, bufLen))
	{
		buf[bufLen-1] = TEXT('\0');
		return (TRUE);
	}
	
	FAILURE(TEXT("failed converting ANSI string to unicode"));
	return (FALSE);
}


//unicode wrapper
static void SCINTILA_ReplaceSel(HWND hwnd, const TCHAR* str)
{
	int len = _tcslen(str);
	char* buf = NULL;
	if (!(buf = (char*)malloc(sizeof(char)*(len+1))))
	{
		return;
	}
	if (!ConvertUnicodeToAnsi(str, buf, len+1))
	{
		goto DONE;
	}
	SendMessage(hwnd, SCI_REPLACESEL, 0, (LPARAM)buf);
	
DONE:
	free(buf);
}

// že pred klicem je potrebno preveriti, da je buffer dovolj velik!
static void SCINTILA_GetSelText(HWND hwnd, TCHAR* buf)
{
	int lengthRequired = SendMessage(hwnd, SCI_GETSELTEXT, 0, (LPARAM)NULL);
	char* bufTemp = NULL;
	if (!(bufTemp = (char*)malloc(sizeof(char)*lengthRequired)))
	{
		buf[0] = TEXT('\0');
		return;
	}
	SendMessage(hwnd, SCI_GETSELTEXT, 0, (LPARAM)bufTemp);
	if (!ConvertAnsiToUnicode(bufTemp, buf, lengthRequired))
	{
		buf[0] = TEXT('\0');
		return;
	}
}

//vrne length read
static int SCINTILLA_GetTextRange(HWND hwnd, int i1, int i2, TCHAR* buf)
{
	char* bufTemp = NULL;
	if (!(bufTemp = (char*)malloc(sizeof(char)*(i2 - i1 + 1))))
	{
		buf[0] = TEXT('\0');
		return (0);
	}
	TextRange tr = {(CharacterRange){i1, i2}, bufTemp};
	int lengthRead = SendMessage(hwnd, SCI_GETTEXTRANGE, 0, (LPARAM)&tr);
	bufTemp[i2 - i1] = '\0';
	if (!ConvertAnsiToUnicode(bufTemp, buf, i2 - i1 + 1))
	{
		buf[0] = TEXT('\0');
		return (0);
	}
	return (lengthRead);
}


static TCHAR SCINTILLA_GetCharAt(HWND hwnd, int i)
{
	char c = SendMessage(hwnd, SCI_GETCHARAT, (WPARAM)(i), 0);
	char bufTemp[2] = {c, '\0'};
	TCHAR buf[2];
	ConvertAnsiToUnicode(bufTemp, buf, 2);
	return (buf[0]);
}




static void printViewInfo()
{
	TCHAR tmp[500];
	_sntprintf(tmp, 500, TEXT("NPPM_GETCURRENTDOCINDEX with MAIN_VIEW: %d\n")
			TEXT("NPPM_GETCURRENTDOCINDEX with SUB_VIEW: %d\n")
			TEXT("NPPM_GETNBOPENFILES with ALL_OPEN_FILES: %d\n")
			TEXT("NPPM_GETNBOPENFILES with PRIMARY_VIEW: %d\n")
			TEXT("NPPM_GETNBOPENFILES with SECOND_VIEW: %d\n")
			, (int)SendMessage(HNPP, NPPM_GETCURRENTDOCINDEX, 0, (LPARAM)(MAIN_VIEW))
			, (int)SendMessage(HNPP, NPPM_GETCURRENTDOCINDEX, 0, (LPARAM)(SUB_VIEW))
			, (int)SendMessage(HNPP, NPPM_GETNBOPENFILES, 0, (LPARAM)(ALL_OPEN_FILES))
			, (int)SendMessage(HNPP, NPPM_GETNBOPENFILES, 0, (LPARAM)(PRIMARY_VIEW))
			, (int)SendMessage(HNPP, NPPM_GETNBOPENFILES, 0, (LPARAM)(SECOND_VIEW)));
	FAILURE(tmp);
}





static BOOL isViewOpened(BOOL primaryView)
{
	return (-1 != SendMessage(HNPP, NPPM_GETCURRENTDOCINDEX, 0, (LPARAM)(primaryView ? MAIN_VIEW : SUB_VIEW)));
}





// vrne -1, če datoteka ni odprta, vrne -2, če je število odprtih datotek 0 (torej view ni odprt)
static int indexOfFileOpenedInView(TCHAR* file, BOOL primaryView)
{
	if (!isViewOpened(primaryView))	return -2;
	
	int i, numFilled;
	int nbFile = (int)::SendMessage(HNPP, NPPM_GETNBOPENFILES, 0, (LPARAM)(primaryView ? PRIMARY_VIEW : SECOND_VIEW));
	
	
	//if (nbFile <= 0)	return -2;
	
	//::MessageBox(nppData._nppHandle, itoa(nbFile, toto, 10), TEXT("nb opened files"), MB_OK);
	
	// deluje samo C++, C array sesuje vse skupaj??
	TCHAR **fileNames = (TCHAR **)new TCHAR*[nbFile];
	for (int j = 0 ; j < nbFile ; j++)
	{
		fileNames[j] = new TCHAR[MAX_PATH];
	}

	if ((numFilled = ::SendMessage(
		HNPP
		, primaryView ? NPPM_GETOPENFILENAMESPRIMARY : NPPM_GETOPENFILENAMESSECOND
		, (WPARAM)fileNames
		, (LPARAM)nbFile)))
	{
		for (i = numFilled; i--;)
		{
/**
v5.0.3: NPPM_GETNBOPENFILES vrne 1 tudi če je view zaprt (!). Dobljeno ime se spreminja vsakič, ko se view odpre in spet zapre: "new 1", "new 2"
*/

			if (lstrcmpi(file, fileNames[i]) == 0)	break;
		}
		//::MessageBox(nppData._nppHandle, itoa(numFiles, toto, 10), TEXT("num open files"), MB_OK);
	}
	else
	{
		FAILURE(TEXT("failed getting opened files list"));
		i = 0;
	}

	for (int j = 0 ; j < nbFile ; j++)
	{
		delete [] fileNames[j];
	}
	delete [] fileNames;
	
	return i; // -1, če se je zanka odvrtela
	
}



static void goToLineView(int lineNum, BOOL primaryView)
{
	HWND scintilla = (primaryView ? HNPP1 : HNPP2);
	
	// nastavi pravo vrstico
	SendMessage(scintilla, SCI_GOTOLINE, (WPARAM)lineNum, 0);
	
	// premakne, da je vrstica na vrhu
	int firstVisibleLine = SendMessage(scintilla, SCI_GETFIRSTVISIBLELINE, 0, 0);
	SendMessage(scintilla, SCI_LINESCROLL, 0, lineNum - firstVisibleLine);
}



static void gotoLineOfView(
	BOOL targetView
	, TCHAR* fullpath
	, int lineNum
	, BOOL saveHistory
	, BOOL insertHistoryAfterCurrent
	, BOOL forceOpenView)//če TRUE, odpre view tudi če še ni odprt
{
//printViewInfo();
	BOOL currentView = getCurrentView();//TRUE za primary, FALSE za secondary, kot običajno
	int currentIndexPrimaryView = SendMessage(HNPP, NPPM_GETCURRENTDOCINDEX, 0, (LPARAM)MAIN_VIEW);
	int currentIndexSecondaryView = SendMessage(HNPP, NPPM_GETCURRENTDOCINDEX, 0, (LPARAM)SUB_VIEW);
	
	
	if ((!forceOpenView) && (!isViewOpened(targetView)))	return;
	if (saveHistory && isViewOpened(targetView))		pushHistoryEntry(targetView, insertHistoryAfterCurrent);
	
	/// nimam še novih headerjev, zato so potrebne ročne čarovnije
	#define SCINTILLA_USER (WM_USER + 2000) 
	#define WM_DOOPEN (SCINTILLA_USER + 8) 
	
	
	int index;
	
	// če datoteka še ni odprta
	if (((index = indexOfFileOpenedInView(fullpath, !targetView)) < 0)
		&& ((index = indexOfFileOpenedInView(fullpath, targetView)) < 0))
	{
		// če je target view že odprt, se lahko preklopi nanj, da se bo datoteka odprla tam,
		// sicer pa bo potrebno odpiranje datoteke na primary view in kloniranje... če view še ni
		// odprt, bi funkcija vrnila -2 in ne -1
		if (index == -1)	SendMessage(HNPP, NPPM_ACTIVATEDOC, targetView ? MAIN_VIEW : SUB_VIEW, 0);
		
		// odpre datoteko
		SendMessage(HNPP, WM_DOOPEN, 0, (LPARAM)fullpath);
	}
	
	// če je datoteka odprta v target view, se preklopi nanjo in focusira na vrstico
	if ((index = indexOfFileOpenedInView(fullpath, targetView)) >= 0)
	{
		SendMessage(HNPP, NPPM_ACTIVATEDOC, targetView ? MAIN_VIEW : SUB_VIEW, index);
		goToLineView(lineNum, targetView);
	}
	// sicer če je datoteka že odprta v other view, se jo klonira v target view
	else if ((index = indexOfFileOpenedInView(fullpath, !targetView)) >= 0)
	{
		SendMessage(HNPP, NPPM_ACTIVATEDOC, targetView ? SUB_VIEW : MAIN_VIEW, index);
		SendMessage(HNPP, NPPM_MENUCOMMAND, 0, (LPARAM)IDM_VIEW_CLONE_TO_ANOTHER_VIEW);
		goToLineView(lineNum, targetView);
	}
	
	if (targetView != currentView)
	{
		SendMessage(HNPP, NPPM_ACTIVATEDOC,
			currentView ? MAIN_VIEW : SUB_VIEW,
			currentView ? currentIndexPrimaryView : currentIndexSecondaryView);
	}
	
	if (saveHistory && isViewOpened(targetView))	pushHistoryEntry(targetView, insertHistoryAfterCurrent);
}



static void setCurrentListIndex(int i, BOOL lookupIdentifier)
{
	SendMessage(hwndList, LB_SETCURSEL, (WPARAM)max(0, i), 0);
	//SendMessage(hwndList, LB_SETTOPINDEX, (WPARAM)max(0, i), 0);
}



static BOOL getCurrentFilePathForView(HWND view, TCHAR* buf)	// vrne FALSE v primeru, da odprtih datotek ni bilo (potem ni zgodovine)
{
	TCHAR **fileNames;
	int numFilled;
	BOOL isPrimaryView = (view == HNPP1);
	int nbFile = (int)::SendMessage(HNPP, NPPM_GETNBOPENFILES, 0, (LPARAM)(isPrimaryView ? PRIMARY_VIEW : SECOND_VIEW));
	int activeIndex = SendMessage(HNPP, NPPM_GETCURRENTDOCINDEX, 0, (LPARAM)(isPrimaryView ? MAIN_VIEW : SUB_VIEW));
	
	if (activeIndex == -1)	goto FAIL1;
	
	//::MessageBox(nppData._nppHandle, itoa(nbFile, toto, 10), TEXT("nb opened files"), MB_OK);
	
	// deluje samo C++, C array sesuje vse skupaj??
	fileNames = (TCHAR **)new TCHAR*[nbFile];
	for (int j = 0 ; j < nbFile ; j++)
	{
		fileNames[j] = new TCHAR[MAX_PATH];
	}

	if ((numFilled = ::SendMessage(HNPP, isPrimaryView ? NPPM_GETOPENFILENAMESPRIMARY : NPPM_GETOPENFILENAMESSECOND,
		 (WPARAM)fileNames, (LPARAM)nbFile))
		 && (numFilled > activeIndex))
	{
		_tcscpy(buf, fileNames[activeIndex]);
		//::MessageBox(nppData._nppHandle, itoa(numFiles, toto, 10), TEXT("num open files"), MB_OK);
	}
	else
	{
		FAILURE(TEXT("failed getting opened files list 2"));
		goto FAIL2;
	}

	
	for (int j = 0 ; j < nbFile ; j++)
	{
		delete [] fileNames[j];
	}
	delete [] fileNames;
	
	return TRUE;
	
	
	FAIL2:
	
	for (int j = 0 ; j < nbFile ; j++)
	{
		delete [] fileNames[j];
	}
	delete [] fileNames;
	
	FAIL1:
	
	buf[0] = TEXT('\0');
	return FALSE;
}


static void gotoLineOfViewByIdent(
	BOOL targetView
	, IDENT* ident
	, BOOL saveHistory
	, BOOL insertHistoryAfterCurrent
	, BOOL forceOpenView)//če TRUE, odpre view tudi če še ni odprt
{
	//preverjanje ali je potrebno namesto tega na alternative
	
	//get current filename (in target view) - if not found, no file opened yet
	TCHAR currentFilename[MAX_PATH];
	getCurrentFilePathForView(targetView ? HNPP1 : HNPP2, currentFilename);
	
	//get current line number
	int pos = SendMessage(targetView ? HNPP1 : HNPP2, SCI_GETCURRENTPOS, 0, 0);
	int currentLineNum = SendMessage(targetView ? HNPP1 : HNPP2, SCI_LINEFROMPOSITION, (WPARAM)pos, 0);
	
	//if compares, goto alternate filename and line
	//FAILURE(TEXT("ident: %s, current: %s"), ident->filename, currentFilename);
	if ((ident->alternativeFilename)
		&& ((int)(ident->lineNum) == currentLineNum)
		&& (0 == lstrcmpi(ident->filename, currentFilename)))
	{
		//FAILURE(TEXT("alternative going to view %d: %s, %d (current IDENT is %s, %d)"), targetView, ident->alternativeFilename, ident->alternativeLineNum, ident->filename, ident->lineNum);
		gotoLineOfView(targetView, ident->alternativeFilename, ident->alternativeLineNum, saveHistory, insertHistoryAfterCurrent, forceOpenView);
	}
	else
	{
		//FAILURE(TEXT("normal going to view %d: %s, %d"), targetView, ident->filename, ident->lineNum);
		gotoLineOfView(targetView, ident->filename, ident->lineNum, saveHistory, insertHistoryAfterCurrent, forceOpenView);
	}
}






static void deleteCurrentHistoryEntry(BOOL primaryView, BOOL gotoNewCurrentIdentifier)
{
	HISTORY* h = primaryView ? _history1 : _history2;
	int* i = primaryView ? &_histIndex1 : &_histIndex2;//index kaže na trenutni element, če je invalid, je zgodovina prazna
	
	h[*i].isValid = FALSE;
	
	if (*i < (MAX_HISTORY-1))
	{
		memmove(&h[*i], &h[*i + 1], sizeof(HISTORY)*(MAX_HISTORY-1-(*i)));
		h[MAX_HISTORY-1].isValid = FALSE;
	}
	
	if ((!h[*i].isValid) && (*i > 0))	*i -= 1;
	
	if (gotoNewCurrentIdentifier && h[*i].isValid)
	{
		gotoLineOfView(primaryView, h[*i].filename, h[*i].lineNum, FALSE, TRUE, FALSE);
	}
}


// odstrani iz zgodovine duplikate, index ohrani na trenutnem elementu
static void checkHistoryForDuplicates(BOOL primaryView)
{
	HISTORY* h = primaryView ? _history1 : _history2;
	int* i = primaryView ? &_histIndex1 : &_histIndex2;//index kaže na trenutni element, če je invalid, je zgodovina prazna
	
	int j;
	for (j = MAX_HISTORY - 1; j--;)
	{
		if (h[j].isValid
			&& h[j + 1].isValid
			&& (0 == StrCmpI(h[j].filename, h[j + 1].filename))
			&& (h[j].lineNum == h[j + 1].lineNum))
		{
			if ((j == (*i)) || ((j + 1) == (*i)))
			{
				deleteCurrentHistoryEntry(primaryView, FALSE);
				*i = j;
			}
			else if (j < (*i))
			{
				int tmp = *i;
				*i = j;
				deleteCurrentHistoryEntry(primaryView, FALSE);
				*i = tmp - 1;
			}
			else
			{
				int tmp = *i;
				*i = j;
				deleteCurrentHistoryEntry(primaryView, FALSE);
				*i = tmp;
			}
		}
	}
}


static void pushHistoryEntry(
	BOOL primaryView,	// če FALSE, gre za SUB_VIEW
	BOOL insertAfterCurrent)//če FALSE, zrine naprej tudi trenutni objekt
{
	HISTORY* h = primaryView ? _history1 : _history2;
	int* i = primaryView ? &_histIndex1 : &_histIndex2;//index kaže na trenutni element, če je invalid, je zgodovina prazna
	
	if (*i >= (MAX_HISTORY-1)) // če history poln, izrinemo prvi vnos iz zgodovine
	{
		*i = MAX_HISTORY-1;
		memmove(h, &h[1], sizeof(HISTORY)*(MAX_HISTORY-1));
		h[MAX_HISTORY-1].isValid = FALSE;
	}
	else if (h[*i].isValid)	// (če !isValid, gre za prvi vnos)
	{		
		// če ne vnašamo zadnjega elementa, zrinemo sledeče vnose naprej
		if (insertAfterCurrent)	*i += 1;
		memmove(&h[*i + 1], &h[*i], sizeof(HISTORY)*(MAX_HISTORY-1-(*i)));
	}
	
	// dobi path datoteke
	if (!getCurrentFilePathForView(primaryView ? HNPP1 : HNPP2, h[*i].filename))
	{
		FAILURE(TEXT("history function failure..."));
		memset(_history1, 0, sizeof(HISTORY)*MAX_HISTORY);
		_histIndex1 = 0;
		memset(_history2, 0, sizeof(HISTORY)*MAX_HISTORY);
		_histIndex2 = 0;
		return;
	}
	
	// dobi št. vrstice
	int pos = SendMessage(primaryView ? HNPP1 : HNPP2, SCI_GETCURRENTPOS, 0, 0);
	int line = SendMessage(primaryView ? HNPP1 : HNPP2, SCI_LINEFROMPOSITION, (WPARAM)pos, 0);
	h[*i].lineNum = line;
	h[*i].isValid=TRUE;
	
	
	checkHistoryForDuplicates(primaryView);
}




static void gotoCurrentHistoryEntry(BOOL primaryView)
{
	HISTORY* h = primaryView ? _history1 : _history2;
	int* i = primaryView ? &_histIndex1 : &_histIndex2;//index kaže na trenutni element, če je invalid, je zgodovina prazna
	
	if (!(h[*i].isValid))	return;//potem je zgodovina prazna
	
	gotoLineOfView(primaryView, h[*i].filename, h[*i].lineNum, FALSE, FALSE, FALSE);
}


static void gotoPreviousHistoryEntry(BOOL primaryView)
{
	HISTORY* h = primaryView ? _history1 : _history2;
	int* i = primaryView ? &_histIndex1 : &_histIndex2;//index kaže na trenutni element, če je invalid, je zgodovina prazna
	
	if (!(h[*i].isValid))	return;//potem je zgodovina prazna
	
	int i2 = MAX(0, *i - 1);
	
	gotoLineOfView(primaryView, h[i2].filename, h[i2].lineNum, TRUE, FALSE, FALSE);
}


static void gotoNextHistoryEntry(BOOL primaryView)
{
	HISTORY* h = primaryView ? _history1 : _history2;
	int* i = primaryView ? &_histIndex1 : &_histIndex2;//index kaže na trenutni element, če je invalid, je zgodovina prazna
	
	if (!(h[*i].isValid))		return;//prazna zgodovina
	
	int i2 = *i;
	if ((i2 < (MAX_HISTORY-1)) && (h[i2 + 1].isValid))	i2++;
	
	gotoLineOfView(primaryView, h[i2].filename, h[i2].lineNum, TRUE, TRUE, FALSE);
}


// Warning! this regex parser is reluctant and possessive. Not recommended for use elsewhere!
static BOOL regexMatch(TCHAR* regEx, TCHAR* string)
{
	unsigned int i, n = 0, r = 0, groupLen;	// skupina naj bo >= 1 znakov v regEx, ki jih omejujejo začetek, konec in znaki TEXT('*')
	BOOL star = FALSE;
	TCHAR c;
	unsigned int stringLength = _tcslen(string);
	
	for (;;)
	{
		switch (regEx[r])
		{
			case TEXT('\0'):
			{
				return (star || (n >= stringLength));
			}
			break;
			
			case TEXT('*'):
			{
				r++;
				star = TRUE;
			}
			break;
			
			// najdena je bila skupina
			default:
			{
				groupLen = 0;
				
				// ugotovi dolžino skupine
				do
				{
					groupLen++;
					c = regEx[r + groupLen];
				}
				while ((c != TEXT('\0')) && (c != TEXT('*')));
				
				while ((n + groupLen) <= stringLength)
				{
					for (i = groupLen; i--;)
					{
						if ((regEx[r + i] != TEXT('?'))
							&& (_totlower(regEx[r + i]) != _totlower(string[n + i])))
						{
							// če pred skupino ni bilo znaka '*', neujemanje takoj vrne rezultat
							if (!star)	return (FALSE);
							
							n++;
							break;
						}
					}
					
					// preveri, ali se je zanka uspešno odvrtela
					if (i == (unsigned int)-1)	break;
				}
				
				if ((n += groupLen) > stringLength)	return (FALSE);
				
				r += groupLen;
				star = FALSE;
			}
		}
	}
}






static BOOL parseLine(
	IDENTIFIERS* ids,
	TCHAR* line,
	const TCHAR* baseDirPath)//either PROJECT.path or, if not a project, the base path of current ctags.tmp file
{
	int len;
	BOOL skipPreviousTag = FALSE;
	TCHAR tag[128];
	TCHAR filename[MAX_PATH];
	TCHAR tagType[16];
	int i;
	int tagLen;
	
	// prazen string ali pa ko se začne s komentarjem (format ctags.tmp)
	if (line[0] == TEXT('\0') || line[0] == TEXT('!')) return TRUE;
	
	// doda prostor
	if ((ids->count == ids->capacity)
		&& (!IdentifiersExpand(ids)))
	{
		return FALSE;
	}
	
	ids->arr[ids->count].tag = NULL;
	ids->arr[ids->count].filename = NULL;
	ids->arr[ids->count].alternativeFilename = NULL;
	
	// tag
	if (_stscanf(line, TEXT("%128s"), tag) != 1)
	{
		if (_ignoreInvalidTagsAndContinueParsing)
		{
			goto parseLine_IGNORE;
		}
		else
		{
			FAILURE(TEXT("invalid ctags file format 1"));
			goto FAIL;
		}
	}
	tag[128-1] = TEXT('\0');
	tagLen = _tcslen(tag);
	if (!(ids->arr[ids->count].tag = (TCHAR*)malloc((tagLen+1)*sizeof(TCHAR))))
	{
		FAILURE(TEXT("could not allocate memory"));
		goto FAIL;
	}
	memcpy(ids->arr[ids->count].tag, tag, (tagLen+1)*sizeof(TCHAR));
	
	
	// ker so lahko imena datotek s presledki, je potrebno to sparsati na drug način
	while (line[0] != TEXT('\t'))
	{
		if (line[0] == TEXT('\0'))
		{
			if (_ignoreInvalidTagsAndContinueParsing)
			{
				goto parseLine_IGNORE;
			}
			else
			{
				FAILURE(TEXT("invalid ctags file format 2"));
				goto FAIL;
			}
		}
		
		line++;
	}
	
	//filename (fullpath)
	_tcscpy(filename, baseDirPath);
	i = _tcslen(filename);
	filename[i] = TEXT('\\');
	
	do
	{
		line++;
		i++;
		filename[i] = *line;
	}
	while (((*line) != TEXT('\t')) && (i < (MAX_PATH-1)));
	
	filename[i] = TEXT('\0');
	if (!(ids->arr[ids->count].filename = (TCHAR*)malloc((i+1)*sizeof(TCHAR))))
	{
		FAILURE(TEXT("could not allocate memory"));
		goto FAIL;
	}
	memcpy(ids->arr[ids->count].filename, filename, (i+1)*sizeof(TCHAR));
	
	
	while (line[0] != TEXT('\t'))
	{
		if (line[0] == TEXT('\0'))
		{
			if (_ignoreInvalidTagsAndContinueParsing)
			{
				goto parseLine_IGNORE;
			}
			else
			{
				FAILURE(TEXT("invalid ctags file format 3"));
				goto FAIL;
			}
		}
		
		line++;
	}
	
	// line number in tag type
	if (_stscanf(line, TEXT("%u;\"\t%16s"),
		&ids->arr[ids->count].lineNum,
		tagType) != 2)
	{
		if (_ignoreInvalidTagsAndContinueParsing)
		{
			goto parseLine_IGNORE;
		}
		else
		{
			FAILURE(TEXT("invalid ctags file format 4"));
			goto FAIL;
		}
	}
	// Scintilla ima 0-based line number, zato se takoj prevede
	ids->arr[ids->count].lineNum -= 1;
	
	if (!_tcscmp(tagType, STR_macro))
	{
		ids->arr[ids->count].tagType = STR_macro;
		ids->arr[ids->count].tagTextColor = RGB(0, 0, 255);
		
		// is macro function-like?
		if (NULL != _tcsstr(line, TEXT("\tfunlike:")))
		{
			ids->arr[ids->count].flags |= FLAG_IS_FUNCTION_LIKE;
		}
	}
	else if (!_tcscmp(tagType, STR_function))
	{
		ids->arr[ids->count].tagType = STR_function;
		ids->arr[ids->count].tagTextColor = RGB(255, 0, 0);
		ids->arr[ids->count].flags |= FLAG_IS_FUNCTION_LIKE;
	}
	else if (!_tcscmp(tagType, STR_prototype))
	{
		ids->arr[ids->count].tagType = STR_prototype;
		ids->arr[ids->count].tagTextColor = RGB(255, 0, 0);
		ids->arr[ids->count].flags |= FLAG_IS_FUNCTION_LIKE;
	}
	else if (!_tcscmp(tagType, STR_method))
	{
		ids->arr[ids->count].tagType = STR_method;
		ids->arr[ids->count].tagTextColor = RGB(255, 0, 0);
		ids->arr[ids->count].flags |= FLAG_IS_FUNCTION_LIKE;
	}
	else if (!_tcscmp(tagType, STR_variable))
	{
		ids->arr[ids->count].tagType = STR_variable;
		ids->arr[ids->count].tagTextColor = RGB(0, 96, 0);
	}
	else if (!_tcscmp(tagType, STR_externvar))
	{
		ids->arr[ids->count].tagType = STR_externvar;
		ids->arr[ids->count].tagTextColor = RGB(0, 96, 0);
	}
	else if (!_tcscmp(tagType, STR_local))
	{
		ids->arr[ids->count].tagType = STR_local;
		ids->arr[ids->count].tagTextColor = RGB(0, 96, 0);
	}
	else if (!_tcscmp(tagType, STR_struct))
	{
		ids->arr[ids->count].tagType = STR_struct;
		ids->arr[ids->count].tagTextColor = RGB(128, 0, 255);
	}
	else if (!_tcscmp(tagType, STR_typedef))
	{
		ids->arr[ids->count].tagType = STR_typedef;
		ids->arr[ids->count].tagTextColor = RGB(128, 0, 255);
	}
	else if (!_tcscmp(tagType, STR_enumerator))
	{
		ids->arr[ids->count].tagType = STR_enumerator;
		ids->arr[ids->count].tagTextColor = RGB(128, 0, 255);
	}
	else if (!_tcscmp(tagType, STR_enum))
	{
		ids->arr[ids->count].tagType = STR_enum;
		ids->arr[ids->count].tagTextColor = RGB(128, 0, 255);
	}
	else if (!_tcscmp(tagType, STR_union))
	{
		ids->arr[ids->count].tagType = STR_union;
		ids->arr[ids->count].tagTextColor = RGB(128, 0, 255);
	}
	else if (!_tcscmp(tagType, STR_member))
	{
		ids->arr[ids->count].tagType = STR_member;
		ids->arr[ids->count].tagTextColor = RGB(0, 0, 0);
	}
	else if (!_tcscmp(tagType, STR_namespace))
	{
		ids->arr[ids->count].tagType = STR_namespace;
		ids->arr[ids->count].tagTextColor = RGB(0, 0, 0);
	}
	else if (!_tcscmp(tagType, STR_class))
	{
		ids->arr[ids->count].tagType = STR_class;
		ids->arr[ids->count].tagTextColor = RGB(0, 0, 0);
	}
	else
	{
		ids->arr[ids->count].tagType = TEXT("?");
		ids->arr[ids->count].tagTextColor = COLOR_TEXT;
	}
	
	
	// prepreči podvojevanje vnosov v primeru struct/typedef parov - pri enakem imenu v tem primeru obdrži samo struct
	// kasneje dodano, da to velja tudi za enum/typedef, le da tu ni nujno typedef kasneje, ker sta oba v isti vrstici
	skipPreviousTag = FALSE;
	if (_skipTypedefWhenSameNameStructPreceedesIt
		&& (ids->count > 0)
		&& (_tcscmp(ids->arr[ids->count - 1].tag, ids->arr[ids->count].tag) == 0))
	{
		// če je typedef, se samo izpusti trenutni tag, sicer je potrebno tag vpisati v prejšnjega
		if ((ids->arr[ids->count].tagType == STR_typedef)
			&& ((ids->arr[ids->count - 1].tagType == STR_struct)
				|| (ids->arr[ids->count - 1].tagType == STR_enum)))
		{
			goto parseLine_IGNORE;
		}
		else if ((ids->arr[ids->count - 1].tagType == STR_typedef)
			&& ((ids->arr[ids->count].tagType == STR_struct)
				|| (ids->arr[ids->count].tagType == STR_enum)))
		{
			skipPreviousTag = TRUE;
		}
	}
	
	// prepreči podvojevanje vnosov v primeru prototype/function parov - pri enakem imenu obdrži samo prototype
	if (_skipFunctionWhenSameNamePrototypePreceedesIt
		&& (ids->count > 0)
		&& (_tcscmp(ids->arr[ids->count - 1].tag, ids->arr[ids->count].tag) == 0))
	{
		// also set alternative filename and line number, to enable goto both
		if ((ids->arr[ids->count].tagType == STR_function)
			&& (ids->arr[ids->count - 1].tagType == STR_prototype))
		{
			ids->arr[ids->count - 1].alternativeLineNum = ids->arr[ids->count].lineNum;
			ids->arr[ids->count - 1].alternativeFilename = ids->arr[ids->count].filename;
			ids->arr[ids->count].filename = NULL;
			//FAILURE(TEXT("created IDENT (%s, %d)\nalt (%s, %d)"), ids->arr[ids->count - 1].filename, ids->arr[ids->count - 1].lineNum, ids->arr[ids->count - 1].alternativeFilename, ids->arr[ids->count - 1].alternativeLineNum);
			goto parseLine_IGNORE;
		}
		else if ((ids->arr[ids->count - 1].tagType == STR_function)
			&& (ids->arr[ids->count].tagType == STR_prototype))
		{
			ids->arr[ids->count].alternativeLineNum = ids->arr[ids->count - 1].lineNum;
			ids->arr[ids->count].alternativeFilename = ids->arr[ids->count - 1].filename;
			ids->arr[ids->count - 1].filename = NULL;
			//FAILURE(TEXT("created IDENT (%s, %d)\nalt (%s, %d)"), ids->arr[ids->count].filename, ids->arr[ids->count].lineNum, ids->arr[ids->count].alternativeFilename, ids->arr[ids->count].alternativeLineNum);
			skipPreviousTag = TRUE;
		}
	}
	
	// še posebno shranjevanje tag-ov v primeru memberjev
	if ((ids->arr[ids->count].tagType == STR_member)
		|| (ids->arr[ids->count].tagType == STR_enumerator))
	{
		while (line[0] != TEXT(':'))
		{
			if (line[0] == TEXT('\0'))
			{
				if (_ignoreInvalidTagsAndContinueParsing)
				{
					goto parseLine_IGNORE;
				}
				else
				{
					FAILURE(TEXT("invalid ctags file format 5"));
					goto FAIL;
				}
			}
			
			line++;
		}
		
		if (_stscanf(line, TEXT(":%128s"), tag) != 1)
		{
			if (_ignoreInvalidTagsAndContinueParsing)
			{
				goto parseLine_IGNORE;
			}
			else
			{
				FAILURE(TEXT("invalid ctags file format 6"));
				goto FAIL;
			}
		}
		
		len = _tcslen(tag);
		int len2 = _tcslen(ids->arr[ids->count].tag);
		TCHAR* tag2;
		if (!(tag2 = (TCHAR*)malloc((len + len2 + 2)*sizeof(TCHAR))))
		{
			FAILURE(TEXT("could not allocate memory"));
			goto FAIL;
		}
		memcpy(tag2, tag, (len)*sizeof(TCHAR));
		tag2[len] = TEXT('.');
		memcpy(tag2 + len + 1, ids->arr[ids->count].tag, (len2)*sizeof(TCHAR));
		tag2[len + len2 + 1] = TEXT('\0');
		free(ids->arr[ids->count].tag);
		ids->arr[ids->count].tag = tag2;
	}
	
	// določi, ali je tag internal
	if (_doNotShowOutOfScopeIdentifiers
		&& (NULL != _tcsstr(line, TEXT("\tfile:"))))
	{
		// Any tag which is located in a non-include file and cannot be seen (e.g. linked to) from another file is considered to have file-limited (e.g. static) scope.
		ids->arr[ids->count].flags |= FLAG_IS_INTERNAL;
	}
	
	// določi, ali je macro function-like
	if (_doNotShowOutOfScopeIdentifiers
		&& (NULL != _tcsstr(line, TEXT("\tfile:"))))
	{
		// Any tag which is located in a non-include file and cannot be seen (e.g. linked to) from another file is considered to have file-limited (e.g. static) scope.
		ids->arr[ids->count].flags |= FLAG_IS_INTERNAL;
	}
	
	
	ids->arr[ids->count].tagStrLen = _tcslen(ids->arr[ids->count].tag);
	
	if (skipPreviousTag)
	{
		if (ids->arr[ids->count - 1].tag)			free(ids->arr[ids->count - 1].tag);
		if (ids->arr[ids->count - 1].filename)		free(ids->arr[ids->count - 1].filename);
		if (ids->arr[ids->count - 1].alternativeFilename)	free(ids->arr[ids->count - 1].alternativeFilename);
		memcpy(&ids->arr[ids->count - 1], &ids->arr[ids->count], sizeof (IDENT));
		ids->arr[ids->count].tag = NULL;
		ids->arr[ids->count].filename = NULL;
	}
	else
	{
		ids->count++;
	}
	
	return TRUE;
	
FAIL:
	if (ids->arr[ids->count].tag)
	{
		free(ids->arr[ids->count].tag);
		ids->arr[ids->count].tag = NULL;
	}
	if (ids->arr[ids->count].filename)
	{
		free(ids->arr[ids->count].filename);
		ids->arr[ids->count].filename = NULL;
	}
	if (ids->arr[ids->count].alternativeFilename)
	{
		free(ids->arr[ids->count].alternativeFilename);
		ids->arr[ids->count].alternativeFilename = NULL;
	}
	return (FALSE);

//nekdo je definiral IGNORE... grozljivka
parseLine_IGNORE:
	if (ids->arr[ids->count].tag)
	{
		free(ids->arr[ids->count].tag);
		ids->arr[ids->count].tag = NULL;
	}
	if (ids->arr[ids->count].filename)
	{
		free(ids->arr[ids->count].filename);
		ids->arr[ids->count].filename = NULL;
	}
	if (ids->arr[ids->count].alternativeFilename)
	{
		free(ids->arr[ids->count].alternativeFilename);
		ids->arr[ids->count].alternativeFilename = NULL;
	}
	return (TRUE);
}






typedef struct THREAD_INFO
{
	BOOL block;	// thread mora v primeru, da ni block, sam klicati CloseHandle()
	TCHAR fullExePath[MAX_PATH];
	TCHAR tmpDirPath[MAX_PATH];
	BOOL recursive;
}
THREAD_INFO;

static volatile HANDLE _hCtagsExeThread = NULL;
static volatile THREAD_INFO _ti;

static DWORD WINAPI CtagsExeThread(
	LPVOID lpParam)
{
	SHELLEXECUTEINFO sei;
	
	/*
	nastavitve za ctags:
	
	--fields=-afiklmsSzt+Kn
	
	-R za rekurzivno skeniranje direktorijev - kdo drug bo gotovo imel kako drugačno strukturo kot jaz
	
	K z besedo pove, kaj to je - to bo uporabno za na listo
	n doda številko vrstice
	lahko se pod + prestavi še f, saj tag TEXT("file:") pove, da ima identifier file-limited scope... vendar tega v bistvu ne potrebujem
	
	--excmd=number <<< s tem se ima številko vrstice vedno namesto tag signature, slednji je itak grozljivka: pojavljali so se
	več KB dolgi podpisi, ki so za nameček pogosto vsebovali newline characterje.
	
	s: pove, kateri strukturi / enumeratorju pripada tag
	
	--c-kinds... <= l za local, p za prototype identifierje
	*/
	TCHAR ctagsParams[2048];
	_sntprintf(ctagsParams, 2048, L"%s%s %s %s", ((_ti.recursive) ? (L"-R ") : (L"")), _ctagsParameters, CTAGSFILENAME, L"*");
	ctagsParams[2047] = L'\0';
	
	memset(&sei, 0, sizeof(SHELLEXECUTEINFO));
	sei.cbSize = sizeof(SHELLEXECUTEINFO);
	sei.fMask = SEE_MASK_FLAG_NO_UI | SEE_MASK_NOCLOSEPROCESS;
	sei.hwnd = NULL;//jasno ta thread ne sme imeti ničesar z GUI, če se poda HWND, vse skupaj deadlocka ko je block TRUE
	sei.lpVerb = TEXT("open");
	sei.lpFile = (TCHAR*)_ti.fullExePath;
	sei.lpParameters = ctagsParams;
	sei.lpDirectory = (TCHAR*)_ti.tmpDirPath;
	sei.nShow = SW_HIDE;
	
	/**
	trenutno je tu problem, da če zagon ctags.exe pade (sporočilo "not enough memory to run..."), se vse skupaj nekako zacikla
	*/
	
	if (!ShellExecuteEx(&sei))	goto FAILURE;
	
	// počaka, da se ctags.exe zaključi
	WaitForSingleObject(sei.hProcess, INFINITE);
	CloseHandle(sei.hProcess);
	
	if (!_ti.block)	CloseHandle(_hCtagsExeThread);
	_hCtagsExeThread = NULL;
	ExitThread(EXIT_SUCCESS);
	
	FAILURE:
	if (!_ti.block)	CloseHandle(_hCtagsExeThread);
	_hCtagsExeThread = NULL;
	ExitThread(EXIT_FAILURE);
}



static BOOL executeCtagsExe(const TCHAR* baseDirPath, BOOL block, BOOL recursive)	// če TRUE, blokira dokler execute ni končan
{
	DWORD threadId;
	HANDLE hThread = _hCtagsExeThread;
	
	//FAILURE(TEXT("reexecuting %s"), baseDirPath);
	
	if (!hThread) // prepreči večkratno vzporedno poganjanje
	{
		// nastavi globalne podatke za thread
		_tcscpy((TCHAR*)_ti.tmpDirPath, baseDirPath);
		if (!getCtagsExePath((TCHAR*)_ti.fullExePath))	return FALSE;
		_ti.block = block;
		_ti.recursive = recursive;
		
		// lansira modulov thread
		if (!(hThread = _hCtagsExeThread = CreateThread(NULL, 0, &CtagsExeThread, NULL, 0, &threadId)))
		{
			FAILURE(TEXT("creating worker thread failed"));
			return FALSE;
		}
	}
	
	if (block)
	{
		WaitForSingleObject(hThread, INFINITE);
	
		DWORD result;
		
		if (!GetExitCodeThread(hThread, &result))
		{
			FAILURE(TEXT("failed getting thread result"));
			CloseHandle(hThread);
			return FALSE;
		}
		else if (result == EXIT_FAILURE)
		{
			FAILURE(TEXT("Failed executing ctags.exe. If you haven't already,\n")
				TEXT("download Exuberant Ctags (http://ctags.sourceforge.net)\n")
				TEXT("and copy ctags.exe to your plugins directory."));
			CloseHandle(hThread);
			return FALSE;
		}
		
		CloseHandle(hThread);
	}
	
	return TRUE;
}


static void calculateLocalVariables(IDENTIFIERS* ids)
{
	int i, j;
	for (i = ids->count; i--; )
	{
		if (ids->arr[i].tagType != STR_local)	continue;
		
		for (j = ids->count; j--; )
		{
			// put into alternativeLineNumber the line at which the local variable is no longer valid
			// note: this is an approximation
			if (ids->arr[j].tagType == STR_function)
			{
				if ((ids->arr[i].lineNum < ids->arr[j].lineNum)
					&& (0 == lstrcmpi(ids->arr[i].filename, ids->arr[j].filename)))
				{
					ids->arr[i].alternativeLineNum = (0 == ids->arr[i].alternativeLineNum)
						? ids->arr[j].lineNum
						: MIN(ids->arr[i].alternativeLineNum, ids->arr[j].lineNum);
				}
			}
			// functions may have been removed if only prototypes are kept, but the function line is written in the
			// prototype's alternativeLineNum in this case, so that's where we get it
			else if ((_skipFunctionWhenSameNamePrototypePreceedesIt)
				&& (ids->arr[j].tagType == STR_prototype))
			{
				if ((ids->arr[i].lineNum < ids->arr[j].alternativeLineNum)
					&& (0 == lstrcmpi(ids->arr[i].filename, ids->arr[j].filename)))
				{
					ids->arr[i].alternativeLineNum = (0 == ids->arr[i].alternativeLineNum)
						? ids->arr[j].alternativeLineNum
						: MIN(ids->arr[i].alternativeLineNum, ids->arr[j].alternativeLineNum);
				}
			}
		}
		
		// for functions on the bottom of the sourcecode file
		if (0 == ids->arr[i].alternativeLineNum)
		{
			ids->arr[i].alternativeLineNum = 2000000000;
		}
	}
}



// sparsa ctags file in napolni dobljeno strukturo, vrne uspeh
static BOOL parseFile(
	IDENTIFIERS* ids,
	const TCHAR* baseDirPath)//path where ctags.tmp file is located
{
	TCHAR line[1024];
	FILE* fp;
	
	//FAILURE(TEXT("reparsing %s"), baseDirPath);
	
	// resetira globalno strukturo
	IdentifiersReset(ids);
	
	TCHAR ctagsTmpPath[MAX_PATH];
	_tcscpy(ctagsTmpPath, baseDirPath);
	
	// doda novo ime (avtomatsko doda backslash)
	if (!PathAppend(ctagsTmpPath, CTAGSFILENAME))
	{
		FAILURE(TEXT("failed making path of ") CTAGSFILENAME);
		return FALSE;
	}
	
	// odpre datoteko
	if (!(fp = _tfopen(ctagsTmpPath, TEXT("r"))))
	{
		if (!(fp = _tfopen(ctagsTmpPath, TEXT("r"))))
		{
			FAILURE(TEXT("failed opening \"%s\""), ctagsTmpPath);
			return FALSE;
		}
	}
	
	// sparsa datoteko
	while (_fgetts(line, 1024, fp))
	{
		if (!parseLine(ids, line, baseDirPath))
		{
			fclose(fp);
			return FALSE;
		}
	}
	
	fclose(fp);
	
	// local variables must be calculated only after all other identifiers were parsed
	calculateLocalVariables(ids);
	
	return TRUE;
}




static BOOL GlobalMessageProcedure(	// window procedure, vrne TRUE, če obdela sporočilo
	UINT msg,		
	WPARAM wParam,		
	LPARAM lParam)
{
	static int iAccumDelta = 0;     // for mouse wheel logic
	static BOOL keyWasHeld;
     
	switch (msg)
	{
		case WM_KEYDOWN:
		{
			switch (wParam)
			{
				case VK_ESCAPE:
				{
					SendMessage(hwndDialog, WM_CLOSE, 0, 0);
				}
				return TRUE;
				
				case VK_RETURN:
				{
					IDENT* ident;
					TCHAR fullpath[MAX_PATH];
					int lineNum;
					
					if (_stringInputMode)
					{
						//get string into global buffer
						SendMessage(hwndEdit, WM_GETTEXT, (WPARAM)(128-1), (LPARAM)_getStringResult);
						_getStringResult[128-1] = TEXT('\0');
					}
					else if ((ident = getSelectedIdent()))
					{
						const TCHAR* tag = ident->tag;
						
						//ker imajo memberji in enumaratorji spredaj dodano ime strukture, se mora
						//kazalec premakniti naprej, da kaže samo na ime identifierja za member / enumerator
						if ((ident->tagType == STR_member)
							|| (ident->tagType == STR_enumerator))
						{
							if (!(tag = _tcschr(tag, TEXT('.'))))	tag = TEXT("");
						}
						
						// posebno vstavljanje za funkcije in prototipe
						if (ident->flags & FLAG_IS_FUNCTION_LIKE)
						{
							// vstavi funkcijo z dodanimi oklepaji
							TCHAR buf[128];
							_sntprintf(buf, 127, isThereOnlyWhitespaceBeforeSelection()
								? TEXT("%s($);$$") : TEXT("%s($)$$"), tag);
							buf[127] = TEXT('\0');
							insertSnippetAndSetCursorPosition(buf, 0);
							
							// auto-lookup
							if (_enableAutoLookup)
							{
								// prikaz identifierja v other view
								gotoLineOfViewByIdent(!getCurrentView(), ident, TRUE, TRUE, TRUE);
							}
						}
						else
						{
							SCINTILA_ReplaceSel(getCurrentScintillaHandle(), tag);
						}
					}
					else if ((getInputtedNumber(&lineNum)) && (getCurrentFileFullPath(fullpath)))
					{
						lineNum -= 1;//prevede na Scintilla 0-based
						gotoLineOfView(getCurrentView(), fullpath, lineNum, TRUE, TRUE, FALSE);
					}
					
					SendMessage(hwndDialog, WM_CLOSE, 0, 0);
				}
				return TRUE;
				
				case VK_SPACE:
				{
					//preveri, da nima focusa checkbox, kjer se s SPACE jasno označuje / odznačuje
					if (_stringInputMode || (GetFocus() == hwndCB))	return FALSE;
					
					if (_onDialogSpaceInsertsSeparatorCharacter)
					{
						TCHAR str[2] = {_groupingSeparatorChar, TEXT('\0')};
						//SetFocus(hwndEdit);
						SendMessage(hwndEdit, EM_REPLACESEL, (WPARAM)TRUE, (LPARAM)str);
					}
					else
					{
						IDENT* ident;
						TCHAR fullpath[MAX_PATH];
						int lineNum;
						
						if ((ident = getSelectedIdent()))
						{
							// prikaz identifierja v other view
							gotoLineOfViewByIdent(getCurrentView(), ident, TRUE, TRUE, TRUE);
						}
						else if ((getInputtedNumber(&lineNum)) && (getCurrentFileFullPath(fullpath)))
						{
							lineNum -= 1;//prevede na Scintilla 0-based
							gotoLineOfView(getCurrentView(), fullpath, lineNum, TRUE, TRUE, FALSE);
						}
						
						SendMessage(hwndDialog, WM_CLOSE, 0, 0);
					}
				}
				return TRUE;
				
				
				case VK_LEFT:
				{
					//if (HIWORD(GetKeyState(VK_CONTROL)))	return FALSE;
					
					if (!_groupIdentifiers)	return FALSE;
					
					// če ima zgodovino, napolni iz nje, sicer odstrani iz stringa zadnjo skupino
					if (_groupHistoryCurrent >= 0)
					{
						SendMessage(hwndEdit, WM_SETTEXT, 0, (LPARAM)_groupHistoryStrings[_groupHistoryCurrent]);
						setCurrentListIndex(_groupHistoryIndexes[_groupHistoryCurrent], TRUE);
						SendMessage(hwndEdit, EM_SETSEL,
							(WPARAM)_groupHistoryCaretPositions[_groupHistoryCurrent][0],
							(LPARAM)_groupHistoryCaretPositions[_groupHistoryCurrent][1]);
						_groupHistoryCurrent--;
					}
					else
					{
						// odstrani zadnji odsek (meja so podčrtaji)
						TCHAR str[MAX_REGEX_SIZE];
						SendMessage(hwndEdit, WM_GETTEXT, (WPARAM)(MAX_REGEX_SIZE-1), (LPARAM)str);
						str[MAX_REGEX_SIZE-1] = TEXT('\0');
						
						int i = _tcslen(str);
						
						if (i == 0)	return TRUE;
						
						i--;
						
						if (str[i] == _groupingSeparatorChar)	i--;
						
						if (i >= 0)
						{
							do
							{
								if (str[i] == _groupingSeparatorChar)
								{
									i++;
									break;
								}
							}
							while (--i >= 0);
						}
						
						if (i < 0)	i = 0;
						
						str[i] = TEXT('\0');
						
						SendMessage(hwndEdit, WM_SETTEXT, 0, (LPARAM)str);
						SendMessage(hwndEdit, EM_SETSEL, (WPARAM)i, (LPARAM)i);
					}
				}
				return TRUE;
				
				case VK_RIGHT:
				{
					if (!_groupIdentifiers)	return FALSE;
					
					//if (HIWORD(GetKeyState(VK_CONTROL)))	return FALSE;
					
					IDENT* ident = getSelectedIdent();
					
					if (!ident)	return FALSE;
					
					TCHAR str[MAX_REGEX_SIZE];
					SendMessage(hwndEdit, WM_GETTEXT, (WPARAM)(MAX_REGEX_SIZE-1), (LPARAM)str);
					str[MAX_REGEX_SIZE-2] = TEXT('\0');//en prej ker bo še strcat
					_tcscat(str, TEXT("*"));
					
					int i = regexMatchIndex(str, ident->tag);//_tcslen(str);
					
					int start, end;
					SendMessage(hwndEdit, EM_GETSEL, (WPARAM)&start, (LPARAM)&end);
					
					if ((start != end) /*|| (start < i)*/)	return FALSE;
					
					
					BOOL found = FALSE;
					while (ident->tag[i] != TEXT('\0'))
					{
						if (ident->tag[i++] == _groupingSeparatorChar) { found = TRUE;	break;}
					}
					
					
					// podčrtaj mora najti, poleg tega pa mora biti podčrtaj ZADNJI prikazani znak
					if (!found)				return FALSE;
					
					
					if (i != ident->limitCharsShown)	return FALSE;
					
					memcpy(str, ident->tag, sizeof(TCHAR) * i);
					
					str[i] = TEXT('\0');
					
					// indeksi za vračanje ob VK_LEFT
					if ((_groupHistoryCurrent + 1) < MAX_GROUP_INDEXES_REMEMBERED)
					{
						_groupHistoryCurrent++;
						SendMessage(hwndEdit, WM_GETTEXT, (WPARAM)(MAX_REGEX_SIZE-1),
							(LPARAM)_groupHistoryStrings[_groupHistoryCurrent]);
						_groupHistoryIndexes[_groupHistoryCurrent] = getCurrentListIndex();
						SendMessage(hwndEdit, EM_GETSEL,
							(WPARAM)&_groupHistoryCaretPositions[_groupHistoryCurrent][0],
							(LPARAM)&_groupHistoryCaretPositions[_groupHistoryCurrent][1]);
					}
					
					SendMessage(hwndEdit, WM_SETTEXT, 0, (LPARAM)str);
					SendMessage(hwndEdit, EM_SETSEL, (WPARAM)i, (LPARAM)i);
				}
				return TRUE;
				
				case VK_NEXT:
				{
					int i1 = SendMessage(hwndList, LB_GETCOUNT, 0, 0) - 1;
					int i2 = getCurrentListIndex() + (_numLinesDisplayed ? _numLinesDisplayed - 1 : 0);
					keyWasHeld = lParam & 0x40000000;
					
					setCurrentListIndex(min(i1, i2), !keyWasHeld);
				}
				return TRUE;
				
				case VK_PRIOR:
				{
					int i = getCurrentListIndex() - (_numLinesDisplayed ? _numLinesDisplayed - 1 : 0);
					keyWasHeld = lParam & 0x40000000;
					
					setCurrentListIndex(max(i, 0), !keyWasHeld);
				}
				return TRUE;
				
				
				case VK_HOME:
				{
					// GetKeyState vrne stanje za trenutni message, ne trenutno dejansko stanje gumba
					if (GetKeyState(VK_SHIFT) >> 8)	return (FALSE);
					
					setCurrentListIndex(0, TRUE);
				}
				return TRUE;
				
				case VK_END:
				{
					if (GetKeyState(VK_SHIFT) >> 8)	return (FALSE);
					
					int i = SendMessage(hwndList, LB_GETCOUNT, 0, 0) - 1;
					setCurrentListIndex(i, TRUE);
				}
				return TRUE;
				
				
				
				case VK_UP:
				{
					keyWasHeld = lParam & 0x40000000;
					
				   	setCurrentListIndex(getCurrentListIndex() - 1, !keyWasHeld);
				}
				return TRUE;
				
				case VK_DOWN:
				{
					keyWasHeld = lParam & 0x40000000;
					
					setCurrentListIndex(getCurrentListIndex() + 1, !keyWasHeld);
				}
				return TRUE;
				
				case VK_F1:
				{
					showHelp(hwndDialog);
				}
				return TRUE;
				
				case VK_TAB:
				{
					HWND f = GetFocus();
					
					if (f == hwndEdit)	SetFocus(hwndCB);
					else			SetFocus(hwndEdit);
				}
				return TRUE;
				
				case VK_F11:
				{
					if (!_stringInputMode)
					{
						IDENT* ident;
						
						if ((ident = getSelectedIdent()))
						{
							// prikaz identifierja v second view
							gotoLineOfViewByIdent(TRUE, ident, TRUE, TRUE, TRUE);
						}
						
						// če je bil pritisnjen CONTROL ali SHIFT, se dialoga ne zapre
						// GetKeyState vrne stanje za trenutni message, ne trenutno dejansko stanje gumba
						if (!(GetKeyState(VK_SHIFT) & 0xff00)
							&& !(GetKeyState(VK_CONTROL) & 0xff00))
						{
							SendMessage(hwndDialog, WM_CLOSE, 0, 0);
						}
					}
				}
				return TRUE;
				
				case VK_F12:
				{
					if (!_stringInputMode)
					{
						IDENT* ident;
						
						if ((ident = getSelectedIdent()))
						{
							// prikaz identifierja v primary view
							gotoLineOfViewByIdent(FALSE, ident, TRUE, TRUE, TRUE);
						}
						
						// če je bil pritisnjen CONTROL ali SHIFT, se dialoga ne zapre
						// GetKeyState vrne stanje za trenutni message, ne trenutno dejansko stanje gumba
						if (!(GetKeyState(VK_SHIFT) & 0xff00)
							&& !(GetKeyState(VK_CONTROL) & 0xff00))
						{
							SendMessage(hwndDialog, WM_CLOSE, 0, 0);
						}
					}
				}
				return TRUE;
				
				default:
				{
					if (hwndEdit == GetFocus())	return (FALSE);
					
					SetFocus(hwndEdit);
				}
				return TRUE;
			}
		}
		break;
		
		// zagotovim delovanje, da lista ne izvaja auto lookup, če se drži tipko gor/dol (takrat izvede samo ob KEYUP)
		case WM_KEYUP:
		{
			switch (wParam)
			{
				case VK_UP:
				case VK_DOWN:
				case VK_NEXT:
				case VK_PRIOR:
				{
					setCurrentListIndex(getCurrentListIndex(), keyWasHeld);
				}
				return TRUE;
				
				/**kljub temu dodatku še vedno klika...*/
				case VK_TAB:
				{
				}
				return TRUE;
			}
		}
		break;
		
		case WM_MOUSEWHEEL:
		{
			int i = WHEEL_DELTA / scrollLinesPerWheelTurn;
			iAccumDelta += (short)HIWORD(wParam);
			
			while (iAccumDelta >= i)
			{               
				SendMessage (hwndList, WM_VSCROLL, SB_LINEUP, 0) ;
				iAccumDelta -= i ;
			}
			
			while (iAccumDelta <= -i)
			{
				SendMessage (hwndList, WM_VSCROLL, SB_LINEDOWN, 0) ;
				iAccumDelta += i ;
			}
		}
		return TRUE;
		
		// TranslateMessage je potreben za textbox, ampak takoj prevede tudi space v WM_CHAR. Brez tegale dodatka spodaj
		// je SPACE vedno vstavil separator character, potem pa še space
		case WM_CHAR:
		{
			if (_onDialogSpaceInsertsSeparatorCharacter
				&& (wParam == TEXT(' ')))
			{
				return (TRUE);
			}
		}
		return (FALSE);
	}
	
	return FALSE;
}





static void loadSettingsOnceOnly(void)
{
	static BOOL first = TRUE;
	
	if (first)
	{
		loadSettings();
		first = FALSE;
	}
}


static BOOL ProjectCtagsTmpExists(PROJECT* project)
{
	TCHAR fullpath[MAX_PATH];
	_tcscpy(fullpath, project->path);
	
	// doda novo ime (avtomatsko doda backslash)
	if (!PathAppend(fullpath, CTAGSFILENAME))
	{
		FAILURE(TEXT("failed making path of ") CTAGSFILENAME);
		return FALSE;
	}
	
	return (PathFileExists(fullpath));
}


// regenerates a project - if necessary
static BOOL ProjectReexecuteAndReparse(//returns TRUE if identifiers should be rebuilt
	PROJECT* project,
	BOOL delayedExecution,//pomeni da ne blokira in izvede execute v ozadju
	BOOL justExecute) //še ne parsa, samo executa ctags.exe
{
	// delayed execution enforces no parsing, since ctags.tmp won't be available yet anyway
	if (delayedExecution)	justExecute = TRUE;
	
	// check if reexecution must be enforced for reparsing
	if (project->mustReparse
		&& (!project->mustReexecute)
		&& (!ProjectCtagsTmpExists(project)))
	{
		project->mustReexecute = TRUE;
	}
	
	// project or non-project must be reexecuted
	if (project->mustReexecute)
	{
		// if not delayed execution, block (do not run in background)
		if (!executeCtagsExe(project->path, !delayedExecution, project->recursiveParsing))	return (FALSE);
		
		project->mustReexecute = FALSE;
		project->mustReparse = TRUE;
		
		// add the created temporary file for (potential) automatic deletition
		AddAKnownCtagsTmpPath(project);
	}
	
	// if only execute, we're done
	if (justExecute)	return (FALSE);
	
	// project or non-project must be reparsed
	if (project->mustReparse)
	{
		if (!parseFile(&project->ids, project->path))	return (FALSE);
		
		project->mustReparse = FALSE;
		
		// add the detected temporary file for (potential) automatic deletition
		AddAKnownCtagsTmpPath(project);
		
		return (TRUE);//only if reparsed, a rebuild-triggering change is signaled
	}
	
	return (FALSE);
}


// a path container function
static BOOL pathChanged2(const TCHAR* newPath)
{
	static TCHAR currentPath[MAX_PATH] = {TEXT('\0')};
	
	if (lstrcmpi(newPath, currentPath) == 0)	return FALSE;
	
	_tcscpy(currentPath, newPath);
	return TRUE;
}


// regenerates the whole data - if necessary
static void prepareData(
	BOOL delayedExecution,//pomeni da ne blokira in izvede execute v ozadju
	BOOL justExecute) //še ne parsa, samo executa ctags.exe
{
	// load settings, if they haven't been loaded yet
	loadSettingsOnceOnly();
	
	// get current project
	PROJECT* project = getCurrentProject();
	if (!project)	return;
	
	// is it necessary to rebuild the global identifiers structure?
	BOOL mustRebuild = FALSE;
	
	// if ctags.tmp path has changed since last data preparation, must rebuild the structure to contain current identifiers
	if (pathChanged2(project->path))	mustRebuild = TRUE;
	
	// project
	mustRebuild |= ProjectReexecuteAndReparse(project, delayedExecution, justExecute);
	
	// libraries
	for (int i = project->libsCount; i--;)
	{
		mustRebuild |= ProjectReexecuteAndReparse(project->libs[i], delayedExecution, justExecute);
	}
	
	// rebuild the main identifiers struct
	if (mustRebuild)
	{
		// reset the structure
		IdentifiersReset(&_identifiers);
		
		// add project
		if (!IdentifiersAdd(&_identifiers, &project->ids, FALSE))	return;
		
		// add libraries
		for (int i = project->libsCount; i--;)
		{
			if (!IdentifiersAdd(&_identifiers, &project->libs[i]->ids, TRUE))	return;
		}
		
		// sort
		IdentifiersSort(&_identifiers);
	}
}



static void cCompletion(void)
{
	TCHAR defaultTag[MAX_PATH];//MAX_PATH, ker tako svetuje avtor N++
	HANDLE hCurrentModule;
	
	prepareData(FALSE, FALSE);//not delayed, not execute only
	
	// dobi trenutno besedo pod kurzorjem
	if (!_stringInputMode)
	{
		SendMessage(HNPP, NPPM_GETCURRENTWORD, 0, (LPARAM)defaultTag);
		defaultTag[MAX_PATH - 1] = TEXT('\0');
	}
	else
	{
		defaultTag[0] = TEXT('\x00');
	}
	
	if (!(hCurrentModule = GetModuleHandle(NULL))) { FAILURE(TEXT("could not get current module")); return; }
	
	if (!(hwndDialog = CreateWindowEx(WS_EX_WINDOWEDGE, TEXT("CCompletion") /* razred */,
		_stringInputMode ? TEXT("CCompletion (string input mode)") : TEXT("CCompletion") /* caption */,
		WS_POPUP | WS_CAPTION | WS_SIZEBOX | WS_SYSMENU,
		_sizePos.left, _sizePos.top, _sizePos.right, _sizePos.bottom,
		HNPP, NULL, (HINSTANCE)hCurrentModule, defaultTag))) // default tag se pošlje kar s strukturo
	{
		FAILURE(TEXT("could not create window"));
		return;
	}
	
	// prikaže okno
	ShowWindow(hwndDialog, SW_SHOWNORMAL);
	
	// N++ določena sporočila pošilja mimo sistema - na primer HOME in END očitno nista acceleratorja,
	// ker je glavno okno dizejblano, pa vseeno delujeta! Kontrolo prevzamemo nazaj s svojim message loop-om:
	MSG msg;
	while (hwndDialog && (GetMessage(&msg, NULL, 0, 0) > 0))
	{
		TranslateMessage(&msg); // needed by hwndEdit
		
		// testiranje sistema, ki ne potrebuje subclassanja... je pa res, da deluje mimo sistema
		/*
		typedef struct {
		    HWND hwnd;
		    UINT message;
		    WPARAM wParam;
		    LPARAM lParam;
		    DWORD time;
		    POINT pt;
		} MSG, *PMSG;
		*/
		
		if (!GlobalMessageProcedure(msg.message, msg.wParam, msg.lParam))	DispatchMessage(&msg);
	}
}



// po klicu ostane v _getStringResult vpisan vnešeni rezultat, če je uporabnik seveda kaj vpisal
static void getString(BOOL convertToUpper)
{
	_stringInputMode = TRUE;
	
	_getStringResult[0] = TEXT('\x00');
	cCompletion();
	
	int i;
	
	if (convertToUpper)
	{
		for (i = 0; _getStringResult[i] != TEXT('\0'); i++)	_getStringResult[i] = toupper(_getStringResult[i]);
	}
	
	_stringInputMode = FALSE;
}



static int getNumLeadingTabsInLineAtPosition(int pos)
{
	HWND sci = getCurrentScintillaHandle();
	int line = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)pos, 0);
	int leadingSpacesInLine = SendMessage(sci, SCI_GETLINEINDENTATION, (WPARAM)line, 0);
	int spacesPerTab = SendMessage(sci, SCI_GETTABWIDTH, 0, 0);
	int leadingTabsInLine = (spacesPerTab) ? leadingSpacesInLine / spacesPerTab : 0;
	return leadingTabsInLine;
}




// če je tabs < 0, se zamakne za toliko tab-ov manj, če > 0 se zamakne za toliko tab-ov več
static void insertSnippetAndSetCursorPosition(const TCHAR* strSnippet, int tabs)
{
	#define BUF_SIZE 1024
	TCHAR buf[BUF_SIZE];
	int i = 0;
	
	HWND sci = getCurrentScintillaHandle();
	SendMessage(sci, SCI_BEGINUNDOACTION, 0, 0);// da bo en undo odstranil celotno spremembo, potrebno ker gre za več klicov operacij
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int originalLine = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)originalPos, 0);
	int spacesInOriginalLine = SendMessage(sci, SCI_GETLINEINDENTATION, (WPARAM)originalLine, 0);
	int spacesPerTab = SendMessage(sci, SCI_GETTABWIDTH, 0, 0);
	int tabsInOriginalLine = (spacesPerTab) ? spacesInOriginalLine / spacesPerTab : 0;
	
	tabsInOriginalLine += tabs;
	if (tabsInOriginalLine < 0)	tabsInOriginalLine = 0;
	if (tabsInOriginalLine > 32)	tabsInOriginalLine = 32;
	
	
	// izbriše trenutno izbiro (če bi to izbrisal takoj, se lahko združijo tabulatorji in se dobi napačen zamik!!!)
	// skratka, NAJPREJ se dobi število tabov, potem se šele šari po vrstici!!!
	SCINTILA_ReplaceSel(sci, TEXT(""));
	originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int finalBufIndex = 0;
	
	while (*strSnippet != TEXT('\0') && i < (BUF_SIZE-1))
	{
		if (*strSnippet == TEXT('$'))
		{
			if (*(strSnippet+1) == TEXT('$'))
			{
				// premakne na to mesto vse, kar je od trenutnega položaja kurzorja naprej
				// v vrstici, RAZEN leanding tab-ov
				
				/*
SCI_GETLINEENDPOSITION(int line)
SCI_SETSELECTIONSTART(int pos)
SCI_SETSELECTIONEND(int pos)

SCI_GETSELTEXT(<unused>, TCHAR *text)
This copies the currently selected text and a terminating 0 byte to the text buffer. The buffer must be at least SCI_GETSELECTIONEND()-SCI_GETSELECTIONSTART()+1 bytes long.
If the text argument is 0 then the length that should be allocated to store the entire selection is returned.
				*/
				
				SendMessage(sci, SCI_SETSELECTIONSTART, (WPARAM)originalPos, 0);
				int originalLineEndPos = SendMessage(sci, SCI_GETLINEENDPOSITION, (WPARAM)originalLine, 0);
				SendMessage(sci, SCI_SETSELECTIONEND, (WPARAM)originalLineEndPos, 0);
				
				int lengthRequired = SendMessage(sci, SCI_GETSELTEXT, 0, (LPARAM)NULL);
				
				if (lengthRequired > (BUF_SIZE - i))
				{
					FAILURE(TEXT("Snippet failed: line too long."));
					goto DONE;
				}
				
				SCINTILA_GetSelText(sci, &buf[i]);
				while (buf[i] == TEXT('\t'))	memmove(&buf[i], &buf[i+1], sizeof(TCHAR)*(BUF_SIZE-i));
				while (buf[i] != TEXT('\0'))	i++;
				
				SCINTILA_ReplaceSel(sci, TEXT(""));
				
				strSnippet++;
			}
			else
			{
				finalBufIndex = i;
			}
		}
		else if (*strSnippet == TEXT('\n'))
		{
			buf[i++] = TEXT('\r');
			buf[i++] = TEXT('\n');
			
			for(int n = tabsInOriginalLine; n--;)	buf[i++] = TEXT('\t');
		}
		else
		{
			buf[i++] = *strSnippet;
		}
		
		strSnippet++;
	}
	buf[i] = TEXT('\0');
	
	//insert
	SCINTILA_ReplaceSel(sci, buf);
	
	//nastavitev pozicije na trenutno minus reverseCounter
	//int caretPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	SendMessage(sci, SCI_SETSEL, originalPos + finalBufIndex, originalPos + finalBufIndex);
	//fix brace highlight
	SendMessage(sci, SCI_BRACEHIGHLIGHT, (WPARAM)(originalPos + finalBufIndex - 1), (LPARAM)(originalPos + finalBufIndex));
	
DONE:
	SendMessage(sci, SCI_ENDUNDOACTION, 0, 0);
}




// ta zadeva pattern %s nadomesti z uporabnikovim vnosom, vendar je treba paziti na sledeče:
// trenutno se lahko vstavi samo en string, in to največ 4x. Če se tega ne drži, bodo težave.
static void getStringInsertSnippetAndSetCursorPosition(const TCHAR* strSnippet)
{
	TCHAR expandedSnippet[128];
	getString(TRUE);
	
	_sntprintf(expandedSnippet, 128-1, strSnippet, _getStringResult, _getStringResult, _getStringResult, _getStringResult);
	expandedSnippet[128-1] = TEXT('\0');
	
	insertSnippetAndSetCursorPosition(expandedSnippet, 0);
	return;
}


// vrne TRUE, če smo v switch stavku, in to na prvem nivoju; predpostavlja, da ima switch stavek VEDNO
// compound (kako pa bi drugače podali več kot en pogoj?), preveri se torej, da se nahajamo v tem, najvišjem compoundu
static BOOL areWeOnFirstLevelOfSwitchStatement(void)
{
	HWND sci = getCurrentScintillaHandle();
	
	int originalSelStart = SendMessage(sci, SCI_GETSELECTIONSTART, 0, 0);
	//int originalSelEnd = SendMessage(sci, SCI_GETSELECTIONEND, 0, 0);
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int originalLine = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)originalPos, 0);
	int beginingOfLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)originalLine, 0);
	int nextLine = originalLine;
	int beginingOfNextLine = beginingOfLinePos;
	
	while (nextLine > 0)//scintilla ima line 0-based
	{
		int previousLine = nextLine - 1;
		int beginingOfPreviousLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)previousLine, 0);
		
		//iskanje nazaj, search beginingOfPreviousLinePos ... beginingOfNextLine
		// (non-UNICODE)
		TextToFind ttf = {(CharacterRange){beginingOfPreviousLinePos, beginingOfNextLine}, "switch", (CharacterRange){-1, -1}};
		int resultIndex = SendMessage(sci, SCI_FINDTEXT, (WPARAM)SCFIND_WHOLEWORD, (LPARAM)&ttf);
		
		// switch najden
		if (resultIndex != -1)
		{
			BOOL result = FALSE;
			
			int size = originalSelStart - resultIndex + 1;
			TCHAR* buf;
			
			if (!(buf = (TCHAR*)malloc(size*sizeof(TCHAR))))
			{
				FAILURE(TEXT("failed allocating buffer of size %d"), size);
				return (FALSE);
			}
			
			// dobi celoten text
			int lengthRead = SCINTILLA_GetTextRange(sci, resultIndex, originalSelStart, buf);
			int bOpen = 0, bClose = 0;
			
			if (lengthRead != size-1)
			{
				FAILURE(TEXT("failed reading from scintilla (expected %d, read %d)"), size-1, lengthRead);
				goto DONE;
			}
			
			for (int i = 0; i < lengthRead; i++)
			{
				if (buf[i] == TEXT('{'))	bOpen++;
				else if (buf[i] == TEXT('}'))
				{
					bClose++;
					if (bClose >= bOpen)
					{
						// potem to ni v redu, ker se oklepaji niso pravilno odpirali in zapirali,
						// na ta način bi se lahko zmotno dobilo pravilen seštevek oklepajev, pa če je
						// switch v povsem drugi funkciji (to se mi je dejansko dogajalo)
						bClose = 0;
						bOpen = 0;
						break;
					}
				}
			}
			
			result = ((bOpen - bClose) == 1);
			
			DONE:
			
			free(buf);
			return result;
		}
		
		nextLine--;
		beginingOfNextLine = beginingOfPreviousLinePos;
	}
	
	return FALSE;
}




static void countBracketsBeforeCaret(int* numOpen, int* numClosed)
{
	HWND sci = getCurrentScintillaHandle();
	
	int originalSelStart = SendMessage(sci, SCI_GETSELECTIONSTART, 0, 0);
	//int originalSelEnd = SendMessage(sci, SCI_GETSELECTIONEND, 0, 0);
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int originalLine = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)originalPos, 0);
	int beginingOfLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)originalLine, 0);
	
	int size = originalSelStart - beginingOfLinePos + 1;
	TCHAR* buf;
	
	if (!(buf = (TCHAR*)malloc(size*sizeof(TCHAR))))
	{
		FAILURE(TEXT("failed allocating buffer of size %d"), size);
		return;
	}
	
	// dobi celoten text
	int lengthRead = SCINTILLA_GetTextRange(sci, beginingOfLinePos, originalSelStart, buf);
	
	if (lengthRead != size-1)
	{
		FAILURE(TEXT("failed reading from scintilla (expected %d, read %d)"), size-1, lengthRead);
		goto DONE;
	}
	
	for (int i = 0; i < lengthRead; i++)
	{
		if (buf[i] == TEXT('('))	*numOpen += 1;
		else if (buf[i] == TEXT(')'))	*numClosed += 1;
	}
	
	DONE:
	
	free(buf);
}



static void insertSnippetAddBooleanRule(BOOL andLogicOrLogic)//če true, & logic, sicer | logic rule
{
	int numOpen = 0;
	int numClosed = 0;
	
	countBracketsBeforeCaret(&numOpen, &numClosed);
	int tabs = numOpen - numClosed;//vsak dodatni open pomeni en tab več zamika, in obratno. Deluje, če se pravilno uporablja oklepaje.
	
	insertSnippetAndSetCursorPosition(andLogicOrLogic ? TEXT("\n&& ($)$$") : TEXT("\n|| ($)$$"), tabs);
}


static BOOL isSelectionEmptyAndCursorAtTheBeginningOfTheLine(void)
{
	HWND sci = getCurrentScintillaHandle();
	
	int originalSelStart = SendMessage(sci, SCI_GETSELECTIONSTART, 0, 0);
	int originalSelEnd = SendMessage(sci, SCI_GETSELECTIONEND, 0, 0);
	
	if (originalSelStart != originalSelEnd)	return (FALSE);
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int originalLine = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)originalPos, 0);
	int beginingOfLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)originalLine, 0);
	
	return (originalSelStart == beginingOfLinePos);
}



// vrne TRUE, če je v vrstici pred selection-om samo whitespace
static BOOL isThereOnlyWhitespaceBeforeSelection(void)
{
	HWND sci = getCurrentScintillaHandle();
	
	int originalSelStart = SendMessage(sci, SCI_GETSELECTIONSTART, 0, 0);
	//int originalSelEnd = SendMessage(sci, SCI_GETSELECTIONEND, 0, 0);
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int originalLine = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)originalPos, 0);
	int beginingOfLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)originalLine, 0);
	
	
	TCHAR buf[originalSelStart - beginingOfLinePos + 1];
	int lengthRead = SCINTILLA_GetTextRange(sci, beginingOfLinePos, originalSelStart, buf);
	
	
	for (int i = 0; i < lengthRead; i++)
	{
		if (!isspace(buf[i]))
		{
			return FALSE;
		}
	}
	
	return TRUE;
}

// vrne TRUE, če je v vrstici po selection-u samo še whitespace
static BOOL isThereOnlyWhitespaceAfterSelection(void)
{
	HWND sci = getCurrentScintillaHandle();
	
	//int originalSelStart = SendMessage(sci, SCI_GETSELECTIONSTART, 0, 0);
	int originalSelEnd = SendMessage(sci, SCI_GETSELECTIONEND, 0, 0);
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	int originalLine = SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)originalPos, 0);
	//int beginingOfLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)originalLine, 0);
	int endOfLinePos = SendMessage(sci, SCI_POSITIONFROMLINE, (WPARAM)(originalLine + 1), 0);
	
	
	if (endOfLinePos <= originalSelEnd)
	{
		return (TRUE);
	}
	
	TCHAR buf[endOfLinePos - originalSelEnd];
	int lengthRead = SCINTILLA_GetTextRange(sci, originalSelEnd, endOfLinePos, buf);
	
	
	for (int i = 0; i < lengthRead; i++)
	{
		if (!isspace(buf[i]))
		{
			return FALSE;
		}
	}
	
	return TRUE;
}




static void processSnippet(TCHAR* tag)
{///
	// $ je placeholder, kamor se prestavi kurzor
	if (!_tcscmp(TEXT("a"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("assume ($$$);"), 0);											return; }
	if (!_tcscmp(TEXT("b"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("break;$"), 0);												return; }
	if (!_tcscmp(TEXT("c"), tag))					{ insertSnippetAndSetCursorPosition(areWeOnFirstLevelOfSwitchStatement() ? TEXT("case $:\n{\n\t$$\n}") : TEXT("continue;$"), 0);		return; }
	if (!_tcscmp(TEXT("cb"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("case $:\n{\n\t$$\n}\nbreak;"), 0);									return; }
	if (!_tcscmp(TEXT("cr"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("case $:\n{\n\t$$\n}\nreturn;"), 0);									return; }
	if (!_tcscmp(TEXT("crv"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("case $:\n{\n\t$$\n}\nreturn ();"), 0);									return; }
	if (!_tcscmp(TEXT("d"), tag))					{ insertSnippetAndSetCursorPosition(areWeOnFirstLevelOfSwitchStatement() ? TEXT("default:\n{\n\t$$$\n}") : TEXT("do\n{\n\t$$$\n}\nwhile ();"), 0);	return; }
	if (!_tcscmp(TEXT("db"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("default $:\n{\n\t$$\n}\nbreak;"), 0);									return; }
	if (!_tcscmp(TEXT("dr"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("default $:\n{\n\t$$\n}\nreturn;"), 0);									return; }
	if (!_tcscmp(TEXT("drv"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("default $:\n{\n\t$$\n}\nreturn ();"), 0);								return; }
	if (!_tcscmp(TEXT("e"), tag) || !_tcscmp(TEXT("else"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("else\n{\n\t$$$\n}"), 0);											return; }
	if (!_tcscmp(TEXT("f"), tag) || !_tcscmp(TEXT("for"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("for ($; ; )\n{\n\t$$\n}"), 0);										return; }
	// goto nima oklepajev, ker tega compiler ne dovoli
	if (!_tcscmp(TEXT("g"), tag))					{ insertSnippetAndSetCursorPosition(TEXT("goto $$$;"), 0);												return; }
	if (!_tcscmp(TEXT("i"), tag) || !_tcscmp(TEXT("if"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("if ($)\n{\n\t$$\n}"), 0);											return; }
	// return ima dve vrednosti, ker je nerodno vedno brisati oklepaje, če se jih ne rabi, prav tako nerodno pa jih je dodajati.
	// rv ... return value. Boljše je namreč ohranjati končnico tako, da je lažje razmišljati z besedami, kot recimo re, kar je
	// lažje vtipkati, a zahteva več mentalnega napora zaradi nelogičnosti... trenutno namreč vse okrajšave pomenijo po eno
	// besedo za vsako črko.
	
// n v NULL
	if (!_tcscmp(TEXT("n"), tag))	{ insertSnippetAndSetCursorPosition(isThereOnlyWhitespaceAfterSelection() ? TEXT("NULL;$") : TEXT("NULL$"), 0);									return; }
	
	if (!_tcscmp(TEXT("r"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("return$;"), 0);																return; }
	if (!_tcscmp(TEXT("rv"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("return ($$$);"), 0);															return; }
	if (!_tcscmp(TEXT("s"), tag))	{ insertSnippetAndSetCursorPosition(isThereOnlyWhitespaceBeforeSelection() ? TEXT("switch ($)\n{\n\t$$\n}") : TEXT("sizeof($)"), 0);						return; }
	if (!_tcscmp(TEXT("t"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("typedef $$$;"), 0);															return; }
	if (!_tcscmp(TEXT("ts"), tag))	{ getStringInsertSnippetAndSetCursorPosition(TEXT("typedef struct %s\n{\n\t$$$\n}\n%s;"));												return; }
	if (!_tcscmp(TEXT("te"), tag))	{ getStringInsertSnippetAndSetCursorPosition(TEXT("typedef enum %s\n{\n\t$$$\n}\n%s;"));												return; }
	if (!_tcscmp(TEXT("v"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("verify ($$$);"), 0);															return; }
	if (!_tcscmp(TEXT("w"), tag) || !_tcscmp(TEXT("while"), tag))	{ insertSnippetAndSetCursorPosition(TEXT("while ($)\n{\n\t$$\n}"), 0);										return; }
	

// 1 v TRUE in 0 v FALSE
	if (!_tcscmp(TEXT("1"), tag))	{ insertSnippetAndSetCursorPosition(isThereOnlyWhitespaceAfterSelection() ? TEXT("TRUE;$") : TEXT("TRUE$"), 0);									return; }
	if (!_tcscmp(TEXT("0"), tag))	{ insertSnippetAndSetCursorPosition(isThereOnlyWhitespaceAfterSelection() ? TEXT("FALSE;$") : TEXT("FALSE$"), 0);									return; }

// typeof manjka, ker je zelo zelo redko uporaben, če sploh kdaj
//naj se raje piše "else i<trigger snippet>", kot pa "elif"... if (!_tcscmp(TEXT("elif"), tag))			{ insertSnippetAndSetCursorPosition(TEXT("else if ($)\n{\n\t$$\n}"));		return; }
	
	// posebni pogoji
	if (!_tcscmp(TEXT(""), tag))
	{
		HWND sci = getCurrentScintillaHandle();
		int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
		
		// preveč na začetku datoteke
		if (originalPos < 3)	return;
		
		TCHAR c = SCINTILLA_GetCharAt(sci, originalPos - 1);
		
		// na levi je najverjetneje operator
		if (c == TEXT('('))
		{
			// (caret) -> ((caret))
			if (TEXT(')') == SCINTILLA_GetCharAt(sci, originalPos))
			{
				 insertSnippetAndSetCursorPosition(TEXT("($)$$"), 0);
			}
			return;
		}
		
		if (c == TEXT(')'))
		{
			// vstavljanje compounda
			int pos1 = originalPos - 1;
			int tabs1 = getNumLeadingTabsInLineAtPosition(pos1);
			int pos2 = SendMessage(sci, SCI_BRACEMATCH, pos1, 0);
			if (pos2 == -1)	return;
			int tabs2 = getNumLeadingTabsInLineAtPosition(pos2);
			insertSnippetAndSetCursorPosition(TEXT("\n{\n\t$$$\n}"), tabs2 - tabs1);
			return;
		}
		
		if (c == TEXT(':'))
		{
			// vstavljanje compounda
			insertSnippetAndSetCursorPosition(TEXT("\n{\n\t$$$\n}"), 0);
			return;
		}
		
		if (c == TEXT('?'))
		{
			// ?cursor -> ((caret) ? () : ())
			SendMessage(sci, SCI_SETSELECTIONSTART, (WPARAM)(originalPos - 1), 0);
			SendMessage(sci, SCI_SETSELECTIONEND, (WPARAM)originalPos, 0);
			insertSnippetAndSetCursorPosition(TEXT("(($) ? () : ())$$"), 0);
			return;
		}
		
		
		// vstavljanje logičnih pravil deluje za, "&&", "||"
		if (c == TEXT('|'))
		{
			int selectionStart = originalPos - 1;
			TCHAR c1 = SCINTILLA_GetCharAt(sci, originalPos - 2);
			TCHAR c2 = SCINTILLA_GetCharAt(sci, originalPos - 3);
			if (c1 != TEXT('|'))	return;//nujno naj bosta dva zaporedna znaka, bitwise logike tu ne mislim upoštevati
			selectionStart -= (c2 == TEXT(' ')) ? 2 : 1;
			
			SendMessage(sci, SCI_SETSELECTIONSTART, (WPARAM)selectionStart, 0);
			SendMessage(sci, SCI_SETSELECTIONEND, (WPARAM)originalPos, 0);
			insertSnippetAddBooleanRule(FALSE);
			return;
		}
		if (c == TEXT('&'))
		{
			int selectionStart = originalPos - 1;
			TCHAR c1 = SCINTILLA_GetCharAt(sci, originalPos - 2);
			TCHAR c2 = SCINTILLA_GetCharAt(sci, originalPos - 3);
			if (c1 != TEXT('&'))	return;//nujno naj bosta dva zaporedna znaka, bitwise logike tu ne mislim upoštevati
			selectionStart -= (c2 == TEXT(' ')) ? 2 : 1;
			
			SendMessage(sci, SCI_SETSELECTIONSTART, (WPARAM)selectionStart, 0);
			SendMessage(sci, SCI_SETSELECTIONEND, (WPARAM)originalPos, 0);
			insertSnippetAddBooleanRule(TRUE);
			return;
		}
	}
}


static void snippet(void)
{
	TCHAR defaultTag[MAX_PATH];//MAX_PATH, ker tako svetuje avtor N++
	
	//dobi trenutno besedo levo od kurzorja - to besedo mora tudi izrecno označiti
	HWND sci = getCurrentScintillaHandle();
	
	int originalPos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	
	SendMessage(HNPP, NPPM_GETCURRENTWORD, 0, (LPARAM)defaultTag);
	defaultTag[MAX_PATH - 1] = TEXT('\0');
	
	int startPos = SendMessage(sci, SCI_GETSELECTIONSTART, 0, 0);
	int endPos = SendMessage(sci, SCI_GETSELECTIONEND, 0, 0);
	
	startPos = min(startPos, originalPos);
	endPos = min(endPos, originalPos);
	SendMessage(sci, SCI_SETSEL, startPos, endPos);
	
	SCINTILA_GetSelText(sci, defaultTag);
	
	processSnippet(defaultTag);
}



static BOOL thisIdentifierShouldBeIgnoredSinceItsOutOfScope(
	const IDENT* ident, const TCHAR* currentFileFullPath, unsigned int currentFileLine)
{
	if (!_doNotShowOutOfScopeIdentifiers)	return (FALSE);
	
	// ignore some local identifiers
	if ((ident->tagType == STR_local)
		&& ((0 != lstrcmpi(currentFileFullPath, ident->filename))
			|| (currentFileLine < ident->lineNum)
			|| (currentFileLine > ident->alternativeLineNum)))
	{
		return (TRUE);
	}
	
	// ignore some internal identifiers
	if ((ident->flags & FLAG_IS_INTERNAL)
		&& (0 != lstrcmpi(currentFileFullPath, ident->filename)))
	{
		return (TRUE);
	}
	
	return (FALSE);
}


static int getCurrentFileLine()
{
	HWND sci = getCurrentScintillaHandle();
	int pos = SendMessage(sci, SCI_GETCURRENTPOS, 0, 0);
	return (SendMessage(sci, SCI_LINEFROMPOSITION, (WPARAM)pos, 0));
}



static LRESULT CALLBACK dialogWndProc(
	HWND hwnd,			
	UINT msg,				
	WPARAM wParam,			
	LPARAM lParam)		
{
	#define ID_EDIT 10000
	#define ID_LIST 10001
	#define ID_CHKB 10002
	
	//static HFONT listFont = NULL;
	
	switch (msg)
	{
		case WM_DRAWITEM:	// izris ene vrstice listbox-a
		{
			LPDRAWITEMSTRUCT dis;
			RECT r;
			IDENT* ident;
			
			dis = (LPDRAWITEMSTRUCT)lParam;
			
			// če prazna lista / se je samo spremenil focus, potem izhod
			if ((dis->itemID == (unsigned int)-1) || (dis->itemAction == ODA_FOCUS))	break;
			if (!(ident = getIdentAtListIndex(dis->itemID)))				break;
			
			
			if (dis->itemState & ODS_SELECTED)	SetBkColor(dis->hDC, COLOR_SELECTED);
			else					SetBkColor(dis->hDC, COLOR_UNSELECTED);
			
			
			SetTextAlign(dis->hDC, TA_LEFT);
			SetTextColor(dis->hDC, ident->tagTextColor);
			
			r.top = dis->rcItem.top;
			r.bottom = dis->rcItem.bottom;
			r.left = 0;
			r.right = dis->rcItem.right / 9;//ratio za prvi stolpec
			
			// tipa ne izpiše za grupirane identifierje
			ExtTextOut(dis->hDC, 5, dis->rcItem.top + 1,
				ETO_OPAQUE | ETO_CLIPPED, &r,
				ident->isLimitedClass ? TEXT("") : ident->tagType,
				ident->isLimitedClass ? 0 : _tcslen(ident->tagType),
				NULL);
			
			SetTextColor(dis->hDC, ident->isLimitedClass ? COLOR_GROUP_TEXT : COLOR_TEXT);
			
			r.left = r.right;
			r.right = dis->rcItem.right * 50 / 100;//meja je na točki, podani s % celotne širine
			
			// identifier name
			ExtTextOut(dis->hDC, r.left + 5, dis->rcItem.top + 1,
				ETO_OPAQUE | ETO_CLIPPED, &r, ident->tag, ident->limitCharsShown, NULL);
			
			if (ident->isLimitedClass)	SetTextColor(dis->hDC, COLOR_TEXT);
			
			r.left = r.right;
			r.right = dis->rcItem.right;
			
			SetTextColor(dis->hDC, (ident->flags & FLAG_IS_LIBRARY) ? COLOR_LIBRARY_TEXT : COLOR_TEXT);
			
			// filename (different color if within a library)
			ExtTextOut(dis->hDC, r.left + 5, dis->rcItem.top + 1,
				ETO_OPAQUE | ETO_CLIPPED, &r, ident->filename, _tcslen(ident->filename), NULL);
			
			SetTextColor(dis->hDC, COLOR_TEXT);
			
			
			if (dis->itemState & ODS_SELECTED)
			{
				HBRUSH old = (HBRUSH)SelectObject(dis->hDC, GetStockObject(NULL_BRUSH));
				Rectangle(dis->hDC, dis->rcItem.left, dis->rcItem.top, dis->rcItem.right, dis->rcItem.bottom);
				SelectObject(dis->hDC, old);
				
				/*MoveToEx(dis->hDC, dis->rcItem.left, dis->rcItem.top, NULL);
				LineTo(dis->hDC, dis->rcItem.right, dis->rcItem.top);
				MoveToEx(dis->hDC, dis->rcItem.right, dis->rcItem.top, NULL);
				LineTo(dis->hDC, dis->rcItem.right, dis->rcItem.bottom);
				MoveToEx(dis->hDC, dis->rcItem.right, dis->rcItem.bottom, NULL);
				LineTo(dis->hDC, dis->rcItem.left, dis->rcItem.bottom);
				MoveToEx(dis->hDC, dis->rcItem.left, dis->rcItem.bottom, NULL);
				LineTo(dis->hDC, dis->rcItem.left, dis->rcItem.top);*/
			}
			
			return (TRUE);
		}
		break;
		
		case WM_CTLCOLORLISTBOX:
		{
			// brush za listbox
		}
		return ((LRESULT)_hbrushBg);
	
		case WM_COMMAND:
		{
			switch (LOWORD(wParam))
			{
				case ID_EDIT:
				{
					if (HIWORD(wParam) == EN_CHANGE)
					{
						int i;
						SendMessage(hwndList, LB_RESETCONTENT, 0, 0);
						TCHAR regex1[MAX_REGEX_SIZE];
						TCHAR regex2[MAX_REGEX_SIZE];
						int identifiersToShow = 0;
						
						SendMessage(hwndEdit, WM_GETTEXT, (WPARAM)(MAX_REGEX_SIZE-2), (LPARAM)regex1);
						
						_sntprintf(regex2, MAX_REGEX_SIZE-1, TEXT("%s*"), regex1);
						regex2[MAX_REGEX_SIZE-1] = TEXT('\0');
						
						TCHAR currentFileFullPath[MAX_PATH];
						getCurrentFileFullPath(currentFileFullPath);
						unsigned int line = getCurrentFileLine();
						
						// marks all identifiers that fit the regular expression
						// also, first ignore all local identifiers that are not local to current function and all internal identifiers in other than current file
						for (i = 0; i < _identifiers.count; i++)
						{
							if (thisIdentifierShouldBeIgnoredSinceItsOutOfScope(&_identifiers.arr[i], currentFileFullPath, line))
							{
								_identifiers.arr[i].index = -1;
								continue;
							}
							
							if (regexMatch(regex2, _identifiers.arr[i].tag))
							{
								_identifiers.arr[i].index = 0;
								_identifiers.arr[i].limitCharsShown = _identifiers.arr[i].tagStrLen;
								_identifiers.arr[i].isLimitedClass = FALSE;
								identifiersToShow++;
							}
							else
							{
								_identifiers.arr[i].index = -1;
							}
						}
						
						// če je vklopljeno grupiranje, se določene identifierje združi v skupine
						// to ne velja v primeru, ko je na listi prostor za vse identifierje
						if (_groupIdentifiers && (identifiersToShow > _numLinesDisplayed))
						{
							for (i = 0; i < _identifiers.count; i++)
							{
								if ((_identifiers.arr[i].index == 0)
									&& identifierGrouping(regex2, i))
								{
									// odvečni identifier se skrije
									_identifiers.arr[i].index = -1;
								}
							}
						}
						
						// doda identifierje na listo
						for (i = 0; i < _identifiers.count; i++)
						{
							if ((_identifiers.arr[i].index == 0)
								&& (_identifiers.arr[i].index = SendMessage(hwndList, LB_ADDSTRING, 0, 0))
									== LB_ERRSPACE)
							{
								// zmanjkalo prostora
								_identifiers.arr[i].index = -1;
								break;
							}
						}
						
						setCurrentListIndex(0, TRUE);
						SendMessage(hwndList, WM_VSCROLL, SB_TOP, 0); // brez tega iz neznanega razloga prikaže na vrhu šele drugi item!
						
						return (0);
					}
				}
				break;
				
				case ID_LIST:
				{
					if (HIWORD(wParam) == LBN_SELCHANGE)
					{
						setCurrentListIndex(getCurrentListIndex(), TRUE);
						return (0);
					}
				}
				break;
				
				case ID_CHKB:
				{
					int state = SendMessage(hwndCB, BM_GETCHECK, 0, 0);
					
					if (state == BST_CHECKED)		_enableAutoLookup = TRUE;
					else if (state == BST_UNCHECKED)	_enableAutoLookup = FALSE;
					
					_savesettingsrequired = TRUE;
				}
				break;
			}
		}
		break;
		
		case WM_SIZE:	// HIWORD(lParam) je višina za client area, LOWORD(lParam) pa širina
		{
			int ClientWidth = LOWORD(lParam);
			int ClientHeight = HIWORD(lParam);
			int height = _useLargeDPI ? 31 : 21;
			int margin = _useLargeDPI ? 7 : 5;
			int chk_w = _useLargeDPI ? 280 : 170;
			
			checkSizePos(hwnd);
			
			MoveWindow(hwndEdit, 0, 0, ClientWidth - (chk_w + margin), height, TRUE);
			MoveWindow(hwndCB, ClientWidth - chk_w, 0, chk_w, height, TRUE);
			MoveWindow(hwndList, 0, height, ClientWidth, ClientHeight - height, TRUE);
			
			RECT rc;
			GetClientRect(hwndList, &rc);
			_numLinesDisplayed = ((rc.bottom - rc.top) / getLineHeight());
			_numLinesDisplayed = max(0, _numLinesDisplayed);
		}
		return (0);
		
		case WM_MOVE:
		{
			checkSizePos(hwnd);
		}
		break;
		
		case WM_MEASUREITEM:
		{
			// višina za vrstico v owner-drawn listbox
			((LPMEASUREITEMSTRUCT)lParam)->itemHeight = getLineHeight();
		}
		return (TRUE);
		
		case WM_GETMINMAXINFO:
		{
			MINMAXINFO* mmi = (MINMAXINFO*)lParam;
			
			// določi minimalno velikost okna
			mmi->ptMinTrackSize.x = 400;
			mmi->ptMinTrackSize.y = 150;
		}
		return (0);
		
		case WM_CREATE:
		{
			CREATESTRUCT* cs = (CREATESTRUCT*)lParam;
			HANDLE module = cs->hInstance;
			
			// modal dialog dizejbla parenta
			EnableWindow(HNPP, FALSE);
			
			hwndList = CreateWindowEx(WS_EX_CLIENTEDGE, TEXT("LISTBOX"), NULL,
				WS_CHILD | WS_VISIBLE | WS_VSCROLL | LBS_NODATA | LBS_OWNERDRAWFIXED | LBS_NOTIFY,
				CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
				hwnd, (HMENU)ID_LIST, (HINSTANCE)module, NULL);
			
			hwndEdit = CreateWindowEx(WS_EX_CLIENTEDGE, TEXT("EDIT"), NULL,
				WS_CHILD | WS_VISIBLE,
				CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
				hwnd, (HMENU)ID_EDIT, (HINSTANCE)module, NULL);
			
			hwndCB = CreateWindowEx(0, TEXT("BUTTON"), TEXT("Enable function auto-lookup"),
				WS_CHILD | WS_VISIBLE | BS_AUTOCHECKBOX | (_stringInputMode ? WS_DISABLED : 0),
				CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
				hwnd, (HMENU)ID_CHKB, (HINSTANCE)module, NULL);
			
			// default value
			SendMessage(hwndCB, BM_SETCHECK, (WPARAM)((_enableAutoLookup) ? BST_CHECKED : BST_UNCHECKED), 0);
			
			if (!hwndEdit || !hwndList || !hwndCB)
			{
				EnableWindow(HNPP, TRUE);
				SetForegroundWindow(HNPP);
				return -1; // CreateWindowEx vrne FALSE
			}
			
			
			/*listFont = CreateFont(14, 0, 0, 0, FW_DONTCARE, FALSE, FALSE, FALSE,
				DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
				DEFAULT_QUALITY, FF_DONTCARE, TEXT("Courier New"));*/
			
			
			// set fonts
			SendMessage(hwndList, WM_SETFONT, /*listFont ? (WPARAM)listFont :*/ (WPARAM)GetStockObject(DEFAULT_GUI_FONT), 0);
			SendMessage(hwndEdit, WM_SETFONT, (WPARAM)GetStockObject(DEFAULT_GUI_FONT), 0);
			SendMessage(hwndCB, WM_SETFONT, (WPARAM)GetStockObject(DEFAULT_GUI_FONT), 0);
			SendMessage(hwndEdit, EM_LIMITTEXT, (WPARAM)(MAX_REGEX_SIZE-1), 0);
			
			// set default string
			SendMessage(hwndEdit, WM_SETTEXT, 0, (LPARAM)cs->lpCreateParams);
			
			// izbere vse v textboxu in mu priredi focus
			SendMessage(hwndEdit, EM_SETSEL, (WPARAM)0, (LPARAM)-1);
			SetFocus(hwndEdit);
		}
		return (0);
		
		case WM_CLOSE:
		{
			// tole -1 je potrebno samo, če je grupiranje identifierjev vklopljeno, a je preverjanje brezpredmetno
			_groupHistoryCurrent = -1;
			
			if (_savesettingsrequired)
			{
				saveSettings();
				_savesettingsrequired = FALSE;
			}
			
			hwndDialog = NULL;
			DestroyWindow(hwnd);
		}
		return (0);
		
		case WM_DESTROY:
		{
			//DeleteObject(listFont);
			EnableWindow(HNPP, TRUE);
			SetForegroundWindow(HNPP);
		}
		return (0);
	}
	
	return (DefWindowProc(hwnd, msg, wParam, lParam));
}


//brezpogojno regenerira tag-e
static void regenerateTags(void)
{
	PROJECT* project = getCurrentProject();
	if (!project)	return;
	project->mustReexecute = TRUE;
	
	prepareData(FALSE, TRUE);//not delayed, but execute only
}

//brezpogojno regenerira vse trenutno vidne tag-e
static void regenerateTagsCurrentPlusVisibleLibraries(void)
{
	PROJECT* project = getCurrentProject();
	if (!project)	return;
	project->mustReexecute = TRUE;
	
	int i;
	for (i = project->libsCount; i--;)
	{
		project->libs[i]->mustReexecute = TRUE;
	}
	
	prepareData(FALSE, TRUE);//not delayed, but execute only
}


static void help(void)
{
	showHelp(HNPP);
}

static void about(void)
{
	showAbout(HNPP);
}


static void goToIdentifierUnderCursor(BOOL primaryView)//če TRUE, gre na identifier v primary view, sicer v secondary view
{
	static IDENT lastIdentifier;
	static BOOL lastIdentitifierUsed = FALSE;
	
	int i;
	
	TCHAR currentFileFullPath[MAX_PATH];
	getCurrentFileFullPath(currentFileFullPath);
	unsigned int line = getCurrentFileLine();
	
	// cycle through same-named identifiers
	if (lastIdentitifierUsed && isSelectionEmptyAndCursorAtTheBeginningOfTheLine())
	{
		int firstIndex = -1; // first index with same-named identifier as the last go-to identifier
		for (i = 0; i < _identifiers.count; i++)
		{
			if (_tcscmp(lastIdentifier.tag, _identifiers.arr[i].tag) != 0)						continue;
			if (thisIdentifierShouldBeIgnoredSinceItsOutOfScope(&_identifiers.arr[i], currentFileFullPath, line))	continue;
			
			if (firstIndex == -1)	firstIndex = i;
			
			if (0 == memcmp(&lastIdentifier, &_identifiers.arr[i], sizeof(IDENT)))
			{
				// last identifier found, now find the next identifier (the one to cycle to)
				if (i < (_identifiers.count - 1)
					&& (_tcscmp(lastIdentifier.tag, _identifiers.arr[i + 1].tag) == 0))
				{
					// found, it's the next identifier
					memcpy(&lastIdentifier, &_identifiers.arr[i + 1], sizeof(IDENT));
					gotoLineOfViewByIdent(primaryView, &_identifiers.arr[i + 1], TRUE, TRUE, TRUE);
					return;
				}
				else if (firstIndex >= 0 && firstIndex != i)
				{
					// found, back at the beginning
					memcpy(&lastIdentifier, &_identifiers.arr[firstIndex], sizeof(IDENT));
					gotoLineOfViewByIdent(primaryView, &_identifiers.arr[firstIndex], TRUE, TRUE, TRUE);
					return;
				}
				else
				{
					// it's not the next identifier, also current identifier is first such named identifier
					// in case the user has disabled inclusion of some identifiers (like include
					// function prototype identifiers, but not function definition identifiers), alternative
					// will take care of that
					gotoLineOfViewByIdent(primaryView, &_identifiers.arr[i], TRUE, TRUE, TRUE);
					return;
				}
			}
		}
		
		// identifier not found! identifiers must have changed
		lastIdentitifierUsed = FALSE;
	}
	
	TCHAR defaultTag[MAX_PATH];//MAX_PATH, ker tako svetuje avtor N++
	
	prepareData(FALSE, FALSE);//not delayed, not execute only
	
	// dobi trenutno besedo pod kurzorjem
	SendMessage(HNPP, NPPM_GETCURRENTWORD, 0, (LPARAM)defaultTag);
	defaultTag[MAX_PATH - 1] = TEXT('\0');
	
	for (i = 0; i < _identifiers.count; i++)
	{
		//case sensitive, ker sicer rad gre recimo na preprocessor identifier namesto na ime funkcije itd.
		if (_tcscmp(defaultTag, _identifiers.arr[i].tag) == 0)
		{
			if (thisIdentifierShouldBeIgnoredSinceItsOutOfScope(&_identifiers.arr[i], currentFileFullPath, line))	continue;
			
			memcpy(&lastIdentifier, &_identifiers.arr[i], sizeof(IDENT));
			lastIdentitifierUsed = TRUE;
			gotoLineOfViewByIdent(primaryView, &_identifiers.arr[i], TRUE, TRUE, TRUE);
			break;
		}
	}
}


static void goToIdentifierUnderCursor_PrimaryView(void)
{
	goToIdentifierUnderCursor(TRUE);
}



static void goToIdentifierUnderCursor_SecondaryView(void)
{
	goToIdentifierUnderCursor(FALSE);
}


static void h_b1(void)
{
	gotoPreviousHistoryEntry(TRUE);
}

static void h_f1(void)
{
	gotoNextHistoryEntry(TRUE);
}

static void h_i1(void)
{
	pushHistoryEntry(TRUE, TRUE);
}

static void h_d1(void)
{
	deleteCurrentHistoryEntry(TRUE, TRUE);
}

static void h_b2(void)
{
	gotoPreviousHistoryEntry(FALSE);
}

static void h_f2(void)
{
	gotoNextHistoryEntry(FALSE);
}

static void h_i2(void)
{
	pushHistoryEntry(FALSE, TRUE);
}

static void h_d2(void)
{
	deleteCurrentHistoryEntry(FALSE, TRUE);
}





static void editSettings(void)
{
	TCHAR path[MAX_PATH];
	
	if (!getSettingsFileFullpath(path))	return;
	if (!PathFileExists(path))		saveSettings();
	
	// odpre datoteko
	SendMessage(HNPP, WM_DOOPEN, 0, (LPARAM)path);
}





static void menuOptionAutoRegenerateTagsOnSaveForProjectFiles(void)
{
	_autoRegenerateTagsOnSaveForProject = !_autoRegenerateTagsOnSaveForProject;
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionAutoRegenerateTagsOnSaveForAllFiles(void)
{
	_autoRegenerateTagsOnSaveForNonProject = !_autoRegenerateTagsOnSaveForNonProject;
	
	if (_autoRegenerateTagsOnSaveForNonProject)
	{
		MESSAGE(TEXT("Warning"), TEXT("Enabling automatic regeneration for any non-project file will result in\n"
			"CCompletion creating \"") CTAGSFILENAME TEXT("\" file whereever you save a non-project file."));
	}
	
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionDeleteCtagsTmpForProject(void)
{
	_deleteCtagsTmpForProject = !_deleteCtagsTmpForProject;
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionDeleteCtagsTmpForNonProject(void)
{
	_deleteCtagsTmpForNonProject = !_deleteCtagsTmpForNonProject;
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionIgnoreInvalidTagsAndContinueParsing(void)
{
	_ignoreInvalidTagsAndContinueParsing = !_ignoreInvalidTagsAndContinueParsing;
	setMenuCheckItems();
	saveSettings();
	
	// mark all for reparsing
	for (int i = _projectsCount; i--;)	_projects[i].mustReparse = TRUE;
	_nonProject.mustReparse = TRUE;
}

static void menuOptionSkipTypedefWhenSameNameStructPreceedesIt(void)
{
	_skipTypedefWhenSameNameStructPreceedesIt = !_skipTypedefWhenSameNameStructPreceedesIt;
	setMenuCheckItems();
	saveSettings();
	
	// mark all for reparsing
	for (int i = _projectsCount; i--;)	_projects[i].mustReparse = TRUE;
	_nonProject.mustReparse = TRUE;
}


static void menuOptionSkipFunctionWhenSameNamePrototypePreceedesIt(void)
{
	_skipFunctionWhenSameNamePrototypePreceedesIt = !_skipFunctionWhenSameNamePrototypePreceedesIt;
	setMenuCheckItems();
	saveSettings();
	
	// mark all for reparsing
	for (int i = _projectsCount; i--;)	_projects[i].mustReparse = TRUE;
	_nonProject.mustReparse = TRUE;
}

static void menuOptionGroupIdentifiers(void)
{
	_groupIdentifiers = !_groupIdentifiers;
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionUseLargeDPI(void)
{
	_useLargeDPI = !_useLargeDPI;
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionOnDialogSpaceInsertsSeparatorCharacter(void)
{
	_onDialogSpaceInsertsSeparatorCharacter = !_onDialogSpaceInsertsSeparatorCharacter;
	setMenuCheckItems();
	saveSettings();
}

static void menuOptionDoNotShowOutOfScopeIdentifiers(void)
{
	_doNotShowOutOfScopeIdentifiers = !_doNotShowOutOfScopeIdentifiers;
	setMenuCheckItems();
	saveSettings();
	
	// mark all for reparsing
	for (int i = _projectsCount; i--;)	_projects[i].mustReparse = TRUE;
	_nonProject.mustReparse = TRUE;
}




//====================================================================================================================
//====================================================================================================================


// The getFuncsArray function gives Notepad++ plugins system the pointer FuncItem Array 
// and the size of this array (the number of functions)
extern "C" __declspec(dllexport) FuncItem * getFuncsArray(int *nbF)
{
	static ShortcutKey shctOCT[] = {
		{true, false, false, VK_SPACE},
		{false, false, false, VK_F11},
		{false, false, false, VK_F12},
		{true, false, false, VK_F12},
		{true, false, true, VK_F12},
		{false, false, false, VK_INSERT},
		{false, false, false, VK_F5},
		{false, false, false, VK_F6},
		{true, false, false, VK_F5},
		{true, false, false, VK_F6},
		{false, false, false, VK_F7},
		{false, false, false, VK_F8},
		{true, false, false, VK_F7},
		{true, false, false, VK_F8}
	};
	
	static BOOL doneIt = FALSE;
	
	if (!doneIt) // pravzaprav ne vem, če se ta zadeva kliče večkrat - to je odvisno od N++ - raje ne tvegam
	{
		WNDCLASSEX windowClass;
		HANDLE hCurrentModule;
		
		if (!(hCurrentModule = GetModuleHandle(NULL)))
		{
			FAILURE(TEXT("could not get current module"));
			return NULL;
		}
		
		// registrira razred
		windowClass.cbSize = sizeof (WNDCLASSEX);
		windowClass.style = CS_HREDRAW | CS_VREDRAW;
		windowClass.lpfnWndProc = &dialogWndProc;
		windowClass.cbClsExtra = 0;
		windowClass.cbWndExtra = 0;
		windowClass.hInstance = (HINSTANCE)hCurrentModule;
		windowClass.hIcon = NULL;
		if (!(windowClass.hCursor = LoadCursor(NULL, IDC_ARROW)))
		{
			FAILURE(TEXT("could not load cursor"));
			return NULL;
		}
		windowClass.hbrBackground = (HBRUSH)(COLOR_BTNFACE + 1);	// sistemska barva za gumbe zagotavlja barvno ujemanje
		windowClass.lpszMenuName = NULL;
		windowClass.lpszClassName = TEXT("CCompletion");
		windowClass.hIconSm = (HICON)LoadImage(GetModuleHandle(CCOMPLETION_DLL_FILENAME), MAKEINTRESOURCE(IDI_ICON), IMAGE_ICON, 16, 16, 0);
		//if icon could not be loaded: ignore, probably just someone renamed the dll
		
		if (!RegisterClassEx(&windowClass))
		{
			FAILURE(TEXT("could not register class"));
			return NULL;
		}
		
		// dobi število vrstic za scrollwheel
		SystemParametersInfo (SPI_GETWHEELSCROLLLINES, 0, &scrollLinesPerWheelTurn, 0) ;
		
		// podatki za N++
		_tcsncpy(_funcItem[0]._itemName, TEXT("Help"), nbChar - 1);
		_tcsncpy(_funcItem[1]._itemName, TEXT("CCompletion"), nbChar - 1);
		_tcsncpy(_funcItem[2]._itemName, TEXT("Go to identifier (open in first view)"), nbChar - 1);
		_tcsncpy(_funcItem[3]._itemName, TEXT("Go to identifier (open in second view)"), nbChar - 1);
		_tcsncpy(_funcItem[4]._itemName, TEXT("Regenerate tags (current file or project)"), nbChar - 1);
		_tcsncpy(_funcItem[5]._itemName, TEXT("Regenerate tags (current file or project plus its libraries)"), nbChar - 1);
		_tcsncpy(_funcItem[6]._itemName, TEXT("Insert snippet"), nbChar - 1);
		_tcsncpy(_funcItem[7]._itemName, TEXT("History backward on first view"), nbChar - 1);
		_tcsncpy(_funcItem[8]._itemName, TEXT("History forward on first view"), nbChar - 1);
		_tcsncpy(_funcItem[9]._itemName, TEXT("History insert on first view"), nbChar - 1);
		_tcsncpy(_funcItem[10]._itemName, TEXT("History delete on first view"), nbChar - 1);
		_tcsncpy(_funcItem[11]._itemName, TEXT("History backward on second view"), nbChar - 1);
		_tcsncpy(_funcItem[12]._itemName, TEXT("History forward on second view"), nbChar - 1);
		_tcsncpy(_funcItem[13]._itemName, TEXT("History insert on second view"), nbChar - 1);
		_tcsncpy(_funcItem[14]._itemName, TEXT("History delete on second view"), nbChar - 1);
		_tcsncpy(_funcItem[15]._itemName, TEXT("Automatically regenerate tags on file save (projects)?"), nbChar - 1);
		_tcsncpy(_funcItem[16]._itemName, TEXT("Automatically regenerate tags on file save (non-projects)?"), nbChar - 1);
		_tcsncpy(_funcItem[17]._itemName, TEXT("Automatically delete temporary ") CTAGSFILENAME TEXT(" files (projects)?"), nbChar - 1);
		_tcsncpy(_funcItem[18]._itemName, TEXT("Automatically delete temporary ") CTAGSFILENAME TEXT(" files (non-projects)?"), nbChar - 1);
		_tcsncpy(_funcItem[19]._itemName, TEXT("Ignore invalid tags and continue parsing?"), nbChar - 1);
		_tcsncpy(_funcItem[20]._itemName, TEXT("Do not list typedef when same named struct / enum exists?"), nbChar - 1);
		_tcsncpy(_funcItem[21]._itemName, TEXT("Do not list function when same named prototype exists?"), nbChar - 1);
		_tcsncpy(_funcItem[22]._itemName, TEXT("Group identifiers?"), nbChar - 1);
		_tcsncpy(_funcItem[23]._itemName, TEXT("Larger GUI (for high DPI settings)?"), nbChar - 1);
		_tcsncpy(_funcItem[24]._itemName, TEXT("On dialog, SPACE inserts separator character?"), nbChar - 1);
		_tcsncpy(_funcItem[25]._itemName, TEXT("Do not list out-of-scope identifiers?"), nbChar - 1);
		_tcsncpy(_funcItem[26]._itemName, TEXT("Delete known ") CTAGSFILENAME TEXT(" files"), nbChar - 1);
		_tcsncpy(_funcItem[27]._itemName, TEXT("Edit ") SETTINGS_FILE, nbChar - 1);
		_tcsncpy(_funcItem[28]._itemName, TEXT("Reload ") SETTINGS_FILE TEXT(" (and reset identifier cache)"), nbChar - 1);
		_tcsncpy(_funcItem[29]._itemName, TEXT("About"), nbChar - 1);
		
		
		_funcItem[0]._pFunc = &help;
		_funcItem[1]._pFunc = &cCompletion;
		_funcItem[2]._pFunc = &goToIdentifierUnderCursor_PrimaryView;
		_funcItem[3]._pFunc = &goToIdentifierUnderCursor_SecondaryView;
		_funcItem[4]._pFunc = &regenerateTags;
		_funcItem[5]._pFunc = &regenerateTagsCurrentPlusVisibleLibraries;
		_funcItem[6]._pFunc = &snippet;
		_funcItem[7]._pFunc = &h_b1;
		_funcItem[8]._pFunc = &h_f1;
		_funcItem[9]._pFunc = &h_i1;
		_funcItem[10]._pFunc = &h_d1;
		_funcItem[11]._pFunc = &h_b2;
		_funcItem[12]._pFunc = &h_f2;
		_funcItem[13]._pFunc = &h_i2;
		_funcItem[14]._pFunc = &h_d2;
		_funcItem[15]._pFunc = &menuOptionAutoRegenerateTagsOnSaveForProjectFiles;
		_funcItem[16]._pFunc = &menuOptionAutoRegenerateTagsOnSaveForAllFiles;
		_funcItem[17]._pFunc = &menuOptionDeleteCtagsTmpForProject;
		_funcItem[18]._pFunc = &menuOptionDeleteCtagsTmpForNonProject;
		_funcItem[19]._pFunc = &menuOptionIgnoreInvalidTagsAndContinueParsing;
		_funcItem[20]._pFunc = &menuOptionSkipTypedefWhenSameNameStructPreceedesIt;
		_funcItem[21]._pFunc = &menuOptionSkipFunctionWhenSameNamePrototypePreceedesIt;
		_funcItem[22]._pFunc = &menuOptionGroupIdentifiers;
		_funcItem[23]._pFunc = &menuOptionUseLargeDPI;
		_funcItem[24]._pFunc = &menuOptionOnDialogSpaceInsertsSeparatorCharacter;
		_funcItem[25]._pFunc = &menuOptionDoNotShowOutOfScopeIdentifiers;
		_funcItem[26]._pFunc = &unconditionallyDeleteAllKnownCtagsTmpFile;
		_funcItem[27]._pFunc = &editSettings;
		_funcItem[28]._pFunc = &loadSettings;
		_funcItem[29]._pFunc = &about;
		
		
		_funcItem[0]._init2Check = false;
		_funcItem[1]._init2Check = false;
		_funcItem[2]._init2Check = false;
		_funcItem[3]._init2Check = false;
		_funcItem[4]._init2Check = false;
		_funcItem[5]._init2Check = false;
		_funcItem[6]._init2Check = false;
		_funcItem[7]._init2Check = false;
		_funcItem[8]._init2Check = false;
		_funcItem[9]._init2Check = false;
		_funcItem[10]._init2Check = false;
		_funcItem[11]._init2Check = false;
		_funcItem[12]._init2Check = false;
		_funcItem[13]._init2Check = false;
		_funcItem[14]._init2Check = false;
		_funcItem[15]._init2Check = (_autoRegenerateTagsOnSaveForProject) ? true : false;
		_funcItem[16]._init2Check = (_autoRegenerateTagsOnSaveForNonProject) ? true : false;
		_funcItem[17]._init2Check = (_deleteCtagsTmpForProject) ? true : false;
		_funcItem[18]._init2Check = (_deleteCtagsTmpForNonProject) ? true : false;
		_funcItem[19]._init2Check = (_ignoreInvalidTagsAndContinueParsing) ? true : false;
		_funcItem[20]._init2Check = (_skipTypedefWhenSameNameStructPreceedesIt) ? true : false;
		_funcItem[21]._init2Check = (_skipFunctionWhenSameNamePrototypePreceedesIt) ? true : false;
		_funcItem[22]._init2Check = (_groupIdentifiers) ? true : false;
		_funcItem[23]._init2Check = (_useLargeDPI) ? true : false;
		_funcItem[24]._init2Check = (_onDialogSpaceInsertsSeparatorCharacter) ? true : false;
		_funcItem[25]._init2Check = (_doNotShowOutOfScopeIdentifiers) ? true : false;
		_funcItem[26]._init2Check = false;
		_funcItem[27]._init2Check = false;
		_funcItem[28]._init2Check = false;
		_funcItem[29]._init2Check = false;
		
		
		_funcItem[0]._pShKey = NULL;
		_funcItem[1]._pShKey = &shctOCT[0];
		_funcItem[2]._pShKey = &shctOCT[1];
		_funcItem[3]._pShKey = &shctOCT[2];
		_funcItem[4]._pShKey = &shctOCT[3];
		_funcItem[5]._pShKey = &shctOCT[4];
		_funcItem[6]._pShKey = &shctOCT[5];
		_funcItem[7]._pShKey = &shctOCT[6];
		_funcItem[8]._pShKey = &shctOCT[7];
		_funcItem[9]._pShKey = &shctOCT[8];
		_funcItem[10]._pShKey = &shctOCT[9];
		_funcItem[11]._pShKey = &shctOCT[10];
		_funcItem[12]._pShKey = &shctOCT[11];
		_funcItem[13]._pShKey = &shctOCT[12];
		_funcItem[14]._pShKey = &shctOCT[13];
		_funcItem[15]._pShKey = NULL;
		_funcItem[16]._pShKey = NULL;
		_funcItem[17]._pShKey = NULL;
		_funcItem[18]._pShKey = NULL;
		_funcItem[19]._pShKey = NULL;
		_funcItem[20]._pShKey = NULL;
		_funcItem[21]._pShKey = NULL;
		_funcItem[22]._pShKey = NULL;
		_funcItem[23]._pShKey = NULL;
		_funcItem[24]._pShKey = NULL;
		_funcItem[25]._pShKey = NULL;
		_funcItem[26]._pShKey = NULL;
		_funcItem[27]._pShKey = NULL;
		_funcItem[28]._pShKey = NULL;
		_funcItem[29]._pShKey = NULL;
		
		
		_hbrushBg = CreateSolidBrush(COLOR_UNSELECTED);
		
		
		memset(_history1, 0, sizeof(HISTORY) * MAX_HISTORY);
		_histIndex1 = 0;
		memset(_history2, 0, sizeof(HISTORY) * MAX_HISTORY);
		_histIndex2 = 0;
		
		memset(&_nonProject, 0, sizeof(PROJECT));
		memset(_projects, 0, sizeof(PROJECT) * MAX_PROJECTS);
		memset(&_identifiers, 0, sizeof(IDENTIFIERS));
		
		doneIt = TRUE;
	}
	
	*nbF = MENUOPTIONSCOUNT;
	return _funcItem;
}

// The setInfo function gets the needed infos from Notepad++ plugins system
extern "C" __declspec(dllexport) void setInfo(NppData notpadPlusData)
{
	nppData = notpadPlusData;
}

// The getName function tells Notepad++ plugins system its name
extern "C" __declspec(dllexport) const TCHAR * getName()
{
	return TEXT("CCompletion");
}



// If you don't need get the notification from Notepad++,
// just let it be empty.
extern "C" __declspec(dllexport) void beNotified(SCNotification *notifyCode)
{
	switch (notifyCode->nmhdr.code)
	{
		case NPPN_READY:
		{
			loadSettingsOnceOnly();
		}
		break;
		
		case NPPN_FILESAVED:
		{
			PROJECT* project = getCurrentProject();
			
			if (((project != &_nonProject)
					&& _autoRegenerateTagsOnSaveForProject)
				|| ((project == &_nonProject)
					&& _autoRegenerateTagsOnSaveForNonProject))
			{
				project->mustReexecute = TRUE;
				prepareData(TRUE, TRUE);//delayed, execute only
			}
		}
		break;
		
		case NPPN_SHUTDOWN:
		{
			deleteCtagsTmpFiles(FALSE);
		}
		break;
	}
}

// Here you can process the Npp Messages 
// I will make the messages accessible little by little, according to the need of plugin development.
// Please let me know if you need to access to some messages :
// http://sourceforge.net/forum/forum.php?forum_id=482781
//
extern "C" __declspec(dllexport) LRESULT messageProc(UINT Message, WPARAM wParam, LPARAM lParam)
{
	/*if (Message == WM_SIZE)
	{
		MessageBox(nppData._nppHandle, TEXT("move"), TEXT(""), MB_OK);
	}*/	

	return TRUE;
}

extern "C" __declspec(dllexport) BOOL isUnicode(void)
{
#ifdef UNICODE
	return (TRUE);
#else
	return (FALSE);
#endif
}

BOOL APIENTRY DllMain(HINSTANCE hModule,DWORD  reasonForCall, LPVOID lpReserved)
{
	/*switch (reasonForCall)
	{
		case DLL_PROCESS_ATTACH:
		case DLL_PROCESS_DETACH:
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
			break;
	}*/
	
	return TRUE;
} 
