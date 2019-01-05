import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final int _isDark;

  Header(this._isDark);

  @override
  Widget build(BuildContext context) {
    var dark = _isDark == 1 ? true : false;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            width: screenWidth,
            height: 44,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                    heroTag: "BACK_BUTTON",
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    onPressed: () {
                      print("Back Clicked");
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: dark ? Colors.black : Colors.white,
                    )),
                FloatingActionButton(
                    heroTag: "COPY_BUTTON",
                    elevation: 0.0,
                    highlightElevation: 0.0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0))),
                    onPressed: () {
                      print("Back Clicked");
                    },
                    child: Icon(
                      Icons.blur_on,
                      size: 24,
                      color: dark ? Colors.black : Colors.white,
                    ))
              ],
            )));
  }
}
