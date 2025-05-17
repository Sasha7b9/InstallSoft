// В качестве команды указываем путь к скрипту 
// допускаетcя использование %commander_path% 
// Параметры кнопки: пароль_для_упаковки %S 
// Автор: LocKtaR-o-DarK
// Модификация от DimitarSerg (пароль, как передаваемый параметр) 21_марта_2012

//--------------------------------------------------------------
// Для AskParam строка параметров должна выглядеть примерно так:
// /c"Создание зашифрованного архива" /t"Введите пароль" /p"Добавить файлы в архив и защитить паролем:" %%commander_path%%\Utilites\WHS\packpass.js %%1 %S
//--------------------------------------------------------------

objFolder='' 
outDir=WScript.CreateObject('WScript.Shell').CurrentDirectory.replace(/\//gi,'\\')+'\\' 
objFolder=outDir.replace(/.*\\([^\\]*)\\/,'$1') 
if (objFolder==''){objFolder='Root'} 
strArg='' 
argPass='' 					
argPass=WScript.Arguments(0)			// Первый параметр (нулевой элемент массива параметров) - пароль
for (i=1;i<WScript.Arguments.length;i++){ 	// все остальные параметры - файлы для архиирования:)
strArg+=' "'+WScript.Arguments(i)+'"'} 
cmd='cmd /c title RaR-packing secure...&%commander_path%\\Plugins\\arc\\rar a -m5 -os -s -ep1 -ag_[yyyy.mm.dd-hh.mm] -hp'+argPass+' "'+objFolder+'.rar"'+strArg
WScript.CreateObject('WScript.Shell').Run(cmd,2)