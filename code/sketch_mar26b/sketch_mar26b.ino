// ESP32 device code main for WECEGlasses
#include "BLEHandler.h"
#include <string>  // Add this line

BLEHandler ble;

int instructor_password;
int student_password;

bool studentAuthenticated;
bool teacherAuthenticated;

void setup() {
  //Set new access password
  instructor_password = 123456; //random(100000, 999999);  // Random 6 digit number
  student_password = 123456;//random(100000, 999999); // Random 6 digit number
  studentAuthenticated = false;
  teacherAuthenticated= false;
  Serial.begin(115200); // Printing for debugging/logging
  ble.init();
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
    DataReceived receivedData = ble.getData();
    Serial.print("Received Data: ");
    Serial.println(receivedData.data.c_str());
    Serial.print("Source: ");
    Serial.println(receivedData.source.c_str());
    //Check Password
    if (receivedData.source == "P") {
      int index = receivedData.data.find("/");
      std::string typeP = receivedData.data.substr(0,index);
      std::string entered_password = receivedData.data.substr(index+1);
      if(typeP == "I"){
        if(std::stoi(entered_password) == instructor_password){
          Serial.println("Instructor is authenticated, access granted.");
          ble.notifyESP("1");
        }else{
          Serial.println("Incorrect Instructor Password");
          ble.notifyESP("2");
        }
      }else if (typeP == "S") {
        if(std::stoi(entered_password) == student_password){
          Serial.println("Student is authenticated, access granted.");
          ble.notifyESP("3");
        }else{
          Serial.println("Incorrect Student Password");
          ble.notifyESP("4");
        }
      }
    } 
  }
}
