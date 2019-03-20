import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../flutter_swiper-1.1.4/lib/flutter_swiper.dart';

import './models/playlist.dart';
import './models/video.dart';

import '../library/library.dart';
// import '../detail/detail.dart';

class Footer extends StatelessWidget {
  final SwiperController controller;
  final Video video;
  final Playlist playlist;

  Footer({this.controller, this.video, this.playlist});

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: 20.0,
      right: 0.0,
      bottom: 10.0,
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CupertinoButton(
            pressedOpacity: .7,
            child: Image.asset("assets/library.png", width: 32, height: 32),
            onPressed: () {
              print("first");
              print(playlist.id);
              var playlistId = playlist.id.replaceAll(new RegExp(r'f-'), '');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Library(playlistId)));
            },
          ),
          Text(
            "Terbaik dari film ${playlist.title}",
            style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
          )
          // Material(
          //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
          //   color: Colors.white,
          //   child: SizedBox(
          //     width: 128,
          //     height: 32,
          //     child: FlatButton(
          //       child: Row(
          //         // mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          //           Image.asset("assets/clip.png", width: 18, height: 18),
          //           SizedBox(
          //             width: 8.0,
          //           ),
          //           Text("Watch Movie",
          //               style: TextStyle(
          //                   fontSize: 12,
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.w600))
          //         ],
          //       ),
          //       onPressed: () {
          //         print("second");
          //         if (video.id != null) {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => Detail(video.id)));
          //         }
          //         print(video.id);
          //         print(video.background);
          //       },
          //     ),
          //   ),
          // ),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     CupertinoButton(
          //       minSize: 32,
          //       padding: EdgeInsets.all(0.0),
          //       child: Container(
          //         width: 32,
          //         height: 32,
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.white, width: 1.0),
          //           borderRadius: BorderRadius.circular(16),
          //         ),
          //         child:
          //             Icon(Icons.chevron_left, size: 18, color: Colors.white),
          //       ),
          //       onPressed: () {
          //         print("Third");
          //         controller.previous();
          //       },
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     CupertinoButton(
          //       minSize: 32,
          //       padding: EdgeInsets.all(0.0),
          //       child: Container(
          //         width: 32,
          //         height: 32,
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.white, width: 1.0),
          //           borderRadius: BorderRadius.circular(16),
          //         ),
          //         child:
          //             Icon(Icons.chevron_right, size: 18, color: Colors.white),
          //       ),
          //       onPressed: () {
          //         print("Forth");
          //         controller.next();
          //       },
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
