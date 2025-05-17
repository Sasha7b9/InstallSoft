MathPad: a Plugin for the Open Source (free) Notepad++ (Npp) Text Editor 
Version: 0.0.4.8 (Unicode)
By: Carlo Somigliana, email: somic@libero.it, site: www.semelinanno.com

Original Web Page: http://semelinanno.com/downloads/mathpad/MathPad_Page.html

**************************************************************************

		LICENSE SUMMARY

This program FREEWARE and provided "AS IS". You use it at your own risk.   
It has been tested with Notepad++ v5.5 (Unicode)

**************************************************************************

PROGRAM DESCRIPTION:

First thanks to Scintilla developer(s) and Donho for the Notepad++, 
without it this plugin wouldn't exist :-)
MathPad is a Math Evaluator of math script files for Notepad++ (ANSI)  
It gives to Npp math capabilities to calculate and plot expressions,   
functions, polynomials, integrals, matrices, derivatives.  
It incorporates the math library aNuMet (Array of Numerical Methods) for 
numerical calculations, implementing 40 math and matrix functions.  

Written in PureBasic 4.31 (x86) - (see www.purebasic.com).  

The zip file is provided with a complete sample script file with all the 
keywords and functions supported.

I've also included the syntax highlighter definition file "userDefineLang.xlm" 
to be copied (merged if existing) in the Application Data folder 
(es. C:\Documents and Settings\username\Application Data\Notepad++)

PLUGIN INSTALLATION:
--------------------
- Just explode the file in the plugin folder of Notepad++ 
(es. c:\program files\notepad++\plugin), preserving the subfolder name

PLUGIN UN-INSTALLATION:
-----------------------
- the program is a set of files. To uninstal, simply cancel them from the 
installation folder (don't forget the INI file)

PLUGIN USE:
-----------
1. Run Notepad++
2. You will have the menu Plugin > Math Evaluator showing 9 submenus

- Eval CurFile To File    => Evaluate the current file and send output to (CurrentFilePath)\Result.anm
                             A sample of output file is in the plugins\MathPad subfolder
- Eval CurLine To File    => Evaluate the current line and send output to the end of (CurrentFilePath)\Result.anm
--------------------------
- Eval CurLine To Wnd     => Evaluate the current line and send output to the next line of the current window
                             ShortCut: Ctrl+2
- Eval SelText To Wnd     => Evaluate the selected text and send output to the next line of the current window
                             ShortCut: Ctrl+3
- Eval Expression To Wnd  => Evaluate the previous expression and send output to the next line of the current window
                             The previous expression is from the cursor backwards to the first valid KeyWord
                             ShortCut: Ctrl + Shift + Enter
--------------------------
- Show Memory             => Show program memory content (variables, matrices and custom functions stored in memory)
                             ShortCut: Ctrl + Alt + M
- Insert Filename	  => Call then File Open Dialog Box to insert a File Name in the current carret position
                             ShortCut: Ctrl + Alt + O <ver. 0.0.4.6>
- Build Matrix	      => Call a Vector/Matrix form to build a matrix string to add in the current carret position
                         If a matrix string is selected, it is imported in the form <ver. 0.0.4.7>
                             ShortCut: Ctrl + Alt + B
- Options                 => Show 11 SubMenus
-         > Plugin Log          => Activate/Deactivate plugin log in file \plugins\MathPad\MathPad.dbg
-         > Show Error Messages => Show Error Messages recorded during expression evaluation (only on error).
                                   Recording is activated by the command: ErrorMsgs = 1
-         > Show Debug Log	=> Show Debug Log recorded during expression parsing and evaluation (every step)  
				   WARNING: The resulting string/file can be very big, depending on the number 
				   of consecutive commands evaluated.
----------------------------------
-         > Decimals            => Let you set the number of decimals used for the results
-         > Show Commands       => Show supported Commands and KeyWords (a sort of Help)
-         > Supported Functions => Show MathPad supported Operators and Functions
-         > Reset Memory        => Let you Reset plugin internal memory (variables, matrices and custom functions stored in memory)
-         > Eval to Toooltip    => Evaluate Selected Text (if any) or Line Showing result in a Tooltip
-         > Hide Expr line      => Don't repeat Expression line (command) in the output
-         > Don't confirm Expr  => Don't ask confirmation of the expression to evaluate
----------------------------------
-         > Acknowledgments     => List of people who supported/tested this plugin
----------------------------------
- About Math Evaluator    => Show About box

3. Load the file (Notepad++ Dir)\plugins\MathPad\Full_SyntSamp.anm
4. Read it carefully
5. Select a line or some text and click on the various menu items

In the (notepad++ dir)\plugins\MathPad folder are the files used in the Full_SyntSamp.anm file

******************************************************************************************
Pls report any bugs and/or comments to me. Fixes will be ...a.s.a.p.... :-}
If you are courious, visit the website: www.semelinanno.com for more info.  
******************************************************************************************
