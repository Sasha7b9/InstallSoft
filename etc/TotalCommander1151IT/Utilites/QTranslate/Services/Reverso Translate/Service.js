function serviceHeader() {
    return new ServiceHeader(99, "Reverso", "Free online translation in French, Spanish, Italian, German, Russian, Portuguese, Hebrew, Japanese, English." + Const.NL2 + "https://www.reverso.net" + Const.NL2 + "\u00a9 2021 Reverso-Softissimo", Capability.TRANSLATE)
}

function serviceHost(a, b, c) {
    return "https://api.reverso.net"
}
//function serviceLink(a, b, c) {
//	return "https://api.reverso.net"
//}
SupportedLanguages = [-1, -1, -1, -1, -1, "ara", -1, -1, -1, -1, -1, "chi", "chi", -1, -1, -1, "dut", "eng", -1, -1, -1, "fra", -1, "ger", -1, -1, "heb", -1, -1, -1, -1, "ita", -1, "jpn", -1, -1, -1, -1, -1, -1, -1, -1, -1, "pol", "por", "rum", "rus", -1, -1, -1, "spa", -1, -1, -1, "tur", -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];

function serviceTranslateRequest(a, b, c) {
    return new RequestData(HttpMethod.POST, "/translate/v1/translation", stringifyJSON({
        from: codeFromLanguage(b),
        to: codeFromLanguage(c),
        input: a,
        format: "text",
        options: {
            origin: "contextweb",
            languageDetection: true
        }
    }), postHeader(true))
}

function serviceTranslateResponse(a, b, c, d) {
    (b = parseJSON(b)) && b.translation && (b = b.translation);
    return new ResponseData(b, c, d)
};