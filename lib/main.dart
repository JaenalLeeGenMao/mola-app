import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

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

class _MyAppState extends State<MyApp> {
  /// This widget is the root of your application.
  Color _statusBarColor = Color.fromRGBO(8, 44, 66, 1.0);
  double _statusBarOpacity = 1.0;
  bool _statusBarColorAnimated = false;

  @override
  initState() {
    updateStatusBar();
    super.initState();
  }

  void updateStatusBar() {
    FlutterStatusbarManager.setColor(
        _statusBarColor.withOpacity(_statusBarOpacity),
        animated: _statusBarColorAnimated);
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
