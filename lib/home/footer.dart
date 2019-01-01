import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class Footer extends StatelessWidget {
  final SwiperController _controller;

  Footer(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            // shape: RoundedRectangleBorder(),
            // mini: true,
            backgroundColor: Colors.transparent,
            child: Icon(
              CupertinoIcons.home,
              size: 44,
              color: Colors.white,
            ),
            onPressed: () {
              print("First");
            },
          ),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.white,
            child: SizedBox(
              width: 140,
              height: 44,
              child: FlatButton(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.video_camera,
                      size: 24,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text("View Movie",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600))
                  ],
                ),
                onPressed: () {
                  print("Second");
                },
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: CircleBorder(side: BorderSide(color: Colors.white)),
                backgroundColor: Colors.transparent,
                child: Icon(Icons.chevron_left, size: 24, color: Colors.white),
                onPressed: () {
                  print("Third");
                  _controller.previous();
                },
              ),
              SizedBox(
                width: 8,
              ),
              FloatingActionButton(
                mini: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: CircleBorder(side: BorderSide(color: Colors.white)),
                backgroundColor: Colors.transparent,
                child: Icon(Icons.chevron_right, size: 24, color: Colors.white),
                onPressed: () {
                  print("Forth");
                  _controller.next();
                },
              ),
              SizedBox(
                width: 8,
              ),
            ],
          )
        ],
      ),
    );
  }
}
