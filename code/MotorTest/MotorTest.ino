#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library
#include <vector>
//My classes

TFT_eSPI tft = TFT_eSPI();  // Create TFT object
#define SCREEN_WIDTH  420
#define SCREEN_HEIGHT  360
#define TEXT_MARGIN 10

#define CLR_BUTTON_PIN 16 //Clear button pin 
#define ROT_A 33 
#define ROT_B 27
#define LED_NOTIF 21 //
#define MOTOR 7

void setup() {
  pinMode(MOTOR, OUTPUT);    //Set clear button at input
  Serial.begin(9600);
  digitalWrite(LED_NOTIF,LOW);
  
}

void loop() {
    digitalWrite(MOTOR,HIGH);
    delay(30000) //wait 30s
    digitalWrite(MOTOR,LOW);
    delay(30000) //wait 30s
}




