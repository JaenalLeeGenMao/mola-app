Map<String, dynamic> config() {
  return {
    "clientUrl": "",
    "serverUrl": "https://mola.tv",
    "api": "https://mola.tv/api/v2",
    "apiStaging" : "https://stag.mola.tv/api/v2",
    "auth": "https://mola.tv/accounts/_",
    "authStaging" : "https://stag.mola.tv/accounts/_",
    "domain": "https://mola.tv",
    "ads": "https://api-beta.sent.tv",
    "setting": {"timeout": 10000, "maxRedirects": 1},

    "appLink": "molatvapp://callback",
    "logoutappLink" : "molatvapp://logout",

    //staging mode
    // "staging" : "1", 

    //production mode
    "staging" : "0", 

    "uploader" : "https://up.mola.tv",
    "uploaderStaging" : "https://up.stag.mola.tv",

    "loginUrl" : "https://mola.tv/accounts/login"
  };
}
