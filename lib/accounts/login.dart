import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import './api/auth.dart';

import './header.dart';

final auth = new Auth();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences prefs;

  var email = '';
  var password = '';
  var error = '';

  _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _launchURL(url) async {
    print(url);
    if (await canLaunch('$url')) {
      await launch('$url', forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  handleInputChange(id, value) {
    switch (id) {
      case 'email':
        this.setState(() {
          email = value;
        });
        break;
      case 'password':
        this.setState(() {
          password = value;
        });
        break;
      default:
        break;
    }
  }

  handleSubmit() async {
    var request = await auth.requestLogin(email: email, password: password);

    switch (request["statusCode"]) {
      case 400:
        this.setState(() {
          error = request["error"];
        });
        break;
      case 200:
        prefs.setStringList('SID', [request["SID"], request["Expires"]]);
        var response = await auth.requestCode(request["SID"]);
        print(response);
        // _launchURL(oAuthAuthorizationEndpoint);a
        break;
      default:
        String errMsg = 'TIMEOUT: Internal Server Error';
        this.setState(() {
          error = errMsg;
        });
        return errMsg;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 25.0, left: 10.0, right: 10.0),
              child: Header(false, null),
            ),
            Center(
              child: Container(
                height: screenHeight * .6,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      const Color(0xFF181818),
                      const Color(0xFF222222),
                      const Color(0xFF333333),
                    ],
                  ),
                ),
                padding: EdgeInsets.all(20.0),
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomTextField(
                      id: 'email',
                      placeholder: "Email",
                      onChange: handleInputChange,
                    ),
                    CustomTextField(
                      id: 'password',
                      type: 'password',
                      placeholder: "Password",
                      onChange: handleInputChange,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.centerRight,
                      width: screenWidth * .8,
                      height: screenWidth * .12,
                      child: FlatButton(
                        padding: EdgeInsets.only(right: 4.0),
                        color: const Color(0x00000000),
                        child: Text(
                          "Lupa Password?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        ),
                        onPressed: () => handleSubmit(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      width: screenWidth * .8,
                      height: screenWidth * .12,
                      child: FlatButton(
                        color: const Color(0xFF2C56FF),
                        child: Text(
                          "MASUK",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0),
                        ),
                        onPressed: () => handleSubmit(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.centerLeft,
                      width: screenWidth * .8,
                      height: screenWidth * .12,
                      child: FlatButton(
                        padding: EdgeInsets.only(left: 4.0),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "User baru ? ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                            Text(
                              "Register sekarang",
                              style: TextStyle(
                                  color: const Color(0xFF2C56AA),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0),
                            ),
                          ],
                        ),
                        onPressed: () => handleSubmit(),
                      ),
                    ),
                    Text(
                      error,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  var id = '';
  var placeholder = '';
  var type = 'text';
  Function onChange =
      (value) => value; /* ini defaultnya kalo ga ada yg passing */

  CustomTextField({this.id, this.type, this.placeholder, this.onChange});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: Colors.white),
      width: screenWidth * .8,
      child: TextField(
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.grey[900]),
        onChanged: (String value) {
          onChange(id, value);
        },
        obscureText: type == 'password' ? true : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20.0, bottom: 14.0, top: 15.0),
          hintText: placeholder,
          hintStyle: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 15.0),
        ),
      ),
    );
  }
}
