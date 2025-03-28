import 'package:flutter/material.dart';
import 'theme.dart';
import 'constants.dart';
import 'login.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp( MyApp());

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The app theme is defined in constants.dart
      title: Constants.appName,
      // The app theme is defined in theme.dart
      theme: appTheme,
      // This directs the app to start at the screen class called MyHomePage.
      // Currently the main screen is the default from Flutter, but we will
      // edit the screens and screen routes as needed.
      home: const LoginPage(),
      navigatorKey: navigatorKey,
    );
  }
}