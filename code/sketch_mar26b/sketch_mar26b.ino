// ESP32 device code main for WECEGlasses
#include "BLEHandler.h"
#include <string>  // Add this line

BLEHandler ble;

void setup() {
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
