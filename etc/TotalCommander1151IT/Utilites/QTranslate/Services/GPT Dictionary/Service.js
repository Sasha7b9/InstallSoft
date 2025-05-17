function serviceHeader() {
    return new ServiceHeader(87, "GPT", "Artificial intelligence OpenAI as a professional dictionary." + Const.NL2 + "https://www.machinetranslation.com/" + Const.NL2 + "\u00a9 OpenAI", Capability.DICTIONARY)
}

function serviceHost(a, b, c) {
    return "https://aipe.bytequests.com"
}

SupportedLanguages = [-1, -1, "Afrikaans", "Azerbaijani", "Albanian", "Arabic", "Armenian", "Basque", "Belarusian", "Bulgarian", "Catalan", "Chinese (Simplified)", "Chinese (Traditional)", "Croatian", "Czech", "Danish", "Dutch", "English", "Estonian", "Finnish", "Filipino", "French", "Galician", "German", "Greek", "Haitian Creole", "Hebrew", "Hindi", "Hungarian", "Icelandic", "Indonesian", "Italian", "Irish", "Japanese", "Georgian", "Korean", "Latvian", "Lithuanian", "Macedonian", "Malay", "Maltese", "Norwegian", "Persian", "Polish", "Portuguese", "Romanian", "Russian", "Serbian", "Slovak", "Slovenian", "Spanish", "Swahili", "Swedish", "Thai", "Turkish", "Ukrainian", "Urdu", "Vietnamese", "Welsh", "Yiddish", "Esperanto", "Hmong", "Latin", "Lao", "Kazakh", "Uzbek", "Sinhala", "Tajik", "Telugu", "Khmer", "Mongolian", "Kannada", "Tamil", "Marathi", "Bengali", "Tatar"];

function serviceDictionaryRequest(a, b, c) {
	
       return new RequestData(
		HttpMethod.POST, 
		"", 

		stringifyJSON(
					{
						"q":"Ты переводной " +codeFromLanguage(c || ENGLISH_LANGUAGE) +"-Russian словарь. Словарная статья включает в себя: заглавное слово, транскрипцию, часть речи, перечисление основных значений, примеры употребления слова и переводы этих примеров, толкование и объяснение значений, фразеологизмы, наиболее близкие синонимы. Язык словарных статей русский. Найди в словаре: "+a,
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

function serviceDictionaryResponse(a, b, c, d) {
	ff = parseJSON(b);
	if (ff.response.choices[0].message.content){
		b = ff.response.choices[0].message.content;
		b = prepareSource(b);
		b = b.replace(/\n/g, "<br>");
	}

    return new ResponseData(b, c, d, a)
}

