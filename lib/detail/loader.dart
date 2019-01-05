import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /* Player loader */
              Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                      width: screenWidth,
                      height: screenWidth * 9 / 16,
                      color: Colors.grey)),
              /* Content loader */
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                Row(children: <Widget>[
                  Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                          width: 12,
                          height: 12,
                          color: Colors.grey)),
                  Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 10.0),
                          width: 60,
                          height: 12,
                          color: Colors.grey))
                ]),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  height: screenWidth * .35,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey,
                            ),
                            margin: EdgeInsets.only(right: 20),
                            width: screenWidth * .35 * 16 / 9),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.grey,
                            ),
                            margin: EdgeInsets.only(right: 20),
                            width: screenWidth * .35 * 16 / 9),
                      ),
                    ],
                  ),
                ),
                Row(children: <Widget>[
                  Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                          width: 12,
                          height: 12,
                          color: Colors.grey)),
                  Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 10.0),
                          width: 60,
                          height: 12,
                          color: Colors.grey))
                ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              width: screenWidth * .75,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              width: screenWidth * .8,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              width: screenWidth * .2,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              width: screenWidth * .12,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              width: screenWidth * .65,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              width: screenWidth * .2,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 20.0),
                              width: screenWidth * .15,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              width: screenWidth * .16,
                              height: 12,
                              color: Colors.grey)),
                      Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 5.0),
                              width: screenWidth * .355,
                              height: 12,
                              color: Colors.grey)),
                    ])
              ])
            ]),
      ),
    );
  }
}
