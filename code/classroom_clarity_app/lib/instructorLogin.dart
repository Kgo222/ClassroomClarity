import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';
import 'login.dart';
import 'homepage_instructor.dart';
import "bluetooth_handler.dart";
import "bluetooth.dart";

class InstructorLoginPage extends StatefulWidget {
  const InstructorLoginPage({Key? key}) : super(key: key);

  @override
  State<InstructorLoginPage> createState() => _InstructorLoginPageState();
}
class _InstructorLoginPageState extends State<InstructorLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //for the text submission box
  final TextEditingController _controller = TextEditingController(); //for the text submission box

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
        title: const Text("Instructor Login"),
        backgroundColor: AppColors.denim,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(bleHandler.connectedDevice == null)...[
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: const Text(
                    'Hello, Instructor!',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(color: AppColors.black, fontSize: 35),
                  )
              ),
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
                margin: const EdgeInsets.only(left:20),
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
            if(bleHandler.connectedDevice != null && instructorAuthenticated == false)...[ //Authenticator
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left:20),
                child: Text(
                  connectionText,
                  style: TextStyle(fontSize: 28,color: AppColors.black),
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
                  minLines: 1,
                  maxLines: 2,
                  obscureText: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter the Instructor Password',
                    hintStyle: TextStyle(color: AppColors.denim)
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
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    bleHandler.bluetoothWriteP("I", _controller.text); //sends input
                    //setState(() {
                    //});
                    _controller.clear(); //Reset TextField
                  },
                child: const Text('Submit'),
                ),
              ),
            ],
            if(bleHandler.connectedDevice != null && instructorAuthenticated == true)...[ //Authenticated
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    'Press Continue to Enter ${bleHandler.connectedDevice!.name} Hub or Disconnect',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(color: AppColors.black, fontSize: 25),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.denim,
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
                    backgroundColor: AppColors.lightBlue,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: (){
                    disconnectDevice;
                    instructorAuthenticated = false;
                  },
                  child: Text(
                    "Disconnect",
                    style: const TextStyle(fontSize: 20,color: AppColors.black),
                  ),
                ),
              ),

            ], //if not n
            //TEMPORARY to access next screen
            ElevatedButton(
              onPressed: () {
                print(bleHandler.connectedDevice);
                print(instructorAuthenticated);
                print(connectionText);
              },
              child: const Text('Device Connected?'),
            ),
          ],

        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}