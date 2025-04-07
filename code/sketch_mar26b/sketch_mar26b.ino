// ESP32 device code main for WECEGlasses
#include "BLEHandler.h"
#include <string>  // Add this line

BLEHandler ble;

int instructor_password;
int student_password;

String entered_password = "";

void setup() {
  //Set new access password
  instructor_password = random(100000, 999999);  // Random 6 digit number
  student_password = random(100000, 999999); // Random 6 digit number
  Serial.begin(115200); // Printing for debugging/logging
  ble.init();
}

void loop() {
  // Check for new data
  if(ble.isDataAvailable()) {
    DataReceived data = ble.getData();
    Serial.print("Received Data: ");
    Serial.println(data.data.c_str());
    Serial.print("Type of Received Data: ");
    Serial.println(data.source.c_str());
  }

}
