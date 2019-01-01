import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget {
  bool isDark = false;

  Header(this.isDark);

  @override
  Widget build(BuildContext context) {
    return new Positioned(
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
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                mini: true,
                tooltip: "Search",
                elevation: 0.0,
                foregroundColor: isDark ? Colors.black : Colors.white,
                backgroundColor: Colors.transparent,
                child: Icon(
                  CupertinoIcons.search,
                  size: 36,
                ),
                onPressed: () {},
              ),
              SizedBox(
                width: 4.0,
              ),
              FloatingActionButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                mini: true,
                tooltip: "Profile",
                elevation: 0.0,
                foregroundColor: isDark ? Colors.black : Colors.white,
                backgroundColor: Colors.transparent,
                child: Icon(
                  CupertinoIcons.profile_circled,
                  size: 36,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
      left: 10.0,
      right: 10.0,
      top: 40.0,
    );
  }
}
