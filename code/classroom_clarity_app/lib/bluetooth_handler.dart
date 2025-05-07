import 'dart:async';
import 'package:classroom_clarity_app/globals.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'constants.dart';
import 'dart:io' show Platform;
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEHandler {
  late StreamSubscription notificationSubscription;
  late StreamSubscription connectionStateSubscription;
  List<BluetoothService> services = [];
  final void Function() setState;
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
        setState(); // Update UI when device disconnects
      }
    });

    connectedDevice = device;
    //print("Connected Device: $connectedDevice");

    services = await device.discoverServices();
    //print("Discovered Services: $services");

    //setState(() {}); // Update UI when device disconnects

  }

  void bluetoothWriteQ(question, name) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.question_uuid) {
          // Format data
          String data = "$name/$question%";
          print("Sending Data: $data"); //For debug purposes only
          //print("Characteristic Properties: ${characteristic.properties}"); // debug
          try {
            if(characteristic.properties.write){// Normal write mode
              await characteristic.write(utf8.encode(data));
            } else if (characteristic.properties.writeWithoutResponse) { // no response write mode
              // Use write without response if supported
              await characteristic.write(utf8.encode(data), withoutResponse: true);
            } else {
              print("Error: Characteristic does not support writing.");
            }
          } catch (e) {
            print("Write Error: $e");
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
          String data = prevRating.toString() + "/" + currRating.toString() + "%";
          print("Sending Data: $data"); //For debug purposes only
          try {
            if(characteristic.properties.write){// Normal write mode
              await characteristic.write(utf8.encode(data));
            } else if (characteristic.properties.writeWithoutResponse) { // no response write mode
              // Use write without response if supported
              await characteristic.write(utf8.encode(data), withoutResponse: true);
            } else {
              print("Error: Characteristic does not support writing.");
            }
          } catch (e) {
            print("Write Error: $e");
          }
          return;
        }
      }
    }
  }

  void bluetoothWriteS(fontSize, silentMode) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.settings_uuid) {
          // Format data
          String data = fontSize.toString() + "/" + silentMode.toString() + "%";
          print("Sending Data: $data"); //For debug purposes only
          try {
            if(characteristic.properties.write){// Normal write mode
              await characteristic.write(utf8.encode(data));
            } else if (characteristic.properties.writeWithoutResponse) { // no response write mode
              // Use write without response if supported
              await characteristic.write(utf8.encode(data), withoutResponse: true);
            } else {
              print("Error: Characteristic does not support writing.");
            }
          } catch (e) {
            print("Write Error: $e");
          }
          return;
        }
      }
    }
  }

  //write password
  void bluetoothWriteP(type, password) async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == Constants.P_uuid) {
          // Format data
          String data = "$type/$password";
          print("Sending Data: $data"); //For debug purposes only
          try {
            if(characteristic.properties.write){// Normal write mode
              await characteristic.write(utf8.encode(data));
            } else if (characteristic.properties.writeWithoutResponse) { // no response write mode
              // Use write without response if supported
              await characteristic.write(utf8.encode(data), withoutResponse: true);
            } else {
              print("Error: Characteristic does not support writing.");
            }
          } catch (e) {
            print("Write Error: $e");
          }
          return;
        }
      }
    }
  }

  void subscribeNotifications() async {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print('Checking characteristic: ${characteristic.uuid}');
        if (characteristic.properties.notify) {
          try {
            await characteristic.setNotifyValue(true);
            print("Subscribed to notifications for characteristic: ${characteristic.uuid}");

            notificationSubscription = characteristic.lastValueStream.listen((value) async {
              String receivedData = String.fromCharCodes(value);
              print("Received from ${characteristic.uuid}: $receivedData");

              // Handle authentication messages and update UI
              if (receivedData == Constants.correctPScode) {
                studentAuthenticated = true;
                connectionText2 = "Correct Password! \nPress Continue to Enter";
              } else if (receivedData == Constants.incorrectPScode) {
                studentAuthenticated = false;
                connectionText2 = "Incorrect Password. \nTry Again.";
              } else if (receivedData == Constants.correctPIcode) {
                instructorAuthenticated = true;
                connectionText = "Correct Password! \nPress Continue to Enter";
              } else if (receivedData == Constants.incorrectPIcode) {
                instructorAuthenticated = false;
                connectionText = "Incorrect Password. \nTry Again.";
              }


            });
          } catch (e) {
            print("Error subscribing to characteristic notifications: $e");
          }
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
