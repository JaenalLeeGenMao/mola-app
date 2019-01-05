import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:video_player/video_player.dart';

import './api/api.dart';

import './models/video.dart';

import './header.dart';
import './content.dart';
import './loader.dart';

class Detail extends StatefulWidget {
  final String videoId;

  Detail(this.videoId);

  @override
  _DetailState createState() {
    return _DetailState();
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
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Loader()
            : Stack(children: <Widget>[
                Content(controller: _controller, video: _video),
                Header(_video.isDark)
              ]),
      ),
    );
  }
}
