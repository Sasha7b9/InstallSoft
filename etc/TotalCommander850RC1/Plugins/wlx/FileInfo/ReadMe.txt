Version Information Viewer Ver 2.21
plugin for Total Commander (version 5.50 and above only)
===================================
This viewer is intended to check all files for a Version Ressource and display it
it shows now static and delayed DLL dependency and File Header Information

Installation
-------------
4 versions are included in this zipped file 
	- wlx_fileinfo32 and wlx_fileinfo64 are statically linked to MFC, size is larger but no DLL is needed
	- wlx_fileinfo32_DL and wlx_fileinfo64_DL are dynamically linked to MFC, size is half the weight but 
	3 DLLs from MFC9.0 are needed (MSVCP90.dll, MFC90.dll, MSVCR90.dll)
x32 and x64 plugin can be installed in the same directory

Use the plugin auto-install interface, ie just open the zip file in TC
Try to install first the DL variant of this plugin, if TC display an error message then you are missing MFC9 DLL so install the statically linked version of this plugin

OR if you know what you are doing, you can install it manually :
Copy "fileinfo.wlx" in your plugin directory
and add these two lines to your wincmd.ini (in 5.50 and above)
....or use the Lister plugin interface (in 5.51)

[ListerPlugins]
0=C:\wincmd\plugin\fileinfo.wlx
	(Change path to your real one )

additional DLL needed by fileinfo.wlx:
--------------------------------------
IMAGEHLP.DLL

additional DLL to use Disassembly facilities: (doesn't work in x64 version)
--------------------------------------
CADT.DLL 
You must activate manually disassembly in 'fileinfo.ini'
and copy DLL in TCMD directory or in "SYSTEM32" directory or in "fileinfo.wlx" directory
download here : http://physio-a.univ-tours.fr/tcplugins/cadt.rar


Description of "fileinfo.ini"
---------------------------
[Options]
RememberAP=0            : 1 = remember the last active page (0 don't)
autosave=1              : autosaving size and position of mmedia lister (0 don't)
ActivePage=1            :
Undecorate=1            : demangle microsoft and borland C++ functions (0 don't)
Dump_res=0              : 1 = Dump Resources (0 don't)
ShowDebug=0             : 1 = Show Debug information (0 don't)
MaxDepth=2              : Depth of DLL Dependencies analysis
W95Protect=1            : with protection, all fonctions of fileinfo are not activated, (0 to disable)
ComInt=1                : pre-detect COM Interface (0 to disable but some OLE type library will be not detected)
Disassemble=0           : disable by default.(1 to enable, need cadt.dll to be copied in "system32" directory)
UserFont=1              : Load User font (enable by default, 0 don't)

Rect=EA0200001401000081040000050300008E  : size and position of mmedia lister (remove line to reinit)

Warning : 
   default value for 'Maxdepth' is 2. on slow computer, set 1 to speed up.
   value > 4 can freeze computer for a long time

Tips :
------
- in 'Dll dependency' tab
   red icon : missing DLL
   yellow icon : missing function in DLL
   see options tab for more information
   depth of analysis can now be defined ( directly in "fileinfo.ini")

- in 'Imports / Exports' tab
   name of function copied on clipboard when you click on it   

- to use plugins, see plugins.txt

- you can save unpacked PE file with CTL-S

- in 'DLL dependency' & 'Imports/Exports' tabs, 
	the 'F3' key can open a new fileinfo window of the highlight DLL

Some code come from :
--------------------
Enrico Frumento to provide me sources to extract typelib information
Thomas Weller for his file : file_ver.cpp ; Implementation of class CFileVersionInfo. (Last modified:  02/02/2002)
Giancarlo Iovino for his HyperLink static control
Matt Pietrek for his helpfull articles on PE files format and some of his source. 
Christian Ghisler : author of Total Commander: for developing this great utilitie and for the lister plugin interface
Ms-Rem (Ms-Rem@yandex.ru) for Disassembly DLL (CADT.DLL)

History :
---------
2.21 - 15.01.2012
   - Added : subsystem "IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION" and "IMAGE_SUBSYSTEM_EFI_ROM"
   - Added : new tab for Manifest resource if present
   - Added : resource types "RT_HTML", "RT_MANIFEST", "RT_DLGINIT" & "RT_TOOLBAR"
   - Added : 's' and 'u' key to sort and undecorate in 'Imports/Exports' tabs 
   - Added : in 'DLL dependency' & 'Imports/Exports' tabs, the 'F3' key can open a new fileinfo window 
   - Added : x64 version of unaspack plugun
   - Added : Button to edit fileinfo.ini
   - Added : in "DLL dependency" tab, path of file is added
   - Changed : Address/Size of unused Data directory not displayed
   - Fixed : crash with filesize > 4GB   
   - Fixed : in Imports/Exports tab, impossible to uncheck 'Sort' checkbox
   - Fixed : unaspack plugin
   - Fixed : wrong service pack detected
   - Fixed : missing delay-load DLL was not displayed correctly

2.20 - 09.10.2011
   - Added   : both x32/x64 versions are included
   - Added   : display the number of imported/exported functions
   - Added   : Display path of configuration file
   - Changed : fileinfo.ini is placed by default in the wincmd.ini directory
   - Changed : cadt.dll can now be put in fileinfo.wlx directory
   - Changed fonts to tahoma in imports/Exports tab
   - Fixed : Crash with unaspack plugin with some EXE
   - Fixed : Crash in Dump Bound Import Descriptors
   - Fixed : Crash in Dump Delayed Import section with Packed EXE
   - Fixed : Crash in Dependency list with Packed EXE
   - Fixed : test ptr out of bound in import section

2.10 - 28.11.2007
   - Updated : Some IMAGE_FILE_MACHINE descriptors
   - Changed : fileinfo.ini removed from distribution
   - Fixed : compatibility with MSWin Vista
   - Fixed : protection again DoS vulnerability (see http://securityreason.com/securityalert/3044 )
   - Fixed : protection again spoofing (see  http://securityreason.com/securityalert/3044 )
   - Fixed : Arrow key come back
   - Fixed : crash in "Import Table Dump" with some compressed EXE
   - Fixed : crash in "Export Table Dump" with some compressed EXE

2.09 - 31.11.2006
   - Added : Option to not Load User Font
   - Fixed : Crash in disassemble tab with some EXE
   - Fixed : CTL-Tab key come back
   - Fixed : Tab name with typelib info
   - Fixed : Some SH3/SH4 specific dll not recognized

2.08 - 09.11.2006
   - Added : Disassembly of code
   - Added : Display Entry-point of Executables
   - Added : Option to stop pre-detecting COM Interface
   - Fixed : protect Win9x machine against malware code in COM interface (need to be tested)
   - Fixed : Crash with some Microsoft xpsp... DLL
   - Fixed : Incorrect size of windows in quickview mode

2.07 - 24.08.2005
   - Added : Relocation entries
   - Added : Codeview format "RSDS"
   - Added : Option to enable/disable view of runtime function table
   - Added : Option to enable/disable view of relocations
   - Added : Some IMAGE_DEBUG_TYPE descriptors
   - Added : Some IMAGE_FILE_MACHINE descriptors
   - Fixed : Crash when dumping 64bits executables with IMAGE_ORDINAL_FLAG64 present
   - Fixed : Imported functions not shown in import tab if dll not found

2.06 - 08.07.2005
   - Updated : some characteristic flags
   - Added : compatibility with 64bits modules
   - Added : detection for Xbox system
   - Fixed : access to some files not freed
   - Fixed : crash after viewing lib/obj file
   - Fixed : Malware code executed when viewing doubtful DLL

2.05 - 20.01.2005
   - Updated : Display compressed PE-EXE ( Winzip ) 
   - Added : automatic plugin installation (TC 6.5 and above)
   - Added : filename in save dialog
   - Added : add the same extention to the file in save dialog if none is given
   - Fixed : button name in save dialog
   - Fixed : crash lister with some UPX compressed EXE files (Maxthon.exe)
   - Fixed : unaspack crash with some compressed-EXE

2.04b- 13.09.2004
   - Added : can save unpacked file with CTL-S
   - Fixed : start COM server with linked extensions (excel, PSP, photoshop,...)
   - Fixed : cannot rename or delete no extension's file after viewing

2.04a- 03.09.2004
   - Fixed : start excel.exe with cvs/csv file
   - Fixed : Scrollbars lost in "Import" tab

2.04 - 01.09.2004
   - Added : save "sort" state in "Import" tab
   - Added : Dump of LIB, OBJ, EXP files
   - Added : register OLE components even if typelib info isn't present
   - Fixed : start excel.exe with xls/cvs file
   - Fixed : Hscrollbar lost when sorting in "Import" tab

2.03 - 09.07.2004
   - Added : Option to change the depth of analysis in DLL dependencies
   - Added : Fix for cygwin DLL Dumping (bugged)
   - Added : group DLL redondance found in Import table
   - Added : typelib information of TLB files
   - Fixed : crash in 'Image File Header' when EXE have no Import Table
   - Fixed : crash with some Cygwin compiled DLL ( in parts )
   - Changed : rewriting some part (speed up file analysis)

2.02 - 18.06.2004
   - Fixed : crash in 'Import/Export' when you click outside selections
   - Fixed : increase compatibility with some EXE files
   - Fixed : hang with damaged executables
   - Added : read some unconventional VersionInfo
   - Added : Option to sort functions in 'Import/Export' tab
   - Added : Jump directly to tabs with CTRL-( 1 to 8 )
   - Added : register/unregister activex library
   - Added : typelib information
   - Added : image for SH3, SH4, SH5, ARM and AMD64 processors
   - Changed : page order to be more usefull with autosave option

2.01 - 20.03.2004
   - Added : %COMMANDER_PATH% can be used in fileinfo.ini for plugin paths   
   - Changed : rewriting some part (less memory used and speed up file analysis)
   - Fixed : crash with compressed-exe holding delay-load import
   - Fixed : crash in 'DLL dependency' on other EXE type than PE

2.00 - 16.03.2004
   - Added : can use plugin to pre-analysing, decoding or unpacking executables
   - Added : 'Dll dependency' test now missing functions
   - Added : copy of exported function undecorate or not(in 'Imports' tabs)
   - Added : Depth of analysis in DLL dependencies can now be chosen
   - Added : Delayed Import Table added to Dump
   - Added : Import/Export tabs
   - Added : Function imported can be tested and missing functions will be shown
   - Added : version of windows added in 'File properties'
   - Changed : demangling of borland C++ more accurate (still some problems with multi-nested template)
   - Changed : Names of section more explicit
   - Fixed : VersionInfo of Visual Basic executables not shown correctly

1.99 - not released
   - Fixed : version resource of .VXD and .386 files not shown under WinNT
   - Fixed : version resource with long string not shown
   - Fixed : some version resource entries not shown
   - Fixed : incompatibility with some executable
   - Fixed : Import Table not shown with some executable

1.93 - 07.02.2004
   - Added : 'w' key to switch WordWrapping in property or Header page
   - Fixed : crash in "Resource Dump" with most compressed EXE
   - Fixed : multi-language FileVersionInfo wasn't working on Win9x

1.92 - 03.02.2004
   - Added : Read all non standard VersionInfo entries...
   - Added : Support multi-language FileVersionInfo (like TC 6.01, ;-)
   - Added : Registry entries are now automatically make up when missing
   - Updated : Split Option/Info page
   - Fixed : Wrong FileVersionInfoSize  (Block Size)
   - Fixed : bad DLL name
   - Fixed : missing DLL or Delayed DLL
   - Fixed : Check RE and related messages are definitively removed
   - Fixed : some strange keystroke behaviour
   - Fixed : crash when recall QuickView
   - Fixed : crash with some EXE files without "Version Information"

1.91 - 24.06.2003
   - Fixed : (NT4/Win95) first branch of the tree is now expanded by default.
   - Fixed : (NT4/Win95) "File Properties" and "Image Header" tabs doesn't show scroll bar correctly
   - Fixed : crash in "Import Table Dump" and "DLL Dependency list" with some EXE

1.90 - 05.06.2003
   - Updated : additionnal information for NE executable
   - Updated : additionnal information for LE executable (VXD,...)
   - Added : links to HTML homepage and e-mail
   - Fixed : don't autosave when iconized or maximized
   - Fixed : crash in "Export Table Dump" with some compressed EXE

1.80 - 23.05.2003
   - Updated : Display compressed PE-EXE ( UPX, aspack, manolo, peload, pepack, pe-prot, 
     peshield, petite, securom, shrinker, VBOX/TimeLock, VGCRIPT, WWPack32, PE-Compact) 
     some have not been tested.
   - Updated : Format of hexadecimal numbers
   - Fixed : crash in "resource dump" with some compressed EXE
   - Fixed : crash in "Dll dependency" with some compressed PE-EXE
   - Fixed : bug with "debug info" from CodeView
   - Fixed : multiple instance started (message error related to "richedit" library)
   
1.7 - 20.05.2003
   - Added : Option to show symbol table, debug Information and line number if disponible
   - Added : Option to dump resources ( partial, may crash with compressed EXE )
   - Fixed : bug with Richedit library 

1.6 - 16.05.2003
   - Added : Display Undecorated Symbol Name for Microsoft C++
   - Added : Display Unmangled Fonction Name from Borland C++ ( partial )
(Unmangled names are shown by an arrow (->))
   - Added : Read LE and VXD Executable Header Information ( partial, in development )
   - Added : Search for compressed executables ( DOS only, in development )
   - Added : Display Dos Header Information for all files 
   - Added : Extra Dos Header Information displayed
   - Added : Get focus to RichEdit control
   - Fixed : bug with filesize of open file (in win95/98/Me)
   - Changed : Move 'File Characteristics' to beginning

1.5 - 09.04.2003
   - Merged all version (95, NT, 2000, XP)
   - Added : Read Dos Executable Header Information
   - Added : Read NE Executable Header Information
   - Added : Read LX Executable Header Information
   - Fixed : Handle now All delay-load DLL (Thanks to Matt Pietrek)
   - Changed : Dynamic reading of File Header (speed when just looking at file properties)
   - Added : option to disable checking of registry entries

1.42- 04.04.2003
   - Fixed : use now correct fontsize 
   - Added : some code to check if registry keys for TC are valid ( essential for font choosen by users )
   - autosave option fixed
   - Fixed : time and date in Win95 version
   - More compatibility with old delay-load DLL dependency 
   - some minor bugs fixed
      
1.41 - 31.03.2003
   - Corrected : Use Font and size choosen by user
   - Corrected : special build for Win95 and NT4 (ver 1.41.95)

1.4 - 30.03.2003
   - Open all PE files 
   - Create special build for Win95 and WinNT ( < NT5 ) (ver 1.4.95)
   - Change Page with "CTRL-TAB" in QuickView mode also      
   - "Select all" and "copy" managed
   - Add option to autosave windows position and size 
   - Add option to remember the last page open 
   - Use Font and size choosen by user
( You can use CTRL-Wheel to change temporarily font size)
   - More compatibility with old delayed DLL dependency 
   - Correct bug with two fileinfo open at same time
   - Correct some minor bugs

1.3 - 26.03.2003
   - New interface 
   - Correct some tabulations
   - Show delayed DLL dependency
   - Tree of Recursive DLL dependency
   - Show Image File Header 

1.2 - 22.02.2003
   - Show static DLL dependency

1.1 - 16.12.2002
   - Change some code to allow using MFC
   - Correct some tabulations
   - Convert GMT time of file to local time zone
   - Regional settings are now taken into account for the Date

1.0 - 4.12.2002
   - Initial public release

License Agreement
--------------------------------------------------------
This plugin is free software and provided "as is" without warranty of any kind, including, but not limited to, the implied warranties of merchant ability and fitness for a particular purpose. Should the program prove defective, you assume the cost of all necessary servicing, repair or correction.
This program can be freely copied/distributed without breaking distributive package integrity.

-----------------------------
Send comments to the author :
Fran�ois GANNIER  ( fgannier@physio-a.univ-tours.fr )
http://physio-a.univ-tours.fr/tcplugins/