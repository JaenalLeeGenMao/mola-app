import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  final bool isDark;

  Header(this.isDark);

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Center(
                  child: SizedBox(
                    height: 44,
                    width: 165,
                    child: new Image.asset(
                      'assets/molatv.png',
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'BACK_BUTTON',
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  mini: true,
                  tooltip: "Back",
                  elevation: 0.0,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.back,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}