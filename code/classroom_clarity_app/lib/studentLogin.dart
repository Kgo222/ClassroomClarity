import 'package:flutter/material.dart';
import 'theme.dart';
import 'globals.dart';
import "constants.dart";
import 'login.dart';
import "homepage.dart";
import "bluetooth_handler.dart";
import "bluetooth.dart";
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}
class _StudentLoginPageState extends State<StudentLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //for the text submission box
  final TextEditingController _controller = TextEditingController(); //for the text submission box
  //bluetooth
  final List<ScanResult> _recordList = [];
  //Bluetooth functions start
  void searchForDevices() async {
    if (await FlutterBluePlus.isSupported == false) {
      debugPrint("Bluetooth not supported by this device");
      return;
    } else {
      startScanning();
    }
  }
  void startScanning() async {
    _recordList.clear();

    await FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!_recordList.contains(result)) {
          _recordList.add(result);
          debugPrint(result.device.advName);
        }
      }

      setState(() {});
    });
  }

  void goStudentHomePage(){
    // Navigate to the HomePage once the device is connected
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const HomePage(title: Constants.appName);
      }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Login"),
        backgroundColor: AppColors.denim,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  'Hello, $name!',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: AppColors.black, fontSize: 45),
                )
            ),
            if(name == "Student")...[
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
                        hintText: 'Enter your name',
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
                    //Validate form
                    if (_formKey.currentState!.validate()) {
                      // save name from the controller
                      setState(() {
                        name = _controller.text; // Save the entered name
                      });
                      print("Name: $name"); //Debug Purposes
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ], //if statement
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
                margin: const EdgeInsets.only(left:20),
                child:ElevatedButton(
                  onPressed: connectDevicePrompt,
                  child: Text(
                    "Connect",
                    style: TextStyle(fontSize: 28,color: AppColors.black),
                  ),
                ),
              ),
            ],
            if(name != "Student" && bleHandler.connectedDevice != null)...[
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    'Press Continue to Enter $hub Hub or Disconnect',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(color: AppColors.black, fontSize: 45),
                  )
              ),
            //TEMPORARY to access next screen
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow1,
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
                  style: TextStyle(color: AppColors.black, fontSize:15)
              ),
            ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left:20),
                // Change button text when clicked.
                child:ElevatedButton(
                  onPressed: disconnectDevice,
                  child: Text(
                  "Disconnect: ${bleHandler.connectedDevice!.platformName}",
                  style: const TextStyle(fontSize: 15,color: AppColors.black),
                  ),
                ),
              ),
            ], //if not null
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}