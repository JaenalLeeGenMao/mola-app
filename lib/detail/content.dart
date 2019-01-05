import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import './models/video.dart';

import './player.dart';

class Content extends StatelessWidget {
  final VideoPlayerController controller;
  final Video video;

  Content({this.controller, this.video});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: EdgeInsets.all(0.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              // A fixed-height child.
              color: Colors.black,
              height: screenWidth * 9 / 16,
              width: screenWidth,
              // child:
              child: new Player(controller: controller, video: video),
            ),
            Container(
              // Another fixed-height child.
              color: Colors.black,
              height: screenHeight * .8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Section(
                      title: Container(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Image.asset(
                                    "assets/info.png",
                                    width: 12,
                                    height: 12,
                                  )),
                              Text("INFO",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                            ],
                          )),
                      description: Text.rich(
                          TextSpan(text: video.fullDescription),
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12))),
                  Section(
                      title: Container(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text("Casts",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12))),
                      description: Text.rich(
                          TextSpan(
                              text:
                                  "Kurt Cobain, Dave Grohl, Krist Novoselic, Pat smear, Chad Channing"),
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12))),
                  Section(
                      title: Container(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text("Casts",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12))),
                      description: Text.rich(TextSpan(text: "AJ Schnack"),
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12))),
                  Section(
                      title: Container(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Text("Casts",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12))),
                      description: Text.rich(
                          TextSpan(text: "Jay Z, Felicia Cahyadi"),
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 12))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final Widget title;
  final Widget description;

  Section({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        width: screenWidth,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[title, description],
        ));
  }
}
