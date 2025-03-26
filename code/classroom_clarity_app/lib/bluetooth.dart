import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:classroom_clarity_app/globals.dart';
import 'package:classroom_clarity_app/homepage.dart';
import 'package:classroom_clarity_app/bluetooth_handler.dart';


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

    //Gets the connected devices
    List<BluetoothDevice> temp = [];
    List<BluetoothDevice> devices = await FlutterBluePlus.connectedDevices;
    for (BluetoothDevice device in devices) {
        if (!temp.contains(device)) {
          temp.add(device);
        }
    }

    //Listen for scan results
    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (!temp.contains(result.device)) {
          temp.add(result.device);
        }
      }
    });
    setState(() {
      deviceList = temp;
    });
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    await bleHandler.connect(device);
    // Start waiting for notifications
    bleHandler.subscribeNotifications();

    // Exit screen
    Navigator.pop(context);
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
                  onPressed: () => connectDevice(device),
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


