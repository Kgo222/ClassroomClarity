import 'package:flutter/material.dart';
import 'theme.dart';
import 'constants.dart';
import 'login.dart';
import 'bluetooth.dart';
import 'bluetooth_handler.dart';
import 'globals.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    bleHandler = BLEHandler(setStateCallback);  // Initialize BLEHandler
  }

  // Callback to trigger setState() from BLEHandler
  void setStateCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      theme: appTheme,
      home: LoginPage(), // Pass bleHandler down to LoginPage
      navigatorKey: navigatorKey,
    );
  }
}
