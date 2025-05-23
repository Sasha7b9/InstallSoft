8.11
- New DebugLogDir ini setting

8.10
- Screenshot uses native Android instead of framebuffer

8.9
- Linux - Dialogs removed, ini file comments and examples
- Linux - Custom columns, owner and string attributes

8.8
- Native ls - --full-time support (with TZ)
- Native ls - append indicator removed (only used for busybox ls)

8.7
- STAT2 vs STAT fixed for older devices (download works again properly)
- Package listing works for packages with "=" in their names properly

8.6
- Support for screenshot/framebuffer v2 (new devices)

8.5
- Support for icons in file list again (Windows only)
- Support for ADB STAT2 command (int64 file sizes)
- Support for large file indication in progress bar and others

8.4
- Support for BusyboxLsCommand in init added (edit directly)
- PluginIni should be local codepage safe

8.3
- Android 8.3 ls support for escaped paths

8.2
- New: busybox - fulltime support
- Windows screenshots working again

Linux installation in DoubleCommander:
1. Install the adb.wfx plugin
2. Delete the adb.wfx file and rename adb_rename.wfx to adb.wfx
(The reason is a bug in the FPC compiler with shared libraries vs LCL forms)
If the plugin does not work check "ldd adb.wfx" and make sure all shared libraries can be found.
If not provide the ones from Ubuntu 16.04 x64

8.0
- Linux - Double Commander

7.6
- New: LS Params support

7.5
- New: Wearable uninstall support
- Update: .apk in the list fixed

7.4
- Update: ls error response handled properly

7.3
- Update: TWRP Recovery error status support added

7.2
- Fix: App uninstall fixed

7.1
- Update: pm option - deleting apk files (uninstall) from the .app folder is supported and also file properties
- ADB helper: start service on Samsung devices fixed
- APK properties - Added path to package

7.0
- Update: Screenshots - support for all modes RGBA, ARGB, ABGR, BGRA

6.9
- Update: logcat - uses the "time" format - logs include time information

6.8
- Update: pm option - copying apk files from the .app folder is supported (any storage is supported /data/app, /system/app, /mnt/asec etc.)

6.7
- New: Option Use Packages (pm) command - lets you control the way .app folder is listed. /data/app lists only packages installed in that folder plus size and date, pm command does not list size and time but lists all known apps (system, secured and data)

6.6
- Update: cp/mv calls check the result string for errors

6.5
- New: Option Preserve mode and owner of updated file

6.4
- New: Option for ls -a added, if used on older Android versions no file list will be returned (the parameter is missing on older versions)
- Update: ADBHelper stores temporary files in sdcard/tmp/ (new ADBHelper version)

6.3:
- New: Add shortcut to launcher for newly installed APK - new option and feature added
- Update: ADBHelper upgrade procedure - checks for version and installs new if required
- Update: ADBHelper - support for launcher shortcut icons added

6.2:
- Update: dmesg support via "su -c" if permissions problem

6.1:
- Update: ADB Helper - support for Android 4.2 added
- Update: Backup progress dialog proper parent handle supplied (dialog will be lost behind the TC window), Backup/Restore data counter updated in 128kB chunks

6.0:
- New: ADB Helper added (special app installed to Android device to provide clipboard and other features, first launch and installation might take a bit longer)
- New: Clipboard support (via ADB Helper)
- New: APK information provided via ADB Helper (APK does not need to be downloaded to PC to get the information and icon!)
- Update: Non busybox ls cannot use "ls -la" because older versions of Android do not support the param, we have to use "ls -l" which does not display hidden files - no way to work around this
- Update: ADB binaries updated

5.8:
- Update: App listing in special non-rooted case (pm command used)

5.7:
- Update: Shell path escaping added for all path operations, added escaping for "\$

5.6:
- Fix: Power menu - reboot to bootloader fixed

5.5:
- Update: Shell command also uses auto mount and "su -c" if commands fails (integration with TC command line)

5.4
- New: 2 new options added, Threshold to use the SDCard directly for large file transfers and retry failed transfers with busybox, mount and sdcard if transfer fails (file will be transfered 3 times...)
- Update: New way of timeout implemented for "mv" and "install", the timeout considers the file size being transferred and does not interrupt ongoing shell commands

5.3
- Fix: Transfer of files larger than 2GB fixed

5.2
- Fix: Multiple apks with dash handling updated
- Update: symlinks in root with failed busybox get displayed as directories

5.1
- Fix: Put file vs. date before 1980 problem fixed

5.0
- New: APK install error handling - a proper error is displayed explaining why app could not be installed
- Update: Some small tweaks

4.9
- New: SD Card detection mechanism added, detects SD card for each device ID and caches it, solves problem with using SD card as temp dir in some cases

4.8
- Fix: Put file uses 2nd mode param, fixes a problem with putting files containing "," in their names

4.7
- Update: Busybox ls uses the "-e" parameter to return full time. Parser update. Fixes an issue with TC Synchronize Dirs... (fully working now)

4.6
- Update: Plugin release vs. forms free vs. handle solved once for all
- Update: Find files enhanced - special mechanism added to detect if user browses folders or TC itself (determines if dialog should be opened or skipped (Backup, Shell, Power))

4.5
- New: Backup and Restore support (ICS only)

4.1
- Update: ReadData timeout param implemented, pm install (Install apps) extended timeout to 1 minute (large apks sometimes take long)

4.0
- New: Auto connect for WiFI ADB support, works well with bookmarks - you create a new bookmark and then simply open the folder, it will automatically attempt to connect to that device (without Connect To Device) if not already connected
- New: Bookmarks support added (for WiFI ADB only) - Use F7 to create a new device bookmark (name it and then specify the connect to device value), in order to remove the bookmark do not use F8 (it will delete all your files in the device), rename to "." instead - that will clear renamed devices and also remove bookmarks
- Fix: Clear renamed device (rename to ".") fixed, data is saved

3.5
- Update: Install/Uninstall - result properly checked - in case of error TC displays an error
- New: File Copy - Overwrite handling added - TC displays an Overwrite dialog automatically

3.4
- Update: Screenshot functions - supported 16bit, 24bit and 32bit depth

3.3
- New: Screenshot function uses internal functions and java is not used anymore (uses native ICS "screenshot" command or adb framebuffer:) (faster screenshots and file transfer progress)
- Update: Install and Uninstall in .apps folder does not use adb binary, push and pm command is used (allows you to see the file transfer progress)
- Update: In special cases native linux command used when "Permission denied" response detected

3.2
- Update: .apps folder with no apps but some files still displays the content
- Update: In special cases native linux command used when "Permission denied" response detected

3.1
- Update: Options dialog - Links clickable, added Official Web and Forum links
- Update: File time preserved for pulled and pushed files (Note: on some ROMs time cannot be set via ADB when file pushed and defaults to current time)

3.0
- Update: .reboot renamed to .power, Hot Reboot label used, Download and Bootloader actions added
- Fix: File List - new SIV_DelimTrim method introduced, does not trim spaces in the value of filename (fixes issues with filenames containing multiple spaces after each other)

2.9
- New: File listing - Symlinks get displayed in the Info column
- Update: FTP connection toolbar - logs not truncated anymore, full text length supported

2.8
- New: Reboot action contains a new popup menu with these options: Reboot, Hot Boot, Recovery, Download, Power Off (some of them require a rooted device)
- Update: Connect To Device causes a refresh of file listing

2.7
- Fix: Device name with spaces fixed, support for device name with spaces added for screenshots and others
- New: New Windows Job Objects option (turn off if you use your own adb in system PATH)

2.6
- New: .apps listing - if permissions denied to /data/app/ then "pm list packages" is used instead (works on emulator and non rooted phones - you can still uninstall and install apps)
- Update: Rename device - Checks device name collisions better
- Update: File listing - Filter still opens a blank folder

