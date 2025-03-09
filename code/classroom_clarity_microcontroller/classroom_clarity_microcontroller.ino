#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library


TFT_eSPI tft = TFT_eSPI();  // Create TFT object

#define CLR_BUTTON_PIN 16 //Clear button pin 
#define ROT_A 33
#define ROT_B 27

int encoderPos = 0;      // Variable to keep track of the position of the encoder
int lastEncoded = 0;     // Last state of the encoder (used for detecting changes)
int currentEncoded = 0;  // Current state of the encoder


void setup() {
  tft.init();          // Initialize TFT
  tft.setRotation(1);  // Set screen rotation (0-3)
  tft.fillScreen(TFT_WHITE); // Clear screen

  tft.setTextColor(TFT_BLACK);  
  tft.setTextSize(2);  
  tft.setCursor(10, 20);  
  tft.println("Hello, ESP32!");

  pinMode(CLR_BUTTON_PIN, INPUT_PULLUP);
  pinMode(ROT_A, INPUT);  // Set encoder A pin as input
  pinMode(ROT_B, INPUT); 
  Serial.begin(115200);
}

void loop() {
  //tft.fillScreen(random(0xFFFF)); // Change screen color randomly
  //Serial.print("changed");
  tft.setCursor(0, 0);  
  //CLEAR BUTTON
  int CLRbuttonState = digitalRead(CLR_BUTTON_PIN);  // Read the state of the button
  if (CLRbuttonState == LOW) {  // Button is pressed (because the internal pull-up resistor pulls it HIGH when not pressed)
      tft.fillScreen(TFT_WHITE); 
      tft.println("Button Pressed!");
    } else {
      tft.println("Button Not Pressed");
    }

    // ROTARY ENCORDER
    // Read the current state of the A and B pins
    currentEncoded = (digitalRead(ROT_A) << 1) | digitalRead(ROT_B);

    // Check if the encoder position has changed
    int change = (lastEncoded << 2) | currentEncoded;  // Combine the last and current states
    if (change == 0b1101 || change == 0b0110) {
      encoderPos++;  // Clockwise rotation
    }
    if (change == 0b1110 || change == 0b0001) {
      encoderPos--;  // Counter-clockwise rotation
    }

    // Update the lastEncoded state for the next loop
    lastEncoded = currentEncoded;

    // Print the current position of the encoder to the Serial Monitor
    Serial.print("Encoder Position: ");
    Serial.println(encoderPos);

    delay(10); 
}


