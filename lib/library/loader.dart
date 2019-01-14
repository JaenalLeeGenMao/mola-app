import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 24.0),
              child: SizedBox(
                height: 44,
                width: 165,
                child: new Image.asset(
                  'assets/molatv.png',
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child: Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 24.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Colors.grey),
                width: screenWidth * .25,
                height: 12.0),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(1000, (index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  margin: index % 7 != 0
                      ? EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0)
                      : EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 40.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.grey),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
