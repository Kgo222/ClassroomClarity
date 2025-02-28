import 'package:flutter/material.dart';
import 'dart:async';
import 'theme.dart';
import 'globals.dart';
import 'buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _submittedText = ''; // Variable to hold submitted text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: AppColors.denim,
        ),
        body: Center(
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
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.black), // Set the text color to black
                      minLines: 6, // Makes a larger textbox
                      maxLines: 10, // When user presses enter it will adapt to it
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.denim, width:4)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.denim, width: 4), // Border color when focused
                          ),
                          label: Text.rich(
                            TextSpan(
                              text: 'Ask your Question Here:',
                              style: TextStyle(color:AppColors.black)
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.grey,
                          ),
                      ),
                  ),
                ] // Column children
            )
        )
    );
  }
}