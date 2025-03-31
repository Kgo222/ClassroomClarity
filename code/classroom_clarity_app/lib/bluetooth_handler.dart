import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'constants.dart';
import 'dart:io' show Platform;
//import "package:flutter_blue/flutter_blue.dart";
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEHandler {
  late StreamSubscription notificationSubscription;
  late StreamSubscription connectionStateSubscription;
  List<BluetoothService> services = [];
  Function setState;
  BluetoothDevice? connectedDevice;

  // Constructor
  BLEHandler(this.setState);

  Future<void> connect(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
    } on PlatformException catch (e) {
      if (e.code != 'already_connected') {
        rethrow;
      }
    }
    // Listen for (externally initiated) device disconnect and update UI accordingly
    connectionStateSubscription = device.state.listen((s) {
      if(s ==  BluetoothConnectionState.disconnected) {
        // Accessing the deviceScreenHandler here is a little awkward, but it gets the job done
        // Equivalent to disconnectDevice in homepage.dart
        disconnect(); // Cancel subscription streams
        setState(() {}); // Update UI when device disconnects
      }
    });

    connectedDevice = device;
    print("Connected Device: $connectedDevice");

    services = await device.discoverServices();
    print("Discovered Services: $services");

    //setState(() {}); // Update UI when device disconnects

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

  void bluetoothWriteQ(question) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.question_uuid) {
          // Format data
          String data = question + "%";
          print("Sending Data: $data"); //For debug purposes only
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

  void bluetoothWriteR(prevRating, currRating) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.rating_uuid) {
          // Format data
          String data = prevRating + "/" + currRating + "%";
          print("Sending Data: $data"); //For debug purposes only
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
          notificationSubscription = characteristic.lastValueStream.listen((value) async {
            String s = String.fromCharCodes(value);
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
