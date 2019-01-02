import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import './models/playlist.dart';

class Footer extends StatelessWidget {
  final SwiperController controller;
  final Map<String, dynamic> video;
  final Playlist playlist;

  Footer({this.controller, this.video, this.playlist});

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 10.0,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            // shape: RoundedRectangleBorder(),
            // mini: true,
            backgroundColor: Colors.transparent,
            child: Image.asset("assets/library.png", width: 40, height: 40),
            onPressed: () {
              print("first");
              print(playlist.id);
            },
          ),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.white,
            child: SizedBox(
              width: 140,
              height: 40,
              child: FlatButton(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/clip.png", width: 20, height: 20),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text("View Movie",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600))
                  ],
                ),
                onPressed: () {
                  print("second");
                  print(video["id"]);
                  print(video["background"]);
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
                  controller.previous();
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
                  controller.next();
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
