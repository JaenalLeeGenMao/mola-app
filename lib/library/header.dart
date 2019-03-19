import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  final bool isDark;

  Header(this.isDark);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 10.0),
      child: 
        new Stack(
          children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /* Back Button */
              FloatingActionButton(
                heroTag: 'BACK_BUTTON',
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                mini: true,
                tooltip: "Back",
                elevation: 0.0,
                foregroundColor: isDark ? Colors.black : Colors.white,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              /* Search Button and Profile Button */
              Row(
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'SEARCH_BUTTON',
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    mini: true,
                    tooltip: "Search",
                    elevation: 0.0,
                    foregroundColor:
                        isDark ? Colors.black : Colors.white,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.search,
                      size: 32,
                      color: Colors.white,
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
                    foregroundColor:
                        isDark ? Colors.black : Colors.white,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      CupertinoIcons.profile_circled,
                      size: 32,
                      color: Colors.white,
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
      )
    );
  }
}


