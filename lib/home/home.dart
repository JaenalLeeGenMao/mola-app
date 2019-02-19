import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import './api/api.dart';

import './header.dart';
import './footer.dart';
import './loader.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDark = true;
  bool _isLoading = true;
  bool _isError = false;

  List<dynamic> _playlists = [];
  List<dynamic> _videos = [];

  var _activePlaylist;
  var _activeVideo;

  final SwiperController _controller = new SwiperController();

  _init() async {
    var data = await getHomeDetails(); /* Fetch data */

    _playlists = data[0]; /* initialised playlists */
    _videos = data[1]; /* initialised videos */

    if (_playlists.length > 0 && _videos.length > 0) {
      _activePlaylist = _playlists[0]; /* set active playlist on init */
      _activeVideo = _videos[0][0]; /* set active video on init */

      _handleColorChange();
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  _handleColorChange({int row = 0, int column = 0}) {
    var currentPlaylist = _playlists[row];
    var currentVideo = _videos[row][column == null ? 0 : column];

    setState(() {
      _activePlaylist = currentPlaylist;
      _activeVideo = currentVideo;
      _isDark = currentVideo.isDark == 1;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: _isLoading
                ? Loader()
                : _isError
                    ? Center(
                        child: Text('Error'),
                      )
                    : Stack(children: <Widget>[
                        _PlaylistWidget(
                            handleColorChange: _handleColorChange,
                            controller: _controller,
                            playlists: _playlists,
                            videos: _videos),
                        Header(_isDark),
                        Footer(
                            controller: _controller,
                            video: _activeVideo,
                            playlist: _activePlaylist)
                      ])));
  }
}

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
      transformer: new ScaleAndFadeTransformer(fade: 1.0, scale: 1.15),
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return new Swiper(
      itemCount: videos.length,
      transformer: new PageTransformerBuilder(
          builder: (Widget child, TransformInfo info) {
        var isDummyImagePlaceholder = videos[info.index].background ==
            'https://cdn01.sent.tv/qaud0dwQwSQsDwdpPvTi_sent_757.png';
        var isQuoteExist = videos[info.index].quotes.length >
            0; /* important for validating if quotes exist */
        var title = videos[info.index].title;
        var author =
            isQuoteExist ? videos[info.index].quotes[0].author : 'Comming Soon';
        var quote = isQuoteExist ? videos[info.index].quotes[0].text : title;
        return new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /* default background */
            new Container(
              color: Colors.black87,
            ),
            /* Dummy placeholder */
            isDummyImagePlaceholder
                ? new Image.network(
                    videos[info.index].background,
                    fit: BoxFit.fill,
                  )
                : Container(),
            /* Title */
            new Positioned(
                child: new ParallaxContainer(
                  child: new Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 2.0),
                              blurRadius: 1.0,
                              color: Color.fromARGB(125, 9, 76, 126),
                            ),
                            Shadow(
                              offset: Offset(2.0, 1.0),
                              blurRadius: 6.0,
                              color: Color.fromARGB(0, 9, 76, 126),
                            ),
                          ])),
                  position: info.position,
                  translationFactor: 500.0,
                ),
                left: 20.0,
                right: 20.0,
                top: 100),
            /* Valid image */
            !isDummyImagePlaceholder
                ? new Image.network(
                    videos[info.index].background,
                    fit: BoxFit.fill,
                  )
                : Container(),
            /* gradient */
            new Positioned(
                bottom: 0.0,
                child: new Container(
                  width: screenWidth,
                  height: screenHeight * .5,
                  child: new DecoratedBox(
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        colors: [
                          const Color(0xFF000000),
                          const Color(0xF0000000),
                          const Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                )),
            /* Content details */
            new Positioned(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new ParallaxContainer(
                    child: new Center(
                      child: new Container(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * .2, 0.0, screenWidth * .2, 10.0),
                        child: new Text(
                          "“$quote”",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            wordSpacing: 2.0,
                            fontSize: 12.0,
                            color: Color(0x6FFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    position: info.position,
                    translationFactor: 400.0,
                  ),
                  new ParallaxContainer(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Text(
                        "— $author",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: new TextStyle(
                            color: Colors.white30,
                            fontSize: 12,
                            wordSpacing: 2.0,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    position: info.position,
                    translationFactor: 600.0,
                  ),
                  new ParallaxContainer(
                    child: new Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: new BoxDecoration(
                            gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                colors: [
                                  const Color(0x10FFFFFF),
                                  const Color(0x10FFFFFF)
                                ]),
                            borderRadius: new BorderRadius.circular(3.0)),
                        child: new Padding(
                          padding: EdgeInsets.fromLTRB(21, 12, 21, 12),
                          child: new Text(videos[info.index].description,
                              maxLines: 6,
                              style: new TextStyle(
                                fontSize: 14,
                                wordSpacing: 2.0,
                                color: Color(0xB8FFFFFF),
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w700,
                              )),
                        )),
                    position: info.position,
                    translationFactor: 200.0,
                  ),
                ],
              ),
              left: 25.0,
              right: 25.0,
              bottom: 60.0,
            ),
          ],
        );
      }),
      controller: controller,
      onIndexChanged: (int index) {
        handleColorChange(row: row, column: index);
      },
    );
  }
}
