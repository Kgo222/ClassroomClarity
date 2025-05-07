import 'dart:async';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'main.dart';
import "bluetooth_handler.dart";

// Bluetooth connection screen
class BluetoothConnectScreen extends StatefulWidget {
  const BluetoothConnectScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothConnectScreen> createState() => _BluetoothConnectScreen();
}

class _BluetoothConnectScreen extends State<BluetoothConnectScreen> {
  List<BluetoothDevice> deviceList = [];

  @override
  void initState() {
    super.initState();
    Future(() {
      updateDeviceList();
    });
  }

  Future<void> updateDeviceList() async {
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    } on Exception catch(e) {
      if(e.toString() == "Exception: Another scan is already in progress.") {
        return;
      } else {
        rethrow;
      }
    }

    List<BluetoothDevice> temp = [];
    // Listen for connected devices
    List<BluetoothDevice> connectedDevices = await FlutterBluePlus.connectedDevices;
    temp.addAll(connectedDevices);

    // Listen for scan results
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!temp.any((d) => d.remoteId == result.device.remoteId)) {
          temp.add(result.device);
        }
      }
      /*
        setState(() {
          deviceList = temp;
        });
      });
    */
    if (mounted) {
      setState(() {
        deviceList = temp; // Update device list in the UI
      });
    }

    // Check if the widget is still mounted before calling setState(
    });
  }

  Future<void> connectDevice(BuildContext context, BluetoothDevice device) async {
    await bleHandler.connect(device);
    // Start waiting for notifications
    bleHandler.subscribeNotifications();

    // Exit screen
    //Navigator.pop(context);
    navigatorKey.currentState?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect a Device',
          style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 4, 6, 4)),),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: updateDeviceList,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: deviceList.map((device) {
            return Card(
              child: ListTile(
                title: Text(device.platformName + " (" + device.remoteId.toString() + ")"
                  ,style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 4, 6, 4)),),
                trailing: TextButton(
                  onPressed: () {
                    print("'${DateTime.now().toIso8601String()} - START CONNECT");
                    connectDevice(context, device);
                  },
                  child: const Text("Connect"),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}



