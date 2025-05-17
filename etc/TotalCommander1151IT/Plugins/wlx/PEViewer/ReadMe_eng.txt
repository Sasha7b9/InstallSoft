================================
PE Viewer 3.0
================================

The plugin is designed to view information about modules of PE, MZ, NE, LE and ELF formats (EXE, DLL, SO, DRV, SYS, OCX, COM, etc.).
Shows:
- summary information about the file: size, timestamps, hashes and entropy.
- statistics from virustotal.com.
- signature analysis of "PE Sniffer" and "PEiD".
- detailed information about sections and module headings.
- functions exported by the module.
- imported external modules and their functions used. With the ability to open the selected external module in a separate instance of the plugin.
- resources contained in the module. With the ability to view, copy to the clipboard and save all resources.
- digital signatures and certificates. With the ability to check the validity of the signature of the module itself and the validity of the certificates used.
- debugging structures with detailed analysis.
- load configuration structure with detailed analysis.
- CLR header of the .Net assembly. With the ability to display the versions installed in the OS ".Net Framework" and ".Net Core".

Link to download the plugin and discuss it on the forum:
http://totalcmd.net/plugring/peviewer3.html
https://wincmd.ru/plugring/peviewer3.html

================================
Reference. Description of use:
================================

Main form:
1) The algorithm for opening files by the plugin has been changed. Removed the formation of the "detect" line. After installing the plugin, be sure to remove the "detect" line in the "Total Commander" configuration file to be able to open files of any extension.
File checking algorithm (folders are ignored):
  a) If the file extension is included in the list of known PE files, then we go to execution and create a GUI. Even if the file is damaged, the user will receive a message. The idea is that a GUI will always be created for known extensions.
Well-known extensions: 'EXE', 'DLL', 'DRV', 'SYS', 'OCX', 'COM', 'AX', 'CPL', 'SO', 'SCR', 'MUI', 'ACM' , 'BPL', 'EFI', 'WINMD', 'TSP', 'WLX', 'WFX', 'WDX', 'WCX', 'WLX64', 'WFX64', 'WDX64', 'WCX64'.
  b) File with unknown extension. If the file contains the correct MZ, PE markers and Machine type, then we proceed to execution and creation of the GUI.
  c) If the file fails these checks, then nothing is executed and "Lister" passes control to the next priority plugin.
2) The "Help" submenu contains a list of files of the form "ReadMe_???.txt" from the plugin installation folder. When you select a menu item, the corresponding file opens in the associated OS editor. These files update the description of the main features of the plugin and version changes. A must read.

"Info" form:
1) Display a link to virustotal.com with the default browser opening in the OS when double-clicked. Displays file statistics when the "Get file status" option is enabled. Using the "Use old link" option, you can create a link to a light text page without interactive elements.
2) To analyze the compiler, the signature databases of the "PETools / PE Sniffer" (Signs.txt) and "PEiD" (UserDB.txt) projects are used. Controlled by the "Detect compiler" option
". Two analysis methods use only searching starting from OEP.
3) Display markers:
- "Rich Header" and "CLR Header (.NET)" if appropriate structures are available.
- "COM (TYPELIB)" if the corresponding resource is available.
- "OLE (regsvr32)" if there are exported functions DllRegisterServer and DllUnregisterServer.
- "UPX" if there are sections of the form "UPX?". If you hover the cursor over the marker and the "UPXPath" parameter is set, the cursor will change to a hand. Double-clicking the file unpacks it into the temporary folder "%TEMP%\_tc". If the unpacking is successful, a new "Total Commander" process is launched to display the unpacked file in the plugin, otherwise an error message will be displayed. The unpacked file is not deleted.

"Import" form:
The selected import module can be opened in a separate instance of the plugin through the "Open in plugin" context menu item.
Description of the statuses of imported modules:
1) Empty line, color black - the library was found, loaded and all functions were also found.
2) Exclamation mark in a triangle or the letter "E", color red - library not found.
3) Exclamation mark in a triangle or the letter "E", color purple - the library was found, loaded, but some functions are missing.
4) Hourglass or letter "D", the color reflects the meaning of the first three points - deferred library import.

