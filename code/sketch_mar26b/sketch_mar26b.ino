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
    Serial.println(ble.getData().c_str());
  }

}
