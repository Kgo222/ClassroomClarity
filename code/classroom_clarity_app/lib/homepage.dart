import 'package:flutter/material.dart';
import 'dart:async';
import 'theme.dart';
import 'globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.denim,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Padding(
              padding: EdgeInsets.only(top: 50), // Moves Row 50 pixels down
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    //ENGAGEMENT BUTTON 1
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 1
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 1');
                          setState(() {
                            engagementLevel =1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),

                        child: Text(
                          "1",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 2
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 2
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 2');
                          setState(() {
                            engagementLevel =2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "2",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 3
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 3
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 3');
                          setState(() {
                            engagementLevel =3;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "3",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 4
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 4
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 4');
                          setState(() {
                            engagementLevel =4;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "4",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 5
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 5
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 5');
                          setState(() {
                            engagementLevel =5;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "5",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 6
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 6
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 6');
                          setState(() {
                            engagementLevel =6;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "6",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 7
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 7
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 7');
                          setState(() {
                            engagementLevel =7;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "7",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 8
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 8
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 8');
                          setState(() {
                            engagementLevel =8;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "8",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 9
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 9
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 9');
                          setState(() {
                            engagementLevel =9;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "9",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                    //ENGAGEMENT BUTTON 10
                    Expanded(
                      child: Container(
                      //margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: engagementLevel == 10
                            ? Border.all(color: AppColors.darkRed, width: 4) // Add border if true
                            : null, // No border if false
                        ),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Engagement Level = 10');
                          setState(() {
                            engagementLevel = 10;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5), // Custom roundness
                          ),
                        ),
                        child: Text(
                          "10",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.black, fontSize:15),
                        ),
                      ),
                    ),
                    ),
                  ] // Engagement Row Children
              ),
            )
          ] // Column children
        )
      )
    );
  }
}