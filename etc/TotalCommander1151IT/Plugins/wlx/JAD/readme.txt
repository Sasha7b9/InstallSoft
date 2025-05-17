TC Jad Plugin 1.1
===================

    JAD Lister plugin for Java binary .class files. Uses jad to decompile the .class file and displays the resulted code highlighted in TC Lister.
    
Features
========

    - View any java .class file decompiled by jad in TC Lister window
    - The code is highlighted, selectable and searchable as the plugin uses the default Lister window so all other default Lister functions are available
    - Fast as it is written in C++
    - Win XP/Vista/7 and TC x32/x64 compatible

Installation
============

    Automatic installation is supported - open tc_jad_plugin.zip using Total Commander and choose yes to install it
    
    Manual Installation
    
        1. Unpack tc_jad_plugin.zip wherever you would like to install it
        2. In TC go to Configuration -> Options -> Plugins -> Configure (next to Lister Plugins (.WLX))
        3. In Lister plugins window click Add and browse to tc_jad_plugin.wlx in the location where you chose to unpack tc_jad_plugin.zip
        4. Click OK to close Lister plugins window
        5. Click OK to close TC Configuration window
        6. DONE
    
    You can now press F3 on any class file to view its decompiled code. Enjoy :)
    
Credits
=======

    TC Jad Plugin is written by eSandrei (eSandrei@yahoo.com) and internally it's using jad 1.5.8g (written by Pavel Kouznetsov) to decompile the java class files
    
Source
======

    The source is opened and available in tc_jad_plugin_sources.zip. I used Eclipse C++ as IDE and MinGW as compiler so you can just import the .cproject in Eclipse
    
    To use Eclipse C++ you just need to download it (http://www.eclipse.org/downloads/moreinfo/c.php). Also download and install a compiler like MinGW(http://www.mingw.org/wiki/HOWTO_Install_the_MinGW_GCC_Compiler_Suite) and MinGW-w64(http://mingw-w64.sourceforge.net/) to build tc_jad_plugin for TC x64
    
    I started from the official Lister plugin sample which is a VC++ 6.0 project so VC++ can also be used (beware on newer versions of VC++ which require manual configuration of listplug.def to create the right DLL interfaces signature)

Release Notes
=============
TC Jad Plugin 1.0.1
- binary for TC 64-bit

TC Jad Plugin 1.1
- added support for unicode paths and filenames
- fixed bug: plugin doesn't work for filenames that don't match the enclosed class name
- fixed bug: font is not displayed properly on Windows Simplified Chinese Edition - incorporated suggested fix from yyang