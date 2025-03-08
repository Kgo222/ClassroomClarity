import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';
import 'login.dart';
import 'homepage_instructor.dart';

class InstructorLoginPage extends StatefulWidget {
  const InstructorLoginPage({Key? key}) : super(key: key);

  @override
  State<InstructorLoginPage> createState() => _InstructorLoginPageState();
}
class _InstructorLoginPageState extends State<InstructorLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instructor Login"),
        backgroundColor: AppColors.denim,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 25),
                child: const Text(
                  'Hello, Instructor!',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 35),
                )
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: const Text(
                  'Please enter the instructor password displayed on your hub:',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 25),
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
                    return const HomePageInstructor();
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