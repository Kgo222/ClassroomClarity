import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Power Information"),
        backgroundColor: AppColors.denim,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.yellow1,
                      border: Border.all(width: 8, color: AppColors.yellow2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // Change button text when clicked.
                    child: const Text(
                      'Power Calculation',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(color: AppColors.black, fontSize:45),
                    ),
                  ),
                ] //children
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}