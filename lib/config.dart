Map<String, dynamic> config() {
  // uncomment one of these two lines to switch between env
  final env = "STAGING";
  // final env = "PRODUCTION";

  final uploader = {
    "clientId": 'ef4723e0-b3b4-4ed9-a45f-fb1cd5a8f024',
    "clientSecret": '289cf0055454348a172d1520c8c70eb9',
    "ptoken": '3e0d9625b0ecc7a547ec853c76834d85',
  };
  final oauth = {
    "appKey": 'wIHGzJhset',
    "appSecret":
        'vyxtMDxcrPcdl8BSIrUUD9Nt9URxADDWCmrSpAOMVli7gBICm59iMCe7iyyiyO9x',
    "scope": [
      'https://internal.supersoccer.tv/users/users.profile.read',
      'https://internal.supersoccer.tv/subscriptions/users.read' /* DARI CODINGAN LAMA */,
      'https://internal.supersoccer.tv/subscriptions/users.read.global' /* DARI VINCENT */,
      'https://api.supersoccer.tv/subscriptions/subscriptions.read' /* DARI VINCENT */,
      'https://api.supersoccer.tv/videos/videos.read' /* DARI CODINGAN LAMA */,
    ].join(' '),
  };

  switch (env) {
    case 'PRODUCTION':
      return {
        "clientUrl": "",
        "serverUrl": "https://mola.tv",
        "api": "https://mola.tv/api/v2",
        "auth": "https://mola.tv/accounts/_",
        "accounts": "https://mola.tv/accounts",
        "domain": "https://mola.tv",
        "ads": "https://api-beta.sent.tv",
        "setting": {"timeout": 10000, "maxRedirects": 1},
        "uploader": "https://up.mola.tv",
        "appLink": "molatvapp://callback",
        "logoutappLink": "molatvapp://logout",
        "uploaderConfig": uploader,
        "oauthConfig": oauth
      };
    default:
      return {
        "clientUrl": "",
        "serverUrl": "https://stag.mola.tv",
        "api": "https://stag.mola.tv/api/v2",
        "auth": "https://stag.mola.tv/accounts/_",
        "accounts": "https://stag.mola.tv/accounts",
        "domain": "https://stag.mola.tv",
        "ads": "https://api.stag.supersoccer.tv",
        "setting": {"timeout": 10000, "maxRedirects": 1},
        "uploader": "https://up.stag.mola.tv",
        "appLink": "molatvapp://callback",
        "logoutappLink": "molatvapp://logout",
        "uploaderConfig": uploader,
        "oauthConfig": oauth
      };
  }
}
