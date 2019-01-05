import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:video_player/video_player.dart';

import './api/api.dart';

import './models/video.dart';

import './loader.dart';
import './player.dart';

class Detail extends StatefulWidget {
  final String videoId;

  Detail(this.videoId);

  @override
  _DetailState createState() {
    return _DetailState();
  }
}

class _Header extends StatelessWidget {
  final int _isDark;

  _Header(this._isDark);

  @override
  Widget build(BuildContext context) {
    var dark = _isDark == 1 ? true : false;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: FractionalOffset.topCenter,
            //         end: FractionalOffset.bottomCenter,
            //         colors: [
            //       const Color(0x00000000),
            //       const Color(0x0F000000)
            //     ])),
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

class _DetailState extends State<Detail> {
  Video _video;
  VideoPlayerController _controller;
  var _isLoading = true;

  _init() async {
    var result = await getVideoDetail(widget.videoId);
    if (result != null) {
      setState(() {
        _controller = new VideoPlayerController.network(result.streamSourceUrl);
        _video = result;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Loader()
            : Stack(children: <Widget>[
                SingleChildScrollView(
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
                          child: new Player(
                              controller: _controller, video: _video),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6.0),
                                              child: Image.asset(
                                                "assets/info.png",
                                                width: 12,
                                                height: 12,
                                              )),
                                          Text("INFO",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12))
                                        ],
                                      )),
                                  description: Text.rich(
                                      TextSpan(text: _video.fullDescription),
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 12))),
                              Section(
                                  title: Container(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Casts",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12))),
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
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12))),
                                  description: Text.rich(
                                      TextSpan(text: "AJ Schnack"),
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 12))),
                              Section(
                                  title: Container(
                                      padding: EdgeInsets.only(bottom: 6.0),
                                      child: Text("Casts",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12))),
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
                ),
                _Header(_video.isDark)
              ]),
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
