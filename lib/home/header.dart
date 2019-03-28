import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:url_launcher/url_launcher.dart';

import '../config.dart';

final Map<String, dynamic> data = config();

class Header extends StatelessWidget {
  final bool isDark;
  var accessToken;
  final String loginUrl = '${data['accounts']}/login';
  final String appLink = data['appLink'];

  Header(this.isDark, this.accessToken);

  void _launchURL() async {
    var url = '$loginUrl?redirectUri=$appLink';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      child: new SafeArea(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 44,
              width: 165,
              child: new Image.asset(
                'assets/molatv.png',
              ),
            ),
            Row(
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'SEARCH_BUTTON',
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  mini: true,
                  tooltip: "Search",
                  elevation: 0.0,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.search,
                    size: 32,
                  ),
                  onPressed: () {
                    print("search something...");
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                FloatingActionButton(
                    heroTag: 'PROFILE_BUTTON',
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    mini: true,
                    tooltip: "Profile",
                    elevation: 0.0,
                    foregroundColor: isDark ? Colors.black : Colors.white,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      CupertinoIcons.profile_circled,
                      size: 32,
                    ),
                    onPressed: () {
                      print("profile looking good :3");
                      print("$accessToken");
                      /* Harusnya ada sesuatu untuk refresh token tapi nanti da */
                      accessToken == null
                          ? _launchURL()
                          : Navigator.pushNamed(context, '/profile');
                    }),
              ],
            )
          ],
        ),
      ),
      left: 10.0,
      right: 10.0,
      top: 10.0,
    );
  }
}
