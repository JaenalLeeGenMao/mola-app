import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../detail/models/video.dart';

class Player extends StatefulWidget {
  final Video video;
  final VideoPlayerController controller;

  Player({this.video, this.controller});

  @override
  TheoPlayerState createState(){
    return TheoPlayerState();
  }
}
class TheoPlayerState extends State<Player> {
  
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return new Chewie(
      widget.controller,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: true,

      // Try playing around with some of these other options:

      // showControls: false,
      materialProgressColors: new ChewieProgressColors(
        playedColor: Color.fromRGBO(15, 74, 115, 1.0),
        handleColor: Color.fromRGBO(15, 74, 115, 1.0),
        backgroundColor: Color.fromRGBO(155, 155, 155, .8),
        bufferedColor: Color.fromRGBO(255, 255, 255, .8),
      ),
      placeholder: new Container(
          color: Colors.black87,
          child: Image.network(
            widget.video.background,
            width: screenWidth,
            height: screenWidth * 9 / 16,
          )),
      autoInitialize: true,
    );
  }
}
