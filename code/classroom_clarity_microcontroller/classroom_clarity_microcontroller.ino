#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library
#include <vector>
#include <string>

//My classes
#include "BLEHandler.h"
#include "screenControl.h"

//Settings


//Bluetooth 
BLEHandler ble; //Create a bluetooth handler object 
bool newData = false;
DataReceived dataReceived;
//Password
int instructor_password;  //holds the randomly generated instructor password
int student_password;   // holds the randomly generated student password
std::string s_password_printout;
std::string i_password_printout;

bool printP = true;



void setup() {
  //Setup Start Screen 
  Serial.begin(115200);

  //Set initial Conditionns
  instructor_password = random(100000, 999999);  // Random 6 digit number
  student_password = random(100000, 999999);  // Random 6 digit number
  s_password_printout = "student code: " + std::to_string(student_password);
  i_password_printout = "instructor code: " + std::to_string(instructor_password);

  ble.init(); //initialize bluetooth
  Serial.println("finish setup");
}

void loop() {
  if(printP){
    Serial.print("Instructor Password:");
    Serial.println(instructor_password);
    Serial.print("Student Password:");
    Serial.println(student_password);
    printP = false;
  }
  //BLUETOOTH DATA CHECK
  if(ble.isDataAvailable()) {
    dataReceived = ble.getData();
    Serial.print("Received Data: ");
    Serial.println(dataReceived.data.c_str());
    Serial.print("Type of Received Data: ");
    Serial.println(dataReceived.source.c_str());
    newData = true;
  }
  if(newData){
    if (dataReceived.source == "P") { // Check if password inputted 
      int index = dataReceived.data.find("/");
      std::string typeP = dataReceived.data.substr(0,index);
      std::string entered_password = dataReceived.data.substr(index+1);
      if(typeP == "I"){ // check if the password inputted was for instructor
          Serial.println("Instructor is authenticated, access granted.");
          ble.notifyESP("1"); //tell app the password was accepted
      }else if (typeP == "S") { // check if the password inputted was for student
          ble.notifyESP("3"); //tell app password was accepted
      }
    }
  }
  //reset variables
  newData = false;

}



