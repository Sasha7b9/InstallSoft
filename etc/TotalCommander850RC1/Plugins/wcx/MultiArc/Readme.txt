Mulitarc 1.4.7.0 MVV Build #4
-----------------------------

1. Added format character '+' allowing to stretch format pattern until first space (or stretch space until first non-space).
2. Special '++' sequence after last format pattern stretches pattern until end of line (e.g. for file path).

Example of new 7-Zip format line:
Format0="yyyy-tt-dd hh:mm:ss aaaaa +z+ +p+ +n++"
("z+" reads unpacked size until first space; " +" skips all spaces until first non-space character; "n++" reads name until end of line)

3. Added function ReadHeaderEx, supports 64-bit file sizes.

4. Fixed buffer overflow bug when format string is longer than archiver output line.