// ESP32 device code main for WECEGlasses
#include "BLEHandler.h"
#include <string>  // Add this line

BLEHandler ble;

int instructor_password;
int student_password;

String entered_password = "";

void setup() {
  //Set new access password
  instructor_password = 123456; //random(100000, 999999);  // Random 6 digit number
  student_password = 123456;//random(100000, 999999); // Random 6 digit number
  Serial.begin(115200); // Printing for debugging/logging
  ble.init(student_password, instructor_password);
  /*
  Serial.print("Instructor Password:");
  Serial.println(instructor_password);
  Serial.print("Student Password:");
  Serial.println(student_password);
  */
}

void loop() {
  // Check for new data
  if(ble.isDataAvailable()) {
    DataReceived data = ble.getData();
    Serial.print("Received Data: ");
    Serial.println(data.data.c_str());
    Serial.print("Source: ");
    Serial.println(data.source.c_str());
    //Check Password
    if (data.source == "PI" && ble.isInstructorAuthenticated()) {
      Serial.println("Instructor is authenticated, access granted.");
    } else if (data.source == "PS" && ble.isStudentAuthenticated()) {
      Serial.println("Student is authenticated, access granted.");
    }
  }
}
