import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
              const Color(0xFF000000),
              const Color(0xA7000000),
              const Color(0x00000000)
            ])),
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[_Content()],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  _contentButton(BuildContext context, String text, Function onPress) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: onPress,
      child: Container(
          margin: EdgeInsets.only(bottom: 2.0),
          color: Color(0x0F000000),
          height: MediaQuery.of(context).size.height * .125,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(letterSpacing: 8.0),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _contentButton(context, "Login", () {
          print("Try logging");
        }),
        _contentButton(context, "Account", () {
          print("Account clicked");
        }),
        _contentButton(context, "History", () {
          print("History clicked");
        }),
        _contentButton(context, "Inbox", () {
          print("Inbox clicked");
        }),
        _contentButton(context, "Close", () {
          Navigator.pop(context);
        })
      ],
    );
  }
}
