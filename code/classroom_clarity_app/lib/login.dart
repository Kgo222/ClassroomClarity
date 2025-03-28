import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';
import 'studentLogin.dart';
import 'instructorLogin.dart';
import 'bluetooth_handler.dart';
import 'bluetooth.dart';

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
        title: const Text("Login"),
        backgroundColor: AppColors.denim,
        leading:null, //Remove back arrow
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 50),
                child: const Text(
                  'WELCOME\nTO\nCLASSROOM CLARITY',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 45),
                )
            ),
            Padding(
                padding: EdgeInsets.only(top: 50),
                child: const Text(
                  'Sign in as:',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 35),
                )
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    // STUDENT BUTTON
                    Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100,100),
                            backgroundColor: AppColors.dullPurple,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                              "Student",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.black, fontSize:20)
                          ),
                          onPressed:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const StudentLoginPage();
                              }),
                            );
                          }
                      ),
                    ),
                    // INSTRUCTOR BUTTON
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100,100),
                          backgroundColor: AppColors.lightBlue,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                            "Instructor",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.black, fontSize:20)
                        ),
                        onPressed:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const InstructorLoginPage();
                            }),
                          );
                        }
                    ),
                  ] //children
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}