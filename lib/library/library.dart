import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Library extends StatelessWidget {
  final String playlistId;

  Library(this.playlistId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Library Page $playlistId",
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
