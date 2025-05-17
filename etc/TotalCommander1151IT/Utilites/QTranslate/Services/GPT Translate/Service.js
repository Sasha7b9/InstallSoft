function serviceHeader() {
    return new ServiceHeader(88, "ChatGPT", "Artificial intelligence OpenAI as a professional translator." + Const.NL2 + "https://www.machinetranslation.com/" + Const.NL2 + "\u00a9 OpenAI", Capability.TRANSLATE)
}

function serviceHost(a, b, c) {
    return "https://aipe.bytequests.com"
}

SupportedLanguages = [-1, -1, "af","az","sq","ar","hy","eu","be","bg","ca","zh-CN","zh-TW","hr","cs","da","nl","en","et","fi","tl","fr","gl","de","el","ht","iw","hi","hu","is","id","it","ga","ja","ka","ko","lv","lt","mk","ms","mt","no","fa","pl","pt","ro","ru","sr","sk","sl","es","sw","sv","th","tr","uk","ur","vi","cy","yi","eo","hmn","la","lo","kk","uz","si","tg","te","km","mn","kn","ta","mr","bn","tt"];

function serviceTranslateRequest(a, b, c) {
	
   return new RequestData(
		HttpMethod.POST, 
		"", 
		stringifyJSON(
			{
				"q":"Translate from "+codeFromLanguage(b || AUTO_DETECT_LANGUAGE) +" to "+ codeFromLanguage(c || ENGLISH_LANGUAGE)+" while preserving the formatting of the text:"+Const.NL+ a,
				"type":"text_translation"
			}
		), postHeader("application/json")+Const.NL+
		"cache-control: no-cache"+Const.NL+
		"pragma: no-cache"+Const.NL+
		"sec-ch-ua: \"Not/A)Brand\";v=\"99\", \"Google Chrome\";v=\"115\", \"Chromium\";v=\"115\""+Const.NL+
		"sec-ch-ua-mobile: ?0"+Const.NL+
		"sec-ch-ua-platform: \"Windows\""+Const.NL+
		"sec-fetch-dest: empty"+Const.NL+
		"sec-fetch-mode: cors"+Const.NL+
		"sec-fetch-site: cross-site"+Const.NL+
		"Referer: https://www.machinetranslation.com/"+Const.NL+
		"Referrer-Policy: strict-origin-when-cross-origin"
		)
}

function serviceTranslateResponse(a, b, c, d) {
	ff = parseJSON(b);
	if (ff.response.choices[0].message.content){
		b = ff.response.choices[0].message.content;
		b = b.replace(/^\n+/gm, "");
	}
    return new ResponseData(b, c, d)
};