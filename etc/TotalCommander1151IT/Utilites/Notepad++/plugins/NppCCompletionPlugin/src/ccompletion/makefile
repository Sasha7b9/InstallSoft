
.SUFFIXES: .cpp
CC = mingw32-g++.exe
#CC = g++.exe

OBJS = resfile.ro NppCCompletionPlugin.o

# the paths
TARGETDIR = C:/dev/npptmp/plugins
DLL = $(TARGETDIR)/NppCCompletionPlugin.dll
CFLAGS = -DBUILD_DLL
LDFLAGS = -mwindows
# -export-dynamic,-Wl,
#LDFLAGS = -Wl,--out-implib,libtstdll.a
#LDFLAGS = -mwindows -lcomctl32 -lshlwapi -llibshell32

ALL: $(DLL)



$(DLL):	$(OBJS)
	@$(CC) -shared -s -o $@ $(LDFLAGS) $(OBJS) -lshlwapi -static-libgcc
	del $(OBJS)


%.ro: %.rc %.h
	@windres $< -o $@

NppCCompletionPlugin.o : makefile PluginInterface.h Scintilla.h Notepad_plus_msgs.h NppCCompletionPlugin.cpp resfile.h
	@$(CC) -Wall -O3 -s -c $(CFLAGS) NppCCompletionPlugin.cpp -o $@

clean:
	del $(OBJS)
