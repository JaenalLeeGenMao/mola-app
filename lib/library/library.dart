import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './api/api.dart';

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
  var _isToggle = false;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: _isLoading
            ? Loader()
            : Stack(
                children: <Widget>[
                  /* Video List */
                  Container(
                    // color: Colors.white,
                    margin: EdgeInsets.only(top: _visible ? 120 : 10),
                    child: _LibraryList(_videos, _controller),
                  ),
                  /* Genre List */
                  _isToggle
                      ? Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(top: _visible ? 100 : 10),
                          child: _LibraryController(
                            genres: _genres,
                            handleToggle: this.handleToggleGenre,
                          ),
                        )
                      : Container(),
                  /* Genre Button */
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth * .245, 54.0, screenWidth * .245, 0.0),
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _selected,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  letterSpacing: 3.0),
                            ),
                            Icon(
                              _isToggle
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 32.0,
                              color: Colors.black,
                            )
                          ],
                        ),
                        onPressed: () {
                          this.handleToggleGenre(null);
                        },
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Header(true),
                  )
                ],
              ),
      ),
    );
  }
}

class _LibraryController extends StatelessWidget {
  final genres;
  final Function handleToggle;

  _LibraryController({this.genres, this.handleToggle});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final double itemHeight = screenHeight * .1;
    final double itemWidth = screenWidth / 2;
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      // Generate 100 Widgets that display their index in the List
      children: genres.map<Widget>((genre) {
        return Center(
          child: FlatButton(
            child: Text(
              genre.title,
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w400),
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

  _LibraryList(this._videos, this._controller);

  @override
  Widget build(BuildContext context) {
    return _videos.length == 0
        ? Center(
            child: Text(
              'konten tidak tersedia',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0),
            ),
          )
        : GridView.count(
            controller: _controller,
            crossAxisCount: 2,
            children: _videos.map<Widget>((video) {
              var _isCover = video.imageUrl != '';
              return FlatButton(
                child: _isCover
                    ? Image.network(video.imageUrl)
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.grey,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(video.id)));
                },
              );
            }).toList(),
          );
  }
}
