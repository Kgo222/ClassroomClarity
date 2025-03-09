#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library


TFT_eSPI tft = TFT_eSPI();  // Create TFT object

#define CLR_BUTTON_PIN 16 //Clear button pin 
#define ROT_A 33
#define ROT_B 27

//int encoderPos = 0;      // Variable to keep track of the position of the encoder
int prevEncoderPos = 0; // Tracks the previous postion of encoder
int lastEncoded = 0;     // Last state of the encoder (used for detecting changes)
int currentEncoded = 0;  // Current state of the encoder

//MY VERSION
int rotApos = 0;
int rotBpos = 0;
int encoderPos = 0;
long oldPosition  = -999;


void setup() {
  tft.init();          // Initialize TFT
  tft.setRotation(1);  // Set screen rotation (0-3)
  tft.fillScreen(TFT_WHITE); // Clear screen

  tft.setTextColor(TFT_BLACK);  
  tft.setTextSize(2);  
  tft.setCursor(10, 20);  
  tft.println("Hello, ESP32!");

  pinMode(CLR_BUTTON_PIN, INPUT_PULLUP);
  pinMode(ROT_A, INPUT_PULLUP);  // Set encoder A pin as input
  pinMode(ROT_B, INPUT_PULLUP); 
  Serial.begin(9600);
  Serial.print("Basic Encoder Test:");
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
    prevEncoderPos = encoderPos;

    /*
    // Read the current state of the A and B pins
    currentEncoded = (digitalRead(ROT_A) << 1) | digitalRead(ROT_B);
    
    // Check if the encoder position has changed
    int change = (lastEncoded << 2) | currentEncoded;  // Combine the last and current states
    if (change == 0b1101 || change == 0b0110) {
      prevEncoderPos = encoderPos;
      encoderPos++;  // Clockwise rotation
    }
    if (change == 0b1110 || change == 0b0001) {
      prevEncoderPos = encoderPos;
      encoderPos--;  // Counter-clockwise rotation
    }

    // Update the lastEncoded state for the next loop
    lastEncoded = currentEncoded;
    
    rotApos = digitalRead(ROT_A);
    rotBpos = digitalRead(ROT_B);
    //Clockwise turn
    if(rotApos == 0 && rotBpos == 0){
      encoderPos++;
    }
    else{
      if(rotApos == 1 && rotBpos == 0){ //Counterclockwise turn
        encoderPos--;
      }
    }
    */
  
    // Print the current position of the encoder to the Serial Monitor
    if(prevEncoderPos != encoderPos){
      Serial.print("Encoder Position: ");
      Serial.println(encoderPos);
      Serial.print("Rot_A:");
      Serial.println(rotApos);
      Serial.print("Rot_B:");
      Serial.println(digitalRead(rotBpos));
    }
    delay(200);
}


