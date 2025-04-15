import 'package:flutter/material.dart';
import 'dart:async';
import 'theme.dart';
import 'globals.dart';
import 'login.dart';

class HomePageInstructor extends StatefulWidget {
  const HomePageInstructor({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<HomePageInstructor> createState() => _HomePageInstructorState();
}
class _HomePageInstructorState extends State<HomePageInstructor> {
  double _currentSliderVal = font_size;
  bool switchVal = silent_mode;

  void disconnectDevice() {
    setState(() {
      bleHandler.disconnect();
      print("disconnect");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hub Settings"),
          backgroundColor: AppColors.denim,
          leading: null,
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'Select Font Mode: $font_size',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(color: AppColors.black, fontSize: 25),
                      )
                  ),
                  SizedBox(
                    width: 350,
                    child: Slider(
                        value: _currentSliderVal,
                        max:max_font_size,
                        min:min_font_size,
                        divisions: (max_font_size-min_font_size).toInt(),
                        label:_currentSliderVal.round().toString(),
                        activeColor: AppColors.darkRed,
                        inactiveColor: AppColors.dullPurple,
                        onChanged: (double value){
                          setState((){
                            _currentSliderVal = value;
                            font_size = value;
                          });
                        },
                        onChangeEnd: (double value){
                          bleHandler.bluetoothWriteS(font_size, silent_mode);
                        }
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SILENT MODE
                      Text(
                        'Silent Mode:',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(color: AppColors.black, fontSize: 25),
                      ),
                      Switch(
                          value: switchVal,
                          activeColor: AppColors.darkRed,
                          activeTrackColor: AppColors.red1,
                          inactiveThumbColor: AppColors.black,
                          inactiveTrackColor: AppColors.dullPurple,
                          onChanged: (bool value){
                            setState((){
                              switchVal = value;
                              silent_mode = value;
                            });
                            bleHandler.bluetoothWriteS(font_size, silent_mode);
                          },
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        //SIGN OUT BUTTON
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.dullPink,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed:(){
                            if(bleHandler.connectedDevice != null){
                              disconnectDevice();
                            }
                            instructorAuthenticated = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const LoginPage();
                              }),
                            );
                          },
                          child: const Text(
                              "Sign Out",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.black, fontSize:20)
                          ),
                        ),
                      ]
                  ),
                ] // Column children
            )
        )
    );
  }
}