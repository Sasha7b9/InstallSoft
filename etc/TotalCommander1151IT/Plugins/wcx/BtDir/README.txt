-------------------------------------------------------------------------------
btdir - Total Commander plugin, interpret torrent-file as a directory.
Version 0.1 beta4
-------------------------------------------------------------------------------


===============================================================================
WARNING!!!

DO NOT COPY FILE FROM TORRENT-"ARCHIVE" INTO DIRECTORY WHERE THIS FILE IS!!!

Total Commander will "polite" delete this file before btdir can understand that
this file is the same as a file will be copied into itself. As a result of this
file to be copied will be ERASED!!!
===============================================================================


This plugin is free for any using and in the hope that it will be useful, but
WITHOUT ANY WARRANTY and NO SUPPORT. If user have two or more spare yuans or
other banknote he (she) can spend it for two or more bottle of beer (ale) for
author.

Tested with TC 7.04a, 7.57a and 8.0 beta 23 (x64).

"Extraction" and testing is possible only if torrent file is in the same
directory as torrent file (directory) data.


INSTALL
-------

Auto: enter into zip file with TC.

Manual:

	1. Unzip the btdir.wcx into some directory.
	2. In TC choose 'Configuration/Options', open 'Plugins' page.
	3. Click 'Configure' in 'Packer plugins (.WCX)'.
	4. Type 'torrent' as the extension.
	5. Click 'New type', and select the unpacked btdir.wcx.
	6. Click 'OK'.


"SPECIAL" FILES
---------------

<torrent_file>-dump.txt - dump of torrent content.

<torrent_file>-list.txt - list of files in torrent with offsets of starts and
information about where data starts.


AUTHOR
------

Oleg Bondar aka Hobo (hobo-mts@mail.ru).

Subject of message must contain word 'btdir'.


CHANGES
-------

0.1 beta4 (2012/03/22)

* Plugin linked with runtime library statically and don't depend on msvcrt.dll.

+ Added x64 version.


0.1 beta3 (2012/02/14)

+ Into <torrent_file>-list.txt added torrent hash, comment if exists, total
size of hash summs of torrent data, approximate size of 'info' dictionary.

+ Added searching for text in torrent-"archives". If plugin updated you need to
  reinstall it. Or jast remove string "NNN," from parameter

	[PackerPlugins]
	torrent=NNN,<path>\btdir.wcx

  in wincmd.ini when TC is not running.

+ Now it is possible to hide "special" files. To do it add parameter
  no_fake_files=1 into [btdir] section of plugin's INI-file (usually
  %COMMANDER_PATH%\pkplugin.ini).

- Plugin was crashed when opening torrent with one file in directory. Thanks
  Rodny for torrent example.


0.1 beta2 (2010/10/23)

+ Added background testing.

* Added handling file names in torrent file made with programs that makes file
  names in local code page ANSI and optionaly UTF-8.


0.1 beta (2010/10/15)

* First beta.
