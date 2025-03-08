import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';
import "constants.dart";
import 'login.dart';
import "homepage.dart";
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}
class _StudentLoginPageState extends State<StudentLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Login"),
        backgroundColor: AppColors.denim,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 25),
                child: const Text(
                  'Hello, Student!',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 45),
                )
            ),
            Padding(
                padding: EdgeInsets.only(top: 50),
                child: const Text(
                  'Please enter the name you would like to be displayed:',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 35),
                )
            ),
            //TEMPORARY to access next screen
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow1,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const HomePage(title: Constants.appName);
                    }),
                  );
                },
              child: const Text(
                  "DEBUG: NEXT PAGE",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.black, fontSize:15)
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}