import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import './routes.dart';

void main() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  /// This widget is the root of your application.
  Color _statusBarColor = Color.fromRGBO(8, 44, 66, 1.0);
  double _statusBarOpacity = 1.0;
  bool _statusBarColorAnimated = false;
  var _accessToken;
  StreamSubscription _sub;
  Timer _timerLink;

  _setAccessToken() async {
    //get api token in here
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // set token in here
      // _accessToken = "getApi";
      // prefs.setString('access_token', _accessToken);
      // prefs.remove('access_token');
      // print('Token Main : $_accessToken');
    });
  }
  
  @override
  void initState() {
    _setAccessToken();
    super.initState();
    updateStatusBar();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('life cycle test $state');

    if(state == AppLifecycleState.resumed) {
      _timerLink = new Timer(const Duration(milliseconds: 1000), () {
        print("lifecycle masuk");
        _listenDeepLink();
      });
    }
  }

  void updateStatusBar() {
    print('masuk ke updateStatusBar');
    FlutterStatusbarManager.setColor(
        _statusBarColor.withOpacity(_statusBarOpacity),
        animated: _statusBarColorAnimated);
  }

  Future<void> _listenDeepLink() async {
    print('masuk ke listenDeepLink');

    _sub = getLinksStream().listen((String link) {
      print('link dapet $link');
    }, 
    onError: (err) {
      print('error link ga dapet $err');
    });

    dispose();
  }

  // @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_timerLink!=null) {
      _timerLink.cancel();
      _sub.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Lato',
          platform: TargetPlatform.android,
          iconTheme: IconThemeData(color: Colors.white),
          primarySwatch: Colors.blue,
          dialogBackgroundColor: Colors.black87,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        initialRoute: '/',
        routes: getRoutes());
  }
}
