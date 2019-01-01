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
  bool isDark = true;
  final SwiperController controller = new SwiperController();

  @override
  void initState() {
    print(apiCall());
    handleColorChange();
    super.initState();
  }

  handleColorChange({int row = 0, int column = 0}) {
    var current = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ];
    var result = current[row][column];
    // print("$result [$row][$column]");
    // print(result % 2 == 0);
    setState(() {
      isDark = result % 2 == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _PlaylistWidget(handleColorChange, controller),
        Header(isDark),
        Footer(controller)
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
  final Function _handleColorChange;
  final _controller;

  _PlaylistWidget(this._handleColorChange, this._controller);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      loop: true,
      onIndexChanged: (int index) {
        _handleColorChange(row: index);
      },
      itemBuilder: (BuildContext context, int index) {
        return _PlaylistSwiperWidget(
            handleColorChange: _handleColorChange,
            row: index,
            controller: _controller);
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
      itemCount: 3,
    );
  }
}

class _PlaylistSwiperWidget extends StatelessWidget {
  final Function handleColorChange;
  final int row;
  final SwiperController controller;

  _PlaylistSwiperWidget({this.handleColorChange, this.row, this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
        // elevation: 4.0,
        textStyle: new TextStyle(color: Colors.white),
        // borderRadius: new BorderRadius.circular(10.0),
        child: new Swiper(
          itemCount: 3,
          transformer: new PageTransformerBuilder(
              builder: (Widget child, TransformInfo info) {
            return new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // new ParallaxImage.asset(
                //   images[info.index],
                //   position: info.position,
                // ),
                new DecoratedBox(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      colors: [
                        const Color(0xFF000000),
                        // const Color(0xFF0F4A73),
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