"Resources" form:
1) An algorithm has been implemented to automatically determine the data format for displaying each resource.
Current supported formats: String Table, Message Table, Accelerator Table, Dialog, Menu, Cursor, Icon, Bitmap, Version, Manifest, TXT, JPG, PNG, GIF, BMP, MUI, TYPELIB and Delphi resources (TPF0, 'PACKAGEINFO', 'PACKAGEOPTIONS', 'DVCLAL', 'PLATFORMTARGETS', 'DESCRIPTION', 'BORLAND_SIG').
For each data format, a corresponding icon in the tree and an extension are assigned when saving.
2) The ability to save all resources through the context menu or see the "Keys" section has been implemented.
When saving multiple resources, a folder is created with the name of the corresponding root node, into which the selected children are copied.
When you save root resources, folders are created with the name of the corresponding root node, into which all child elements are copied.
3) The ability to copy graphic and text resources to the clipboard has been implemented.
4) In the tree, for root elements, the number of child elements is added to the name.
5) When you select the root element, a list of child elements with their properties is displayed.
6) The properties of the selected resource are displayed in a separate list.

Keys:
1) To navigate through forms (tabs), use the keyboard shortcuts Ctrl+Tab (forward) and Ctrl+Shift+Tab (backward).
2) To navigate components inside the form, use the Tab (forward) and Shift+Tab (backward) key combinations, and for the "Quick View" mode - Enter (forward) and Shift+Enter (backward).
3) List and tree graphic components support multiple selection of elements using the Ctrl and Shift keys. In tree graphic components, you can only select nodes of the same level.
4) To open the settings menu, use the F12 key.
5) To set the "On Top Of Window" option for the current plugin window, use the F11 key. The option is not saved in the configuration file.
6) Tree and list components support searching for elements when typing their names from the keyboard. Search is case insensitive and only from the beginning of the word.

Configuration file:
1) Name of the plugin parameters section [PEViewer].
2) Settings menu options:
- ActiveTab=ctInfo - default value. The name of the active tab. Valid values: ctInfo, ctHeaders, ctExport, ctImport, ctResources, ctSignatures, ctDebug, ctLoadConfig, ctCLRHeader.
- RememberActiveTab=True - default value. Whether or not to remember the active tab.
- Language= - default value. Plugin localization languages. Valid values: empty value - internal English, Belarusian, Chinese (Simplified), Czech, English, German, Russian, Ukrainian.
- UseLSPluginIni=False - default value. If UseLSPluginIni=True, then the lsplugin.ini file is used to store plugin parameters (the "Total Commander" configuration file for WLX plugins, the location is specified by the user), otherwise the PEViewer.ini file in the plugin folder is used.
If the PEViewer.ini file is missing, then the option UseLSPluginIni=True.
If the PEViewer.ini file exists, the UseLSPluginIni value is read. If there is no parameter, then UseLSPluginIni=False.
- VTGetFileStatus=True - default value. Allows you to add the VirusTotal file status in the "X/Y" format to the "virustotal.com" line on the "Info" form, where X is the number of triggered security analyzers, Y is the total number of security analyzers used. The value "-/-" means that the transmitted hash of the file is not in the VirusTotal database. The value "Enumber" is the network communication error code.
- VTUseOldLink=False - default value. Allows you to create a link to a page with interactive elements or to a light text page without interactive elements.
- DetectCompiler=True - default value. Allows you to manage the search for signatures from the Signs.txt and UserDB.txt files.
- Theme=ttAuto - default value. ttAuto - the mode is taken from "Total Commander", ttDark - dark and ttLight - light.
- UPXPath= - default value. Specifies the full path to the upx.exe file (https://upx.github.io/).
- MainForm.tcToolbar.Style=tsFlatButtons - used to set a flat tab style only for the light theme and without changing the standard color through the "BackColor" parameter.

Peculiarities:
- For the list component, copying the contents of a cell by double click has been implemented.

The plugin was tested on Windows XP SP3, Windows 7, Windows 8.1, Windows 10 and Windows 11.

================================
History of changes:
================================

3.0.17.1
[*] For the "Resources" form:
- Support for the MUI file and the MUN file of the current investigated file. You can open in a new copy of the plugin on a double click or from the context menu. MUI files are used for localization (for example, Explorer.exe). MUN files are used to store resources (for example, Shell32.dll). Previously, all resources were stored in a single file, but starting with Windows 10, resources were put into a mun file. If the color is highlightColor, then the version of the main file and resource coincides, otherwise the color will be HighlightColor2.
- The opening of the resource with the MZ signature in the new copy of the plugin is implemented (for example, Sysinternals\Prosexp64.exe\binres\150). The binary resource is extracted into a temporary folder by analogy with the UPX and its opening.
- Added the contextual menu item "Go To Node" for the list of elements of the node.
- The problem of insufficient height of the list of resource properties for various screen resolutions and scaling has been eliminated.
- Fixed a sort error for the list of node elements.
[*] For the "Debug" form, the sorting error "Size Of Data" is fixed.
[*] For the "Sections / Headings" form, the output of the fields of versions and in decimal form was finalized.
[*] For the "Sections / Headings" form, in the tree of the sections, the format for the output of the fields ID_ish_MISC and id_ish_SIZEOFRAWDATA as a file is changed. Convenient for large sections.
[+] For the "Info" form added a contextual menu item "Open In Plugin" for Virustotal and UPX.
[*] When the file is opened in the new plugin copy through the "Open In Plugin", the opened tab will be current rather than saved.
[*] For the list of component, the algorithm for calculating the width of the column is finalized, taking into account the symbol of the sorting, so that the text of the header of the column does not cut off.
[*] The localization error "Assembly Version" is eliminated.

3.0.17
[*] For the "Digital Signatures" form:
- Fixed an error in reading WinCertificate records from the IMAGE_DIRECTORY_ENTRY_SECURITY table. All records of this table are displayed, unlike the plugin "CertView 2.9.2".
- Fixed an error in displaying the CryptUIDlgViewSignerInfo dialog for the selected signature (Context menu\Details Space). This dialog is called from the standard file properties dialog on the "Digital Signatures" tab.
- Added display of signatures "Countersignatures".
- For "Authenticated Attributes", "Unauthenticated Attributes" and "Extensions" the value is output as a BLOB for unknown elements.
- Expanded nodes "Authenticated Attributes", "Unauthenticated Attributes" and "Extensions".
- Each WinCertificate entry has its own "MsgAndCertEncodingType", "ContentType" and "FormatType" fields.
- For "Authenticated Attributes" two elements have been analyzed.
- Added the "EncodingType" field for certificates.
[*] For the "Resources" form:
- The display of scrollbars is blocked for the list of resource properties.
- Added the ability to sort by columns for the list of node elements.
- Changed the resource type output format. If "DataTypeOriginal" and "DataType" are not equal, then they are separated by a slash.
[*] For the "Load Configuration" form, the error in parsing the data structure has been fixed.
[*] For the context menu for copying a column value of a list component, the “Copy cell” localization has been corrected.
[+] For the "Sections / Headings" form, parsing of MZ, NE, LE and ELF headers has been implemented. For now, only Little-Endian supports ELF and ELF64.
[+] For the "Info" form, the Entropy field has been added.
[*] The output of the TYPELIB resource has been improved.
[*] For the "Info" form, the path to the file is copied to the clipboard upon successful UPX unpacking. By analogy as when opening a link to VirusTotal.
[*] For the "Resources" form, copying icons and cursors to the clipboard has been implemented.
[*] For the "Resources" form, the Language and CodePage columns have been added to the list of node elements.
[*] UPX unpacking error has been fixed. If you open an executable file from an archive, "Total Commander" will place it in "%TEMP%\_tc", which is also used by the plugin for unpacking UPX. To avoid conflicts with directory paths, the temporary directory "%TEMP%\_tc\pv" is set for the plugin.
[*] For the text component, the error in setting the font size to small for the light theme has been fixed.
[+] Support for environment variables has been implemented for the UPXPath parameter. For example, UPXPath=%COMMANDER_PATH%\Utils\upx\upx.exe.
[*] The output of the VarFileInfo structure has been improved with the output of all "Language" and "Code Page" pairs.
[*] The output of the VS_FIXEDFILEINFO structure has been expanded.
[*] The function of obtaining the code page name has been improved. 1200 is processed correctly.

3.0.16
[+] Implemented UPX unpacking. The "UPXPath" parameter has been added to the configuration file to specify the path to upx.exe. The "UPX" marker has been added to the "Info" form. If you hover the cursor over the marker and the "UPXPath" parameter is set, the cursor will change to a hand. Double-clicking the file unpacks it into the temporary folder "%TEMP%\_tc". If the unpacking is successful, a new "Total Commander" process is launched to display the unpacked file in the plugin, otherwise an error message will be displayed. The unpacked file is not deleted.
[+] For the "Resources" form, parsing of the "TYPELIB" resource in the "MSFT" format has been implemented. The "SLTG" format is not supported. Implemented the ability to view multiple "TYPELIB" resources, and not just the very first one, as in the "FileInfo 2.23" plugin.
[+] For the "Sections / Headings" form, the validity of the "OptionalHeader.CheckSum" and "Rich Header.CheckSum" fields has been implemented. If the value is incorrect, it is marked with an error color and the correct value is added in brackets.
[+] For the "Info" form, a line output of the full path of the file has been added. The short path (name~1) is converted to a long path. Also, the parameter settings file block has been moved to the beginning of the list.
[+] The "Info" tab now displays a file block of parameters for unsupported LE, NE and MZ formats.
[+] For the "Resources" form, I implemented the display of the number of elements in a node, as well as the display of a list of child elements.
[+] Added the "Detect compiler" option to the settings menu. Allows you to manage the search for signatures from the Signs.txt and UserDB.txt files.
[*] The project has been rebuilt with Embarcadero 12.2.1.
[*] For the "Info" form, the error in completing the auxiliary thread for calculating hashes and obtaining VT status when quickly running through files in Ctrl+Q mode (quick view) has been fixed.
[*] For the "Resources" form, reading all resources has been changed to use the file-to-memory mapping mechanism. All file operations and intermediate buffers are removed.
[*] Fixed an error in attribute checking when opening a directory.
[*] Fixed an error in reading the header of a PNG image.
[*] Fixed an error in reading the "PACKAGEINFO" resource.
[*] Fixed an error in parsing the import table.
[*] Fixed an error in setting the icon for the "Accelerators" resource.
[*] Fixed an error when determining the resource type.
[*] The block of copied information has been expanded when clicking on the brief information tab "PE32 ...". Implemented changing the mouse cursor when hovering. Also for a bookmark with a description of the error.
[*] The algorithm for opening a file in Ctrl+Q (quick view) mode on the '..' element when unpacking a file with the wcx plugin has been improved.
[*] Fixed error in displaying "Entry Point Raw Offset" from 8 to 4 bytes.
[*] A new parameter "GridLines" has been added to the PEViewer.ini configuration file for theme sections for displaying the grid in the list component. Also renamed the "ImportantColor" parameter to "HighlightColor2".
[*] Improved light theme. If you only need to set the style of flat buttons for the light theme and the standard color will not change, then in the configuration file you need to uncomment the line "MainForm.tcToolbar.Style=tsFlatButtons".
[*] Code optimization and minor GUI improvements.

3.0.15
[+] A new tab "Load Configuration" has been added.
[+] Added support for 24 types of processors for the PE format.
[+] Retrieving color values and font parameters from the PEViewer.ini configuration file has been implemented. Sections and parameters are described in PEViewer.ini of the plugin installation archive.
[+] The 'Theme' item has been added to the main menu with three modes: auto - the mode is taken from 'Total Commander', dark and light.
[*] The order of the tabs has been changed.
[*] For the "Import" form, the error of opening the imported library in the plugin if there are spaces in its path has been fixed.
[*] For the "Debug" form, two exceptions in processing data structures have been eliminated.
[*] For the "Resources" form, the drawing of jpeg, png and gif image types with animation through standard modules, and not through WIC, has been redone. The problem with displaying images in Windows XP has been resolved. Large images are now scaled to fit the display area.
[*] For the ListView component, the context menu item for copying column values ??has been improved.
[*] For the TreeView component, copying the name and value of a node with child elements has been improved.
[*] The sorting direction arrows of the ListView component have been changed.
[*] For data fields that reflect quantity or size, the output format has been changed to 'hex (int)'.
[*] Minor changes to the GUI and constant literals.

3.0.14
[+] For the "Info" form, functionality for interaction with virustotal.com has been implemented: obtaining the file status and generating a link for new and old browsers. The corresponding options are available in the main settings menu. The file status is displayed after the text "virustotal.com" in the "Property" column. The value "-/-" means that the transmitted hash of the file is not in the VirusTotal database. The value "Enumber" is the network communication error code.
[+] For the "Import" form, the imported library can be opened in a new instance of the plugin. "Total Commander" allows you to open a given plugin only in a separate process.
[+] Support for the new resource type "DIALOG" in two formats has been added for the "Resources" form.
[+] For the "CLR Header" form, the output of a list of installed ".Net Framework" and ".Net Core" in the OS has been implemented.
[+] For the "Info" form, a marker for the presence of an OLE interface has been added, i.e. DllRegisterServer and DllUnregisterServer functions.
[+] For list components, alternating background color of rows has been implemented. The option is available in the main settings menu.
[+] The hotkey F11 is assigned to the main menu item "On Top Of Windows".
[+] For the main menu item of the plugin version, items have been added to the plugin pages of the sites wincmd.ru and totalcmd.net.
[+] Added a Chinese (simplified) localization file for the program.
[*] For bookmarks, the problem of the "parasitic hint" (hint shadow) has been fixed.
[*] For the "Debug" form, the error of the large font size of the text description has been fixed.
[*] A memory leak has been fixed for the "Import" form.
[*] For the "Resources" form, the error in group saving of the "MUI", "MENU" and "DIALOG" resources has been fixed.
[*] For the "Resources" form, the crash error of "Total Commander" when parsing "STRING" resources has been fixed.
[*] For the "Resources" form, the output of the "STRING", "MESSAGE", "MENU" and "VERSION" resources has been improved.
[*] For the "Resources" form, the output of the "BITMAP", "ICON" and "CURSOR" resources has been redesigned. Code optimization.
[*] For the "Resources" form, the resource tree nodes have been renamed.
[*] For the "Info" form, detailed output of the values ??"File type", "File subtype", "File attributes" and "Target OS" has been implemented.
[*] Dynamic display of file size has been implemented for the "Info" form.
[*] The output of the "Language" and "Code page" fields has been improved: hexadecimal and decimal values.
[*] The context menu for the "Resources" form has been improved.

3.0.13
[+] For the "Info" form, an item with a link to virustotal.com has been added. When you double-click on the virustotal.com line, a page opens in the browser and the link is copied to the clipboard. SHA1 hash has been replaced with SHA256.
[+] For the "Info" form, a marker for the presence of the TYPELIB resource of the COM/ActiveX object has been added.
[+] For the list component, copying the contents of a cell by double click has been implemented. For the "Sections / Headings" form, the ability to go to the section node by double-clicking the list component element has been removed.
[+] Added a Czech localization file for the program.
[*] For the "Debug" form, the output of the IMAGE_DEBUG_NB10, IMAGE_DEBUG_RSDSI, IMAGE_DEBUG_TYPE_FPO and IMAGE_DEBUG_COFF structures has been improved and expanded. The text field is set to a monospace font. Some data has been translated into tabular form.
[+] For the "Resources" form, support for the new resource type "MENU" in two formats has been added.
[*] For the "Resources" form, the output of the "MUI" resource has been improved.
[*] For the "Info" form, the output of strings in the absence of the StringFileInfo structure has been corrected.
[*] The code for correctly releasing the plugin to avoid file blocking has been improved.
[*] The German localization file for the program has been updated.

3.0.12
[+] Added a new form "Debug".
[+] Added the "On Top Of Windows" option to the settings menu.
[+] For the "Import" form, the label has been added to display the number of delay import modules.
[+] For the "Sections / Headings" form, highlighting of the validity of the "Data Directories" and "ImageBase" fields has been added.
[*] For the list component, the error in copying a line with an empty caption has been fixed.
[*] For the "Resources" form, the problem with "Select all" not working from the context menu of the tree element has been fixed.
[*] For the "Resources" form, the problem of hot keys not working for the list of properties of the current resource has been fixed.
[*] For the "Resources" form, full copying of text resources to the clipboard without the need for selection has been implemented.
[*] For the "Resources" form, the error in displaying the size of the icon or cursor has been fixed.
[*] For the "Resources" form, the display of the Accelerator resource has been improved.
[*] For the "Import" form, loading of modules without an extension has been fixed.
[*] For the "Import" form, the sorting of functions by "Ordinal" has been fixed.
[*] For the "Sections / Headings" form, the error in displaying the number of "Data Directories" elements has been fixed.
[*] Fixed error in reading section headers.
[*] Fixed error in reading the certificate table.
[*] Fixed an error in reading the import table.
[*] Fixed an error in reading the delay import table.

3.0.11
[+] Support for Windows XP has been implemented. Fixed: display of Unicode characters, dark text of the selected tab, resource saving dialogs, height of the resource properties panel and section list.
[+] Added a German localization file for the program.
[+] Copying the text of the summary information tab and the error description tab to the clipboard by clicking the mouse has been implemented.
[*] For the "Info" form, the error in displaying the multilingual resource VERSION has been fixed.
[*] For the "Import" form, the error in loading the import table has been fixed.
[*] For the "Import" form, the error in finding the path for the "Universal CRT" modules has been fixed.
[*] For the "Import" form, the "Number" column of the list component of the module functions has been added. Functions that do not have a name and are called through a sequence number.
[*] For the "Resources" form, the error in displaying the "ID" of the resource string "String" for the third nesting level has been fixed.
[*] For the "Resources" form, the algorithm for recursive saving of resources has been improved.
[*] Small icons of resource tree nodes have been corrected for the "Resources" form.
[*] For the list component, the error of overwriting column labels has been fixed.
[*] For the list component, the error in calculating the width of the last column has been fixed.
[*] Fixed display of "Message Table" resources.
[*] Configuration file parameters have been renamed. Changed plugin parameter to use lsplugin.ini. Described in detail in the help.

3.0.10
[+] Added a new form "CLR Header". For .Net assemblies, the target platform is added to the information label.
[+] Implemented "Dark Mode". Installed automatically based on the TC theme. Grid is disabled for list components.
[+] For the "Resources" form, an algorithm for determining text resources (ANSI, UNICODE16LE, UNICODE16BE and UTF8) has been implemented. See Windows OS components.
[+] Support for new resource types "MUI", "HTML" and "REGISTRY" has been added for the "Resources" form.
[+] A properties panel for the current resource has been added to the "Resources" form.
[+] A plugin version item has been added to the settings menu. When clicked, the plugin web page opens.
[*] The "Import / Export" form is divided into two separate forms: "Import" and "Export".
[*] For the "Export" form, the list component is switched to virtual mode. It is now possible to view over 20,000 exported functions.
[*] For the "Digital Signatures" form, "Status" verification fields for signatures and certificates have been added. "Type" field for signatures. Added names in X500 format for "Subject" and "Issuer". Long fields are hidden in child nodes.
[*] Display in HEX mode has been fixed for the "Resources" form.
[*] For the "Resources" form, the display of broken resources has been improved.
[*] For the "Import" form, the problem with displaying Unicode characters for the "Status" column has been fixed.
[*] Fixed sorting of the last column of the list component.
[*] Flickering of components during fast transitions in the "Quick View" TC mode has been eliminated.
[*] The code for applying localization without re-reading data has been improved.
[*] For forms, the display of separators and their correct position when loading have been improved.

3.0.9
[+] Added support for PE format for "ARMNT", "ARM64" and "Intel AI64" (Itanium) architectures.
[+] For the "Digital Signatures" form, parsing of the "Extensions", "Public Key" and "Encrypted Hash" fields has been implemented. Improved information display.
[+] For the "Resources" form, the text information output component has been replaced. Unicode support has been implemented.
[*] The output of brief information about the format, architecture and byte order has been updated.
[*] The "MachineType" description lines have been corrected.
[*] Improved definition of DOS format.
[*] Fixed a bug in applying localization.

3.0.8
[*] For the "Info" form, the error loading the "VersionInfo" resource has been fixed.
[*] For the "Resources" form, the error loading resources has been fixed.
[+] A new tab "Digital Signatures" has been added.
[+] For the "Resources" form, support for new resource types "Accelerator" and "Message Table" has been added.
[+] For the tree component, the context menu items "Copy Value" and "Copy Name" have been added.

3.0.7
[*] For the "Sections / Headers" form fixed an error of copying contents of tree nodes (Ctrl+C).
[*] Fixed bug of applying localization when opening two or more Listers.
[*] The algorithms for searching for signatures using the "PEiD" and "PE Sniffer" databases have been reworked.
[*] For the "Info" form, a permanent compiler definition has been implemented.
[+] For the "Info" form added output of MD5 and SHA1 file hashes.
[+] For the "Export / Import" form a waiting window is implemented when performing long calculation operations.
[*] Reworked the code for reading and saving settings to a configuration file. Removed the use of the PEViewer_config.ini file.

3.0.6
[*] Fixed error of reading "StringTable" structure with empty elements.
[*] Fixed a bug in loading the delay import catalog.
[*] Fixed error of loading a file with "IMAGE_NT_HEADERS" structure equalized at the 2Kb boundary.
[*] Fixed bug of searching for dependent modules.
[*] Fixed the problem of intermediate resizing and redraws when embedding the plugin's main form in the owner window. The effect is noticeable in "Quick View" mode when going through the list of files.
[*] For the "Sections / Headers" form fixed an error in displaying the description of "Flags" sections for the "Align" value.
[*] For the "Resources" form fixed the error of resource language code loss displayed in the status line.
[*] For the "Resources" form fixed hotkeys for resource display modes Ctrl+1-4.
[*] For the "Resources" form fixed vertical separator placement error.
[*] For the "Resources" form fixed the error of losing focus when canceling the save dialog.
[*] Fixed the algorithm for selecting and focusing components.
[*] AutoSize of columns of the list component has been improved.
[+] For the "Resources" form the algorithm of automatic detection of data formats for display has been implemented. It is described in detail in the help.
[+] For the "Info" form, the display of the "Characteristics", "DllCharacteristics" and "File Accessed" fields has been added.
[+] For the "Info" form, the display of the presence of the "IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR" structure (CLR Header) has been added. One of the hallmarks of a .Net application.
[+] For the "Info" form, the presence of the headers "Rich Header" and "CLR Header" is highlighted.
[+] For the "Quick View" mode, additional keys for bypassing components inside the form (Enter and Shift+Enter) have been added. It is described in detail in the help.
[+] For the "Resources" form the copying of images to the clipboard has been implemented.
[+] For the "Resources" form, the component of the list of icons or cursors is hidden if it contains only one element.
[+] Added "Help" element to the main form in the settings menu.
[+] For the main form, the settings menu can be opened by pressing F12.
[*] The algorithm for opening files by the plugin has been changed. Removed "detect" string generation. It is described in detail in the help.
[*] For the "Export / Import" form, the processing time for structures of imported and exported functions has been reduced.
[*] For the "Export / Import" form, the time for building and checking imported modules and their functions has been reduced.
[*] For the "Resources" form, the function of saving graphic files has been redesigned. Also fixed the code for correctly saving "Bitmap" resources.
[*] Improved algorithm for detecting PE files.
[*] Improved code for displaying "Language" and "CodePage" on the "Info" and "Resources" forms.
[*] Reading of the list of elements of structures "StringFileInfo" and "VarFileInfo" is implemented.
[*] For the "Export / Import" form, symbolic display of module status has been simplified. It is described in detail in the help.
[*] For the "Resources" form, the display of strings from the resource of a packed file has been fixed. Now an inscription about the incorrectness of the data is displayed.
[*] For the "Resources" form, the rendering of graphic files has been improved and parasitic flickering of components has been eliminated.
[*] For the "Sections / Headers" form, the tree nodes "IMAGE_FILE_HEADER" and "IMAGE_OPTIONAL_HEADER" are expanded by default.
[*] Corrections of program localizations.
[*] Internal code optimization.

3.0.5
[+] For the "Headers / Sections" form display of the "Rich Header" structure has been implemented. A checksum verification algorithm has also been implemented. If the checksum is incorrect, "CheckSum" is displayed in red.
[+] For the "Info" form the presence of the "Rich Header" structure is displayed.
[+] For the "Headers / Sections" form backlighting of the "CheckSum" and "Data Directories" tree elements has been implemented.
[*] Fixed handling of number keys 1-8 in Lister.
[*] For the "Export / Import" form fixed error of "Delay" status loss (hourglass) for imported libraries.
[*] Internal code optimization.

3.0.4
[*] Updated and fixed flags for PE structures: "Section Flags", "Machine Types", "Characteristics", "Windows Subsystem" and "DLL Characteristics".
[*] Fixes for the fields of the IMAGE_OPTIONAL_HEADER structure.
[*] Fixed error in determining file offset address for exported functions.
[*] Fixed handling of F3, F5, F7 and Backspace keys in Lister.
[*] Fixed error when the program loses focus when canceling the save resources dialog.
[*] Localization fixes for the program.
[+] Using double buffering to draw the content of all forms.
[+] Use the same font for all forms.
[+] Ability to navigate through components using the Tab/Shift+Tab keys.
[+] For the status bar of the "Resources" form added ability to copy text by double mouse click.
[+] For the "Headers / Sections" form backlighting of some elements of the tree is implemented.
[*] For the "Headers / Sections" form transition from a list element to the corresponding tree element by double mouse click or Enter key is implemented.
[*] For the "Headers / Sections" form a single hotkey for copying text data Ctrl+C is assigned.
[*] For the "Headers / Sections" form hexadecimal output of the value itself has been added to the string format of field data.
[*] For the "Headers / Sections" form the "Attributes" column contains a text description.
[*] Internal code optimization.

3.0.3
[*] The algorithm for reading versioned structures has been redesigned. Now information for C# modules is displayed correctly.
[*] For the "Export/Import" form added error output when reading import and export sections. Necessary for packed modules.
[*] The display order of information data blocks on the "Info" and "Resources" forms (Version element) has been changed.
[*] Redesigned context menu. Added item "Copy name". Hotkey combinations have been changed.
[+] Added support for *.DRV, *.EFI and *.WINMD files.
[+] Added files of Belarusian and Ukrainian localizations of the program.
[+] Added the "Catalog" column for imported modules.
[*] GUI fixes.
[*] Localization fixes for the program.
[*] Eliminated program execution exceptions.
[*] Internal code optimization.

3.0.2
[+] Added the ability to group save resources.
[+] Added the ability to view PNG resources.
[+] Added English localization file for the program.
[*] GUI fixes.
[*] Localization fixes for the program.
[*] Internal code optimization.

3.0.1
[*] The project was rebuilt by Embarcadero 11.3.1.
[*] Fixed errors in the 64th version of the plugin.
[*] Fixed GUI bugs.
[*] Fixed errors in the display of different types of resources.
[*] Internal code optimization.
[*] The custom graphics components have been replaced by the standard ones.
[*] The "PEiD" database has been updated.
[+] Added support for High DPI.