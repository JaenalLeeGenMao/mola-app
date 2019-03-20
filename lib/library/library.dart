import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './api/api.dart';
import '../detail/api/api.dart';

import './header.dart';
import './loader.dart';

import '../detail/detail.dart'; /* Detail page */

class Library extends StatefulWidget {
  final String playlistId;

  Library(this.playlistId);

  @override
  _LibraryState createState() {
    return _LibraryState();
  }
}

class _LibraryState extends State<Library> {
  var _genres;
  var _selected;
  var _videos;
  var _selectVideo;
  var _detailVideo;
  var _isToggle = false;
  var _isToggleVideo = false;
  var _isLoading = true;
  bool _visible = true;
  ScrollController _controller;

  _init() async {
    // print("hello library");
    // var data = await getLibrary(widget.playlistId); /* Fetch data */

    _genres = await getLibraryGenre();
    var libraryData = await getLibrary(widget.playlistId);

    setState(() {
      _isLoading = false;
      _selected = libraryData[0];
      _videos = libraryData[1];
    });
  }

  _scrollListener() {
    /* Scroll down */
    if (_controller.position.userScrollDirection.toString() ==
        'ScrollDirection.reverse') {
      if (_visible) {
        setState(() {
          _visible = false;
        });
      }
    } else if (!_visible) {
      setState(() {
        _visible = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    _init();

    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  handleVideo(id) async {
    if (id != null) {
      var data = id;
      var detailVideo = await getVideoDetail(id.id);
      print(id.id);
      if (detailVideo.quotes.length > 0) {
        setState(() {
          _isToggleVideo = true;
          _selectVideo = data;
          _detailVideo = detailVideo;
        });
      } else if (detailVideo.quotes.length <= 0) {
        setState(() {
          _isToggleVideo = true;
          _selectVideo = data;
          _detailVideo = null;
        });
      }
    } else {
      setState(() {
        _isToggleVideo = true;
        // _selectVideo =data[0];
      });
    }
  }

  handleVideoFalse() {
    setState(() {
      _isToggleVideo = false;
    });
  }

  handleToggleGenre(id) async {
    if (id != null) {
      var libraryData = await getLibrary(id);

      if (libraryData[1].length == 0) {
        var genreId = libraryData[0];
        for (var i = 0; i < _genres.length; i++) {
          if (genreId == _genres[i].id) {
            libraryData[0] = _genres[i].title;
          }
        }
      }

      setState(() {
        _isToggle = !_isToggle;
        _selected = libraryData[0];
        _videos = libraryData[1];
      });
    } else {
      setState(() {
        _isToggle = !_isToggle;
        _isToggleVideo = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isLoading
            ? Loader()
            : Stack(
                children: <Widget>[
                  /* Video List */
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        top: _visible ? 60 : 10, end: 10.0, start: 10.0),
                    child: _LibraryList(_videos, _controller,
                        screenWidth: screenWidth,
                        handelVideo: this.handleVideo),
                  ),

                  /* Genre List */
                  _isToggle
                      ? Opacity(
                          opacity: 0.9,
                          child: Container(
                            color: Colors.black,
                            padding: EdgeInsets.only(top: _visible ? 50 : 10),
                            child: _LibraryController(
                              select: _selected,
                              genres: _genres,
                              handleToggle: this.handleToggleGenre,
                            ),
                          ),
                        )
                      : Container(
                          child: Header(true),
                        ),
                  _isToggleVideo
                      ? new Opacity(
                          opacity: 0.9,
                          child: new Container(
                            margin: EdgeInsets.only(top: 55.0),
                            padding: EdgeInsetsDirectional.only(
                                start: 20.0, end: 20.0),
                            // padding: EdgeInsets.fromLTRB(screenWidth * .245, 0.0,
                            //     screenWidth * .245, 0.0),
                            // color: Colors.black,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border(
                                    top: BorderSide(color: Colors.blueAccent))),
                            child: PopUpDetailVideo(
                                video: _selectVideo,
                                detail: _detailVideo,
                                handleVideoFalse: this.handleVideoFalse),
                          ),
                        )
                      : Container(),
                  _isToggleVideo
                      ? Container (
                        padding:  EdgeInsets.fromLTRB(screenWidth * .425,
                                175.0, screenWidth * .245, 50.0),
                        // margin: EdgeInsets.all(40.0),
                        width: 20.0,
                        child: new FlatButton (
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                              size: 50.0,
                            ),
                            onPressed: () {
                              this.handleVideoFalse();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detail(_selectVideo.id)));
                            },
                          ),
                        ) 
                      : Container(),

                  /* Genre Button */
                  // AnimatedOpacity(
                  //   duration: const Duration(milliseconds: 500),
                  //   opacity: _visible ? 1.0 : 0.0,
                  //   child:
                  Container(
                    width: 200.0,
                    margin: EdgeInsets.only(left: 110.0),
                    // color: Colors.red,
                    // padding: EdgeInsets.fromLTRB(
                    //     screenWidth * .245, 8.0, screenWidth * .245, 10.0),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _isToggle
                              ? Text(
                                  'All Genres',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16.0,
                                      letterSpacing: 1.0,
                                      fontFamily: 'Open Sans Reguler'),
                                )
                              : Text(
                                  _selected,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 1.0,
                                      fontFamily: 'Open Sans Reguler'),
                                ),
                          _isToggle
                              ? Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 0.0,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 32.0,
                                  color: Colors.white,
                                )
                        ],
                      ),
                      onPressed: () {
                        this.handleToggleGenre(null);
                      },
                    ),
                  ),
                  // ),
                  // AnimatedOpacity(
                  //   duration: const Duration(milliseconds: 500),
                  //   opacity: _visible ? 1.0 : 0.0,
                  //   child: _isToggle
                  //       ? Opacity(opacity: 0.0, child: Header(true))
                  //       :

                  // )
                ],
              ),
      ),
    );
  }
}

class _LibraryController extends StatelessWidget {
  final genres;
  final select;
  final Function handleToggle;

  _LibraryController({this.select, this.genres, this.handleToggle});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final double itemHeight = screenHeight * 0.6;
    final double itemWidth = screenWidth / 0.1;
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 1,
      childAspectRatio: (itemWidth / itemHeight),
      // Generate 100 Widgets that display their index in the List
      children: genres.map<Widget>((genre) {
        return Center(
          child: FlatButton(
            child: select == genre.title
                ? Text(
                    genre.title,
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Open Sans Bold',
                        fontSize: 19.0),
                  )
                : Text(
                    genre.title,
                    style: TextStyle(
                        color: Colors.grey[400],
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Open Sans Reguler',
                        fontSize: 16.0),
                  ),
            onPressed: () {
              handleToggle(genre.id);
            },
          ),
        );
      }).toList(),
    );
  }
}

class _LibraryList extends StatelessWidget {
  final _videos;
  final _controller;
  final screenWidth;
  final Function handelVideo;
  _LibraryList(this._videos, this._controller,
      {this.screenWidth, this.handelVideo});

  @override
  Widget build(BuildContext context) {
    return _videos.length == 0
        ? Center(
            child: Text(
              'konten tidak tersedia',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
            ),
          )
        // : GridView.count(
        //     controller: _controller,
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 5.0,
        //     crossAxisSpacing: 5.0,
        //     childAspectRatio: 0.8,
        //     children: _videos.map<Widget>((video) {
        //       var _isCover = video.imageUrl != '';
        //       return FlatButton(
        //         color: Colors.red[600],
        //         child: _isCover
        //             ? Image.network(video.imageUrl, fit: BoxFit.fill, height: 180.0, width: 300.0,)
        //             : Container(
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(2.0),
        //                   color: Colors.blue,
        //                 ),
        //                 padding: EdgeInsets.all(10.0),
        //                 margin: EdgeInsets.all(10.0),
        //                 child: Center(
        //                   child: Text(
        //                     video.title,
        //                     style: TextStyle(color: Colors.white),
        //                   ),
        //                 ),
        //               ),
        //         onPressed: () {
        //           // Navigator.push(
        //           //     context,
        //           //     MaterialPageRoute(
        //           //         builder: (context) => Detail(video.id)));
        //           // showDialog(
        //           //     context: context,
        //           //     child:
        //           //     new Opacity(
        //           //       opacity: 0.9,
        //           //       child: new Container(
        //           //         margin: EdgeInsets.only(top: 55.0),
        //           //         padding: EdgeInsets.fromLTRB(screenWidth * .245, 0.0,
        //           //             screenWidth * .245, 10.0),
        //           //         color: Colors.black,
        //           //         child: new PopUpDetailVideo(video),
        //           //       ),
        //           //     ));
        //           handelVideo(video);
        //         },
        //       );
        //     }).toList(),
        //   );
        : GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.72,
            children: _videos.map<Widget>((video) {
              var _isCover = video.imageUrl != '';
              return Container(
                child: RawMaterialButton(
                  child: _isCover
                    ? Image.network(
                        video.imageUrl,
                        height: 400.0,
                        width: 500.0,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            video.title,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                onPressed: () {
                  handelVideo(video);
                },
              ));
            }).toList(),
          );
  }
}

class PopUpDetailVideo extends StatelessWidget {
  final video;
  final detail;
  final Function handleVideoFalse;

  PopUpDetailVideo({
    this.video,
    this.detail,
    this.handleVideoFalse,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final double itemHeight = screenHeight * 9.0;
    final double itemWidth = screenWidth / 0.1;
    var author = '';
    var quote = '';
    var description = '';
    if (detail != null) {
      author = detail.quotes[0].author;
      quote = detail.quotes[0].text;
      quote = quote.length > 144 ? quote.substring(0, 144) + "..." : quote;
      description = detail.description;
      description = description.length > 144
          ? description.substring(0, 144) + "..."
          : description;
    } else {
      author = '';
      quote = '';
      description = '';
    }

    // print(author);

    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 1,
      childAspectRatio: (itemWidth / itemHeight),

      // Generate 100 Widgets that display their index in the List
      children: <Widget>[
        Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.black,
                // padding: EdgeInsets.fromLTRB(screenWidth * .245, 50.0, screenWidth * .245, 0.0),
                padding: EdgeInsets.only(bottom: 10.0),
                child: Image.network(
                  video.imageUrl,
                  fit: BoxFit.cover,
                  height: 300.0,
                ),
                onPressed: () {
                  handleVideoFalse();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(video.id)));
                },
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                alignment: Alignment.center,
                child: Text("$description",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0)),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40.0),
                alignment: Alignment.center,
                child: detail != null
                    ? Text("“$quote” — $author",
                        textAlign: TextAlign.center,

                        // maxLines: 4,
                        style: new TextStyle(
                            fontSize: 14,
                            // wordSpacing: 2.0,
                            color: Color(0xB8FFFFFF),
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic))
                    : Text(''),
              ),
              FlatButton(
                child: Icon(
                  CupertinoIcons.clear_circled,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: () {
                  handleVideoFalse();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
