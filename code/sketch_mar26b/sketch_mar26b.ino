// ESP32 device code main for WECEGlasses
#include "BLEHandler.h"
#include "ScreenHandler.h"
#include "ButtonHandler.h"
#include <string>  // Add this line


ButtonHandler button;
ScreenHandler screenHandler;
BLEHandler ble;

void setup() {
  Serial.begin(115200); // Printing for debugging/logging
  ble.init();
}

void loop() {
  // Check for new data
  if(ble.isDataAvailable()) {
    Serial.println(ble.getData());
  }

}
