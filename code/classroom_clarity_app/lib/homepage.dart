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
                            isSelected: engagementLevel == 1,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 1;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 2
                          EngagementButton(
                            level: 2,
                            color: AppColors.red2,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 2,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 2;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 3
                          EngagementButton(
                            level: 3,
                            color: AppColors.red3,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 3,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 3;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 4
                          EngagementButton(
                            level: 4,
                            color: AppColors.red4,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 4,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 4;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 5
                          EngagementButton(
                            level: 5,
                            color: AppColors.yellow1,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 5,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 5;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 6
                          EngagementButton(
                            level: 6,
                            color: AppColors.yellow2,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 6,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 6;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 7
                          EngagementButton(
                            level: 7,
                            color: AppColors.yellow3,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 7,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 7;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 8
                          EngagementButton(
                            level: 8,
                            color: AppColors.green1,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 8,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 8;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 9
                          EngagementButton(
                            level: 9,
                            color: AppColors.green2,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 9,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 9;
                              });
                            },
                          ),
                          //ENGAGEMENT BUTTON 10
                          EngagementButton(
                            level: 10,
                            color: AppColors.green3,  // Assign specific color from AppColors
                            isSelected: engagementLevel == 10,
                            onPressed: () {
                              setState(() {
                                engagementLevel = 10;
                              });
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //Validate form
                        if (_formKey.currentState!.validate()) {
                          // save name from the controller
                          setState(() {
                            question = _controller.text; // Save the entered name
                          });
                          print("Question: $question"); //Debug Purposes
                          bleHandler.bluetoothWriteQ(question);
                          _controller.clear(); //Reset TextField
                        }
                      },
                      child: const Text('Submit'),
                    ),
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
                            engagementLevel = 10;
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