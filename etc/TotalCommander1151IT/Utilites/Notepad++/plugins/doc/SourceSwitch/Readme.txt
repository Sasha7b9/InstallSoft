SourceSwitch 0.7 - 11th November 2012


Project page - https://sourceforge.net/projects/sourceswitch/

Please post on my project page if you find any issues, or if you have any feature requests


MD5
====
Unicode	-	2571798263ff19ece9e0fabf55f9cd38


Changes from 0.6
================

 - Bugfix: User added directories weren't searched correctly when looking for headers.

 - Bugfix: Backslashes not handled correctly when looking for headers.

Changes from 0.5
================

 - Added support for specifying additional directories to be searched during file switch (Thanks zaytsev1981 for the feature request).
	- Add directories in the configuration under the SourcePaths section.
          For example:

	[SourcePaths]
	SourcePath=C:\my_directory

 - Added support for reloading the configuration from within Notepad++.

 - Added full paths for files displayed in multiple files window.

 - Added DLL version information to SourceSwitch (Thanks davegb3 for the great blog post, I learned a few things).



Changes from 0.4
================
 - Added support for opening header files directly, rather than performing a switch.
   For example:

	#include "header.h"
        #include "inc_header.h"
	include ("../file1.php");

	etc

   Simply place the cursor on the desired line and hit the shortcut key (default F10). The code then attempts to work out what header you're looking for, and opens it. You can also select the header name directly within Notepad++ and hit the shortcut key to open the header. Doing this bypasses the header parsing code.

   I plan to add support for custom directories in a future release, so you could for example, include all your project files, but also some other directory stored on another part of your drive. 


Changed from 0.3
================

 - Added user prompt if file chosen to switch from has multiple matches. (i.e .h --> .c, .cpp or .cc) (Thanks to davegb3)
 - Setting can also be made default.

Changes from 0.2
================

 - Added support for periods in extension names.
 - Added support for the following extensions:

	- .xml		<-->	.xsd
	- .xml		<-->	.xsl
	- .aspx 	<--> 	.aspx.cs
	- .aspx.cs 	<--> 	.designer.aspx.cs
	- .pas 		<-->	.dfm
	- .pas 		<--> 	.lfm
	- .frm 		<--> 	.frx