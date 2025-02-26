import 'package:flutter/material.dart';
import 'dart:async';
import 'theme.dart';

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
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  //ENGAGEMENT BUTTON 1
                  Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Engagement Level = 1');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red1,
                      ),

                      child: Text(
                        "1",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.black, fontSize:15),
                      ),
                    ),
                  )
                ] // Engagement Row Children
            ),
          ] // Column children
        )
      )
    );
  }
}