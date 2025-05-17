3/20/07
This is Version 0.2 of Joel's Total Commander Hashsys Plugin.

I have upgraded the hash library to use mhash-0.9.8.1 from http://mhash.sourceforge.net.

Previously I couldn't get mhash to compile in Visual Studio, so the solution was as follows:
in Cygnus cygwin 1.5.22  I compiled mhash, and collected all of the .o objectsfiles into a 
library. Then massaging the hashsys source code and making a .h file that VC++ would accept, including the library from cygnus I compiled the beast and behold, here it is.

I was having some issues in having it read files, in that it would read only about 200 bytes and the stop.  It seems to be behaving now. 

At the moment the following 26 Hashes are supported:

CRC32 CRC32B ADLER32 MD2 MD4 MD5 SHA1 SHA224 SHA256 SHA384 SHA512
HAVAL128 HAVAL160  HAVAL192 HAVAL224 HAVAL256 RIPEMD128 RIPEMD160 RIPEMD256 RIPEMD320 
TIGER128 TIGER160 GOST WHIRLPOOL SNEFRU128 SNEFRU256

Future plans include:
HMAC hashes, with the key read off of a file, since I can't find a way to have a configuration dialog with a wdx plugin.

NTFS object IDs from files/directories.


Joel



-------------------------------------------------------------
3/16/07
This is Version 0.1 of Joel's Total Commander Hashsys Plugin.

It comes in a .wdx library that you can copy/install in your Total Commander plugin directory.
Once copied into the Total commander plugin directory, or some other directory of your choice, from the menu select Configuration->options, then Plugins, in the Content plugins (WDX), click configure, and add. Find the hashsys.wdx and click ok.

To show the hashes, right click on the Colums with "Name" "Ext" "Date", and select Configure Custom Columns. Click new, add column, and at the plus sign on the right side of the row from "Hashsys" select your hash.


It provides md2, md4, md5, sha1, sha224, sha256. rmd128, rmd160 and chc_hash.


Beware if viewing large files, the hash routine will take a LONG time and Total Commander will appaerntly stall for a while.  Wait it out.

The source is from Christian Ghisler's filesys content plugin, mixed with Tom's tomcryptlib version 1.16.

Included are the 7.5_filesys_1.0.zip which contains the boiler-plate template for making a Total commander content plugin, and a tomcrypt.lib from http://libtom.org/ that I had to massage to make it compile on my Visual Studio 5.  The tomcrypt.lib is missing the SHA512, SHA384, Whirlpool and Tiger hashes, since I couldn't get them to compile without error and didn't have the time to investigate.  Additional I didn't remove any of the encryption routines from the library, again for time constraints, so it is a bit bloated.  

I had tried to get GNU mhash to be the hashing library, but I was not able to it to compile on VC5. Everyone is welcome to expirement and let the best win.

I have developed and tested this plugin on a W2K system with Totalcommander 6.55 and it seems to work well.  Your mileage may vary.



Joel


TODO:
Add more hash algorithms, CRC32, TIGER, SHA384, SHA512....... (DONE!!)

Make it multi-threaded to alleviate wait time if hashing large files. Does Totalcommander allow asychronious update of fields.

