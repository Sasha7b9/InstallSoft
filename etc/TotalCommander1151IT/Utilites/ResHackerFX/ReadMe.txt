Resource Hacker FXer v1.3.1
http://rammichael.com/
---------------------------

Remember the good ol' Resource Hacker?
It's a popular Resource viewer/editor, I use it to quickly view and edit resources. I tried to find an alternative, but I did not find any that I liked, so I decided to just improve Resource Hacker.

This is a patcher that needs to be used on the original Resource Hacker v3.6.0.92.

What does the patcher change:
1. A new interface with modern icons and a manifest.
Icons by Yusuke Kamiyamane: http://p.yusukekamiyamane.com/
2. Resource Hacker FX does not create tree nodes for every language. Usually only one language is used anyway, so it makes it much faster to navigate through resources.
3. Resource Hacker FX uses the new open and save common dialogs instead of the old outdated ones. Also, some saving as parameters got improved: the directory of the current file is initially shown, the file name gets filled, the extension is automatically added if not specified.
4. If you have a modified file open and you close Resource Hacker FX, you have a Cancel option when asked whether you would like to save the file. Also, if you choose to save it, it just gets saved instead of saving as.
5. The HEX viewer shows only the first 10 KB of the binary resource by default to prevent hanging Resource Hacker FX. I could not really fix it, as it's the Rich Edit control's fault, it's quite slow with large texts. Well, it's not too smart to use Rich Edit to view a HEX dump, but that's how it works. 10 KB should be usually enough to understand what the resource is about. If it isn't, you can hold shift to load the whole resource.
6. Some smaller stuff, like e.g. minimizing/maximizing effects, crash fixes.
