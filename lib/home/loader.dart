import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /* Header loader */
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Shimmer.fromColors(
                        period: Duration(milliseconds: 1750),
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.only(top: 40.0, left: 10.0),
                            child: SizedBox(
                              height: 44,
                              width: 165,
                              child: new Image.asset(
                                'assets/molatv.png',
                              ),
                            ))),
                  ]),
              /* Body loader */
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Shimmer.fromColors(
                    period: Duration(milliseconds: 1750),
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Shimmer.fromColors(
                            period: Duration(milliseconds: 1750),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: Colors.grey),
                                width: 12.0,
                                height: 12.0)),
                        Shimmer.fromColors(
                            period: Duration(milliseconds: 1750),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: Colors.grey),
                                width: 12.0,
                                height: 12.0)),
                        Shimmer.fromColors(
                            period: Duration(milliseconds: 1750),
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                                margin:
                                    EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: Colors.grey),
                                width: 12.0,
                                height: 12.0)),
                      ],
                    )),
                Shimmer.fromColors(
                    period: Duration(milliseconds: 1750),
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 128.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.grey),
                            width: 125,
                            height: 12),
                        Container(
                            margin: EdgeInsets.only(top: 6.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.grey),
                            width: 150,
                            height: 12),
                        Container(
                            margin: EdgeInsets.only(top: 6.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.grey),
                            width: 80,
                            height: 12),
                        Container(
                            margin: EdgeInsets.only(top: 6.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.grey),
                            width: 252,
                            height: 120)
                      ],
                    )),
                Shimmer.fromColors(
                    period: Duration(milliseconds: 1750),
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                        width: 48.0, height: 48.0, color: Colors.transparent))
              ]),
              /* Footer loader */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1750),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 10.0),
                      )),
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1750),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 150.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      )),
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1750),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      )),
                  Shimmer.fromColors(
                      period: Duration(milliseconds: 1750),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(bottom: 10.0),
                      ))
                ],
              )
            ]));
  }
}
