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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _isLoading
            ? Loader()
            : Stack(
                children: <Widget>[
                  /* Video List */
                  Container(
                    margin: EdgeInsets.only(top: _visible ? 70 : 10),
                    child: _LibraryList(_videos, _controller),
                  ),
                  /* Genre List */
                  _isToggle ? 
                      Opacity(
                        opacity: 0.9,
                        child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.only(top: _visible ? 50 : 10),
                          child: 
                          _LibraryController(
                            select:_selected,
                            genres: _genres,
                            handleToggle: this.handleToggleGenre,
                          ),
                        ),
                      ) 
                      : Container(),
                  /* Genre Button */
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth * .245, 8.0, screenWidth * .245, 10.0),
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _isToggle?
                            Text(
                             'All Genres',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16.0,
                                  letterSpacing: 1.0,
                                  fontFamily: 'Open Sans Reguler'),
                            ):Text(
                              _selected,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  letterSpacing: 1.0,
                                  fontFamily: 'Open Sans Reguler'),
                            ),
                            _isToggle ? 
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 0.0,
                              color: Colors.black,
                            )
                            :
                            Icon(
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
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _visible ? 1.0 : 0.0,
                    child: 
                    _isToggle ? Opacity(
                      opacity: 0.0,
                      child: Header(true)
                    ) :
                     Header(true),
                  )
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
            child:
            select == genre.title? 
            Text(
              genre.title,
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Open Sans Bold',
                  fontSize: 19.0),
            )
            :Text(
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

  _LibraryList(this._videos, this._controller);

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
        : GridView.count(
            controller: _controller,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: _videos.map<Widget>((video) {
              var _isCover = video.imageUrl != '';
              return FlatButton(
                // color: Colors.red[600],
                child: _isCover
                    ? Image.network(video.imageUrl,height: 1200.0,width: 700.0, fit: BoxFit.fitHeight)   
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
