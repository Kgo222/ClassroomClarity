import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';
import "constants.dart";
import 'login.dart';
import "homepage.dart";
import "bluetooth_handler.dart";
import "bluetooth.dart";

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}
class _StudentLoginPageState extends State<StudentLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //for the text submission box
  final TextEditingController _controller = TextEditingController(); //for the text submission box
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>(); //for the text submission box
  final TextEditingController _controller2 = TextEditingController(); //for the text submission box


  //Bluetooth functions start

  void goStudentHomePage(){
    // Navigate to the HomePage once the device is connected
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const HomePage(title: Constants.appName);
      }),
    );
  }
  //Bluetooth Methods
  void connectDevicePrompt() {
    // Show prompt for connecting a device
    /*
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const BluetoothConnectScreen();
        });
     */
    // Show prompt for connecting a device
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const BluetoothConnectScreen();
      },
    ).then((_) {
      // After closing the modal, check if the device is connected and update the UI.
      if(bleHandler.connectedDevice != null){
        connectionText = "Enter Instructor Password for ${bleHandler.connectedDevice!.name}";
        connectionText2 = "Enter Student Password for ${bleHandler.connectedDevice!.name}";
        setState(() {});
      }
    });
  }
  void disconnectDevice() {
    setState(() {
      bleHandler.disconnect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Login"),
        backgroundColor: AppColors.denim,
        leading:null,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(bleHandler.connectedDevice == null)...[
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    'Hello, $name!',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(color: AppColors.black, fontSize: 45),
                  )
              ),
            //GET STUDENT NAME
              if(name == "Student")...[
                Padding(
                  padding: EdgeInsets.only(right:30.0, left:30.0, top:15.0),
                  child: Form(
                    key: _formKey, //attach form key
                    child: TextFormField(
                      controller: _controller,
                      //attaches the controller
                      style: TextStyle(color: Colors.black),
                      // Set the text color to black
                      minLines: 1,
                      maxLines: 2,
                      obscureText: false,
                      decoration: const InputDecoration(
                          hintText: 'Enter your name',
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
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:240.0),
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
                          name = _controller.text; // Save the entered name
                        });
                        print("Name: $name"); //Debug Purposes
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: AppColors.black),),
                  ),
                ),
              ], //if statement
            // CONNECT TO HUB
              if(name != "Student" && bleHandler.connectedDevice == null)...[
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left:20),
                  child: Text(
                    "Please connect a device",
                    style: TextStyle(fontSize: 28,color: AppColors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top:15.0),
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightBlue,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: connectDevicePrompt,
                    child: Text(
                      "Connect",
                      style: TextStyle(fontSize: 28,color: AppColors.black),
                    ),
                  ),
                ),
              ], //end of if statement
            ],
            if(name != "Student" && bleHandler.connectedDevice != null&& studentAuthenticated == false)...[
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(15),
                child: Text(
                  connectionText2,
                  style: TextStyle(fontSize: 28,color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:30.0, right:30.0, top: 15.0),
                child: Form(
                  key: _formKey2, //attach form key
                  child: TextFormField(
                    controller: _controller2,
                    //attaches the controller
                    style: TextStyle(color: Colors.black),
                    // Set the text color to black
                    minLines: 1,
                    maxLines: 2,
                    obscureText: false,
                    decoration: const InputDecoration(
                        hintText: 'Enter the Student Password',
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
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:240.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPurple,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey2.currentState!.validate()) {
                      // save name from the controller
                      bleHandler.bluetoothWriteP("S", _controller2.text); //sends input
                      _controller2.clear(); //Reset TextField
                      Future.delayed(const Duration(milliseconds: 500), () {
                        setState(() {});
                        print('submit button setstate.'); // Prints after 1 second.
                      });
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
              ),
            ],
            if(name != "Student" && bleHandler.connectedDevice != null&& studentAuthenticated == true)...[
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    'Press Continue to Enter ${bleHandler.connectedDevice!.name} or Disconnect',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(color: AppColors.black, fontSize: 25),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
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
                    "CONTINUE",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.black, fontSize:20)
                    ),
                  ),
              ),
              Container(
                alignment: Alignment.center,
                //margin: const EdgeInsets.only(left:20),
                // Change button text when clicked.
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dullPurple,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: (){
                    disconnectDevice();
                    studentAuthenticated = false;
                  },
                  child: Text(
                    "DISCONNECT",
                    style: const TextStyle(fontSize: 20,color: AppColors.black),
                  ),
                ),
              ),

            ],
            Spacer(), //Bringsto bottom of page
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dullPink,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: (){
                    if(bleHandler.connectedDevice != null){
                      disconnectDevice();
                    }
                    studentAuthenticated = false;
                    name = "Student";
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }),
                    );
                  },
                  child: Text(
                    "Back to Welcome",
                    style: const TextStyle(fontSize: 20,color: AppColors.black),
                  ),
                ),
              ],

            )//if not null
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}