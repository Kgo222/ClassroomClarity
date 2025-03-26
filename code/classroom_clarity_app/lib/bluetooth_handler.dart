import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:classroom_clarity_app/globals.dart';
import "package:classroom_clarity_app/constants.dart";
import 'package:classroom_clarity_app/homepage.dart';
import 'package:classroom_clarity_app/bluetooth_handler.dart';
import 'dart:io' show Platform;

class BLEHandler {
  StreamSubscription<List<int>>? notificationSubscription;
  StreamSubscription<BluetoothConnectionState>? connectionStateSubscription;
  List<BluetoothService> services = [];
  final Function setState;
  BluetoothDevice? connectedDevice;

  // Constructor
  BLEHandler(this.setState);

  Future<void> connect(BluetoothDevice device) async {
    try {
      await device.connect();
      //reset robot to original state
    } on FlutterBluePlusException catch(e) {
      if (e.code == 'already_connected') {
        // We really shouldn't end up here
        return;
      } else {
        rethrow;
      }
    }

    // Listen for (externally initiated) device disconnect and update UI accordingly
    connectionStateSubscription = device.connectionState.listen((s) {
      if(s == BluetoothConnectionState.disconnected) {
        // Accessing the deviceScreenHandler here is a little awkward, but it gets the job done
        // Equivalent to disconnectDevice in homepage.dart
        disconnect(); // Cancel subscription streams
        setState(); // Update UI
      }
    });

    connectedDevice = device;
    hub = device.platformName;
    setState();

    services = await device.discoverServices();

  }



  /*void bluetoothWrite(motorNum, direction) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.uuid) {
          // Format data
          String data = motorNum+ "|" + direction + "%";
          print(data); //For debug purposes only
          if (Platform.isAndroid)
          {
            await characteristic.write(utf8.encode(data), withoutResponse: true);
          }
          else if (Platform.isIOS)
          {
            await characteristic.write(utf8.encode(data));
          }
          return;
        }
      }
    }
  }*/

  Future<void> bluetoothWrite(direction) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.question_uuid) {
          // Format data
          String data = "$question%%"; //formats the data to be like "I don't understand the last problem%%" so %% marks end
          print(data); //For debug purposes only
          if (Platform.isAndroid)
          {
            await characteristic.write(utf8.encode(data), withoutResponse: true);
          }
          else if (Platform.isIOS)
          {
            await characteristic.write(utf8.encode(data));
          }
          return;
        }
        if (characteristic.uuid.toString() == Constants.rating_uuid) {
          // Format data
          String data = "$engagementLevel%%"; //formats the data to be like "I don't understand the last problem%%" so %% marks end
          print(data); //For debug purposes only
          if (Platform.isAndroid)
          {
            await characteristic.write(utf8.encode(data), withoutResponse: true);
          }
          else if (Platform.isIOS)
          {
            await characteristic.write(utf8.encode(data));
          }
          return;
        }
      }
    }
  }

  void subscribeNotifications() async { //notify when something returns from arduino
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if(characteristic.properties.notify) {
          await characteristic.setNotifyValue(true);
          notificationSubscription = characteristic.onValueReceived.listen((value) async {
            //String s = String.fromCharCodes(value);
            String s = utf8.decode(value);
            print("received: $s");
          });
          await Future.delayed(const Duration(milliseconds: 500));
          return;
        }
      }
    }
  }

  void disconnect() {
    if(connectedDevice != null) {
      connectedDevice!.disconnect();
      connectedDevice = null;
    }
  }
}
