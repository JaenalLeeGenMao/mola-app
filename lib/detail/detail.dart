import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Detail extends StatelessWidget {
  final String videoId;

  Detail(this.videoId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text("Detail Page $videoId", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
