import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import './api.dart';

import './header.dart';
import './footer.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDark = true;
  List<dynamic> _playlists = [];
  List<dynamic> _videos = [];

  final SwiperController _controller = new SwiperController();

  _init() async {
    var data = await getHomeDetails();

    _playlists = data[0];
    _videos = data[1];

    _handleColorChange();
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  _handleColorChange({int row = 0, int column = 0}) {
    var result = _videos[row][column];
    print("$row, $column");
    print(_videos[2]);
    setState(() {
      _isDark = result["isDark"] == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _PlaylistWidget(
            handleColorChange: _handleColorChange,
            controller: _controller,
            videos: _videos,
            playlists: _playlists),
        Header(_isDark),
        Footer(_controller)
      ]),
    );
  }
}

List<String> images = ["", "", ""];

List<String> text0 = [
  "Merry Chrismast。Jaenal",
  "春无踪迹谁知。除非问取黄鹂",
  "山色江声相与清，卷帘待得月华生"
];
List<String> text1 = ["若有人知春去处。唤取归来同住", "百啭无人能解，因风飞过蔷薇", "可怜一曲并船笛，说尽故人离别情。"];

class _PlaylistWidget extends StatelessWidget {
  final Function handleColorChange;
  final controller;
  final playlists;
  final videos;

  _PlaylistWidget(
      {this.handleColorChange, this.controller, this.videos, this.playlists});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      loop: true,
      onIndexChanged: (int index) {
        handleColorChange(row: index);
      },
      itemBuilder: (BuildContext context, int index) {
        return _PlaylistSwiperWidget(
            videos: videos[index],
            handleColorChange: handleColorChange,
            row: index,
            controller: controller);
      },
      pagination: SwiperPagination(
          alignment: Alignment.centerLeft,
          margin: new EdgeInsets.all(5.0),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white30,
              activeColor: Colors.white,
              size: 11.0,
              activeSize: 11.0,
              space: 5.0)),
      scrollDirection: Axis.vertical,
      itemCount: playlists.length,
    );
  }
}

class _PlaylistSwiperWidget extends StatelessWidget {
  final Function handleColorChange;
  final SwiperController controller;
  final int row;
  final List<dynamic> videos;

  _PlaylistSwiperWidget(
      {this.handleColorChange, this.row, this.controller, this.videos});

  @override
  Widget build(BuildContext context) {
    return Material(
        // elevation: 4.0,
        textStyle: new TextStyle(color: Colors.white),
        // borderRadius: new BorderRadius.circular(10.0),
        child: new Swiper(
          itemCount: videos.length,
          transformer: new PageTransformerBuilder(
              builder: (Widget child, TransformInfo info) {
            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Image.network(
                  videos[info.index.toInt()]["background"],
                  fit: BoxFit.fill,
                ),
                new DecoratedBox(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: [
                        const Color(0xFF000000),
                        const Color(0xA7000000),
                        const Color(0x00000000),
                        const Color(0x00000000),
                        const Color(0x00000000),
                      ],
                    ),
                  ),
                ),
                // new Positioned(
                //   child: new Column(
                //     mainAxisSize: MainAxisSize.min,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       new ParallaxContainer(
                //         child: new Text(
                //           text0[info.index],
                //           style: new TextStyle(fontSize: 15.0),
                //         ),
                //         position: info.position,
                //         translationFactor: 300.0,
                //       ),
                //       new SizedBox(
                //         height: 8.0,
                //       ),
                //       new ParallaxContainer(
                //         child: new Text(text1[info.index],
                //             style: new TextStyle(fontSize: 18.0)),
                //         position: info.position,
                //         translationFactor: 200.0,
                //       ),
                //     ],
                //   ),
                //   left: 10.0,
                //   right: 10.0,
                //   bottom: 10.0,
                // ),
              ],
            );
          }),
          controller: controller,
          onIndexChanged: (int index) {
            handleColorChange(row: row, column: index);
          },
        ));
  }
}
