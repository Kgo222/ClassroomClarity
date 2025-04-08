import 'package:flutter/material.dart';
import 'dart:async';
import 'theme.dart';
import 'globals.dart';
import 'buttons.dart';
import 'login.dart';
import 'bluetooth_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //for the text submission box
  final TextEditingController _controller = TextEditingController(); //for the text submission box
  bool switchVal = anonymous;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: AppColors.denim,
          leading:null,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Padding(
                    padding: EdgeInsets.only(top: 50), // Moves Row 50 pixels down
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[
                          //ENGAGEMENT BUTTON 1
                          EngagementButton(
                            level: 1,
                            color: AppColors.red1,  // Assign specific color from AppColors
                            isSelected: curr_engagementLevel == 1,
                            onPressed: () {
                              setState(() {
                                prev_engagementLevel = curr_engagementLevel;
                                curr_engagementLevel = 1;
                              });
                              bleHandler.bluetoothWriteR(prev_engagementLevel, curr_engagementLevel);
                            },
                          ),
                          //ENGAGEMENT BUTTON 2
                          EngagementButton(
                            level: 2,
                            color: AppColors.red2,  // Assign specific color from AppColors
                            isSelected: curr_engagementLevel == 2,
                            onPressed: () {
                              setState(() {
                                prev_engagementLevel = curr_engagementLevel;
                                curr_engagementLevel = 2;
                              });
                              bleHandler.bluetoothWriteR(prev_engagementLevel, curr_engagementLevel);
                            },
                          ),
                          //ENGAGEMENT BUTTON 3
                          EngagementButton(
                            level: 3,
                            color: AppColors.yellow1,  // Assign specific color from AppColors
                            isSelected: curr_engagementLevel == 3,
                            onPressed: () {
                              setState(() {
                                prev_engagementLevel = curr_engagementLevel;
                                curr_engagementLevel = 3;
                              });
                              bleHandler.bluetoothWriteR(prev_engagementLevel, curr_engagementLevel);
                            },
                          ),
                          //ENGAGEMENT BUTTON 4
                          EngagementButton(
                            level: 4,
                            color: AppColors.green1,  // Assign specific color from AppColors
                            isSelected: curr_engagementLevel == 4,
                            onPressed: () {
                              setState(() {
                                prev_engagementLevel = curr_engagementLevel;
                                curr_engagementLevel = 4;
                              });
                              bleHandler.bluetoothWriteR(prev_engagementLevel, curr_engagementLevel);
                            },
                          ),
                          //ENGAGEMENT BUTTON 5
                          EngagementButton(
                            level: 5,
                            color: AppColors.green2,  // Assign specific color from AppColors
                            isSelected: curr_engagementLevel == 5,
                            onPressed: () {
                              setState(() {
                                prev_engagementLevel = curr_engagementLevel;
                                curr_engagementLevel = 5;
                              });
                              bleHandler.bluetoothWriteR(prev_engagementLevel, curr_engagementLevel);
                            },
                          ),
                        ] // Engagement Row Children
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Form(
                      key: _formKey, //attach form key
                      child: TextFormField(
                        controller: _controller,
                        //attaches the controller
                        style: TextStyle(color: Colors.black),
                        // Set the text color to black
                        minLines: 5, // Makes a larger textbox
                        maxLines: 7, // When user presses enter it will adapt to it
                        obscureText: false,
                        decoration: const InputDecoration(
                            hintText: 'Type your Question Here',
                            hintStyle: TextStyle(color: AppColors.denim),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.denim, width:4)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.denim, width: 4), // Border color when focused
                            ),
                            filled: true,
                            fillColor: AppColors.blueGrey,
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Question';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //ANONYMOUS SWITCH
                      Text(
                        'Anonymous Submission:',
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
                            anonymous = value;
                          });
                        },
                      ),
                      //SUBMIT BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: ElevatedButton(
                          onPressed: () {
                            //Validate form
                            if (_formKey.currentState!.validate()) {
                              // save name from the controller
                              setState(() {
                                question = _controller.text; // Save the entered name
                              });
                              print("Question: $question"); //Debug Purposes
                              bleHandler.bluetoothWriteQ(question, anonymous ? "Anonymous" : name);
                              _controller.clear(); //Reset TextField
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
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
                            //Reset variables
                            name = 'Student';
                            question = "";
                            bleHandler.bluetoothWriteR(curr_engagementLevel, -1); // When sign out we want to remove their rating from the avg, -1 is the indicator of sign out
                            curr_engagementLevel = 10;
                            prev_engagementLevel = 10;
                            bleHandler.disconnect();
                            //Go back to login page
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