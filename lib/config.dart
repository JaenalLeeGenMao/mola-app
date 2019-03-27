Map<String, dynamic> config() {
  String env = 'STAGING';
  // String env = 'PRODUCTION';

  switch (env) {
    case 'PRODUCTION' : 
      return {
        "clientUrl": "",
        "serverUrl": "https://mola.tv",
        "api": "https://mola.tv/api/v2",
        "auth": "https://mola.tv/accounts/_",
        "domain": "https://mola.tv",
        "ads": "https://api-beta.sent.tv",
        "setting": {"timeout": 10000, "maxRedirects": 1},
        "uploader" : "https://up.mola.tv",
        "appLink": "molatvapp://callback",
        "logoutappLink" : "molatvapp://logout",
        "loginUrl" : "https://mola.tv/accounts/login"
      };
      break;
    default:
      return {
        "clientUrl": "",
        "serverUrl": "https://stag.mola.tv",
        "api": "https://stag.mola.tv/api/v2",
        "auth": "https://stag.mola.tv/accounts/_",
        "domain": "https://stag.mola.tv",
        "ads": "https://api.stag.supersoccer.tv",
        "setting": {"timeout": 10000, "maxRedirects": 1},
        "uploader" : "https://up.stag.mola.tv",
        "appLink": "molatvapp://callback",
        "logoutappLink" : "molatvapp://logout",
        "loginUrl" : "https://stag.mola.tv/accounts/login"
      };
  }
}
