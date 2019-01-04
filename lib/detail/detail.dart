import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

import './api/api.dart';

import './models/video.dart';

class Detail extends StatelessWidget {
  final String videoId;

  Detail(this.videoId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: <Widget>[_Content(videoId), _Header()],
    )));
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: FractionalOffset.topCenter,
            //         end: FractionalOffset.bottomCenter,
            //         colors: [
            //       const Color(0xFF000000),
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
                    ))
              ],
            )));
  }
}

class _Content extends StatefulWidget {
  final String videoId;

  _Content(this.videoId);

  @override
  _ContentState createState() {
    return _ContentState();
  }
}

class _ContentState extends State<_Content> {
  Video _video;
  // VideoPlayerController _controller;
  var _isLoading = true;

  _init() async {
    var result = await getVideoDetail(widget.videoId);
    if (result != null) {
      setState(() {
        // _controller = new VideoPlayerController.network(result.streamSourceUrl);
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
    return SafeArea(
        child: Scaffold(
            body: _isLoading
                ? Text("Loading...")
                : SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              // A fixed-height child.
                              color: Colors.black,
                              height: screenWidth * 9 / 16,
                              width: screenWidth,
                              child: Image.network(
                                _video.background,
                                width: screenWidth,
                                height: screenWidth * 9 / 16,
                              )
                              // new Chewie(
                              //   _controller,
                              //   aspectRatio: 3 / 2,
                              //   autoPlay: true,
                              //   looping: true,

                              // Try playing around with some of these other options:

                              // showControls: false,
                              // materialProgressColors: new ChewieProgressColors(
                              //   playedColor: Colors.red,
                              //   handleColor: Colors.blue,
                              //   backgroundColor: Colors.grey,
                              //   bufferedColor: Colors.lightGreen,
                              // ),
                              // placeholder: new Container(
                              //   color: Colors.grey,
                              // ),
                              // autoInitialize: true,
                              // ),
                              ),
                          Container(
                            // Another fixed-height child.
                            color: Colors.black,
                            height: screenHeight * .8,
                          )
                        ],
                      ),
                    ),
                  )));
  }
}