2.5
- New: Rename your device via F2 (you can name your device to a friendly name, to clear the name back rename to "_")
- New: Custom column Info, displays app (apk) Name and Version if columns and APK info enabled
- New: Custom columns Owner and Group, new option to disable custom columns, file item cache
- New: .dmesg special folder added, delete file in .dmesg directory clears the log ("dmesg -c")
- New: Job Objects used for executed applications so when TotalCommander stops all its executed childs (adb, aapt and java) will be stopped too (helps with plugin updates and others)
- New: Total Commander FTP connection toolbar support added - for executed commands in command line and for new option "Debug logging to FTP connection toolbar"
- Update: APK file properties dialog (Alt+Enter) displays also app permissions
- Update: Delete file in .logcat directory calls "logcat -c" to clear the log

2.2
- New: File transfer abort support added
- New: Symlink indicated by "SysFile" attribute - the only possible indication that TC handles (displayed as "!" icon overlay)
- New: File attributes - SUid/GUid/Sticky-Bit support added
- Update: Symlink - busybox ls uses the -p param to idenfity a dir or file, native ls assumes all symlinks are files except for root in such case it will directories (no other effective way to detect file or directory :( )
- Update: busybox vs. native ls format detection updated
- Fix: /dev/ file listing fixed

2.1
- New: .bugreport special folder added
- Update: Options - Debug tab jumps to end
- Update: .logcat folder (Copy file from .logcat folder)
- Update: File listing - file size not shown for non-file / items
- Update: Special folder files (screenshot, logcat, bugreport) have new filename template

2.0
- Update: .apps dir can always be entered
- New: File version information resource added

1.9.1
- Update: Options dialog contains a new OK button
- New: Options item in the root of the plugin

1.9
- Fixed dialog modality and parent window
- New: Background copy/move support added

1.8
- Fix: Move (F6) from or to device deletes file properly
- Fix: Date long in the past problem fixed
- Update: Pull file workaround for /system /data files when ADB Pull fails because of semi-rooted device and permission denied - file copied to sdcard and then copied automatically

1.7
- Binaries moved to bin dir, aapt added
- APK Icon and metadata support added, new fsplugin.ini variable to disable APK download and icon extraction
- APK properties (Alt+Enter) support added - displays the Name, Package and Version information
- Options dialog added (Alt+Enter at the plugin) - all options can be set here, readme.txt displayed and debug.log viewed

1.6
- Debug log support added - enable in fsplugin.ini
- LocalTZLS new ini variable added (fsplugin.ini) controls if ls returns time in local or UTC format
- ls - detection of ANSI escaping and removing for non busybox ls

1.5
- Set/Get file attributes/permissions - Change Attributes action in Total Commander
- adb binary - also added AdbWinUsbApi.dll
- ls syntax detection improved
- Auto mount working for semi-rooted devices
- Push file workaround to /system files when ADB Push fails because of semi-rooted device and permission denied (mount does not help here) - file copied to sdcard and then moved to /system automatically

1.4
- adb binary included (works only with the connect feature) - no need to install Android SDK
- "busybox ls" not used because utf8 is not supported (https://dev.openwrt.org/ticket/7993), ls syntax detection improved, new option to switch back to busybox ls in fsplugin.ini
- Execution operations full unicode
- An error is displayed if Java could not be run
- Copy/Move between 2 ADB devices support added

1.3
- Proper way to detect PluginDir
- x64 support
- TC command line integration

1.2
- Auto mount rw for rooted devices when required
- Better detection of the plugin dir used
- Settings stored in fsplugin.ini, support for ADBPath and JavaPath variables
- About window with name and version added

1.1
- Special device folders - Apps, Screenshot, Shell, LogCat, Reboot
- Full unicode support
- Remembers the last connected device IP:Port

1.0
- Initial release
