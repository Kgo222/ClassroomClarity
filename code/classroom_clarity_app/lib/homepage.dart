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
          child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Padding(
                    padding: EdgeInsets.only(top: 20), // Moves Row 10 pixels down
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                        //RAISE HAND BUTTON
                        Expanded( //Fills whole row
                            child: Padding(
                              padding: EdgeInsets.only(right:30.0, left:30.0, top:45.0, bottom:5),
                              child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.dullPink,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed:(){
                                bleHandler.bluetoothWriteQ("Has a LIVE question", name);
                              },
                              child: const Text(
                                  "Raise Hand",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.darkRed, fontSize:15)
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:30.0, left:30.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //ANONYMOUS SWITCH
                      Row(
                        children: [
                          Text(
                            'Anonymous:',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(color: AppColors.black, fontSize: 15),
                          ),
                          Switch(
                            value: switchVal,
                            activeColor: AppColors.green2,
                            activeTrackColor: AppColors.green3,
                            inactiveThumbColor: AppColors.black,
                            inactiveTrackColor: AppColors.darkRed,
                            onChanged: (bool value){
                              setState((){
                                switchVal = value;
                                anonymous = value;
                              });
                            },
                          ),
                        ],
                      ),
                      //SUBMIT BUTTON
                      Padding(
                        padding: const EdgeInsets.only(left:50.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lightPurple,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
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
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: AppColors.black),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:250),
                    child: Row(
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
                              bleHandler.bluetoothWriteR(curr_engagementLevel, 0); // When sign out we want to remove their rating from the avg, 0 is the indicator of sign out
                              curr_engagementLevel = 5;
                              prev_engagementLevel = 0;
                              bleHandler.disconnect();
                              studentAuthenticated = false;
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
                  ),
                ] // Column children
            ),
        ),
        //)
    );
  }
}