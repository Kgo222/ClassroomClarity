#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library
#include <vector>
//My classes
#include <screenControl.h>

TFT_eSPI tft = TFT_eSPI();  // Create TFT object
#define SCREEN_WIDTH  420
#define SCREEN_HEIGHT  360
#define TEXT_MARGIN 10


void setup() {
  // Optional: manually initialize SPI if needed
  SPI.begin(10, 9, 11, 14); // SCLK, MISO, MOSI, CS

  //Setup Start Screen 
  tft.init();          // Initialize TFT
  tft.setRotation(1);  // Set screen rotation (0-3)
  tft.fillScreen(TFT_WHITE); // Clear screen
  tft.setTextColor(TFT_BLACK);  
  tft.setTextSize(3);  

  Serial.begin(9600);
  //Set initial Conditionns
  tft.setCursor(0, 0);
  tft.print("WE DID IT!!!");
  
}

void loop() {
    //CLEAR BUTTON
    delay(1000); // wait 1 second
    tft.fillScreen(TFT_WHITE); // Clear screen
    tft.setCursor(0, 0);
    tft.print("WE DID IT!!!");
  
}




