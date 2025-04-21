#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library
#include <vector>
#include <string>

//My classes
#include "BLEHandler.h"
#include "screenControl.h"

TFT_eSPI tft = TFT_eSPI();  // Create TFT object
#define SCREEN_WIDTH  420
#define SCREEN_HEIGHT  360
#define TEXT_MARGIN 10

#define CLR_BUTTON_PIN 16 //Clear button pin 
#define ROT_A 33
#define ROT_B 27
#define LED_NOTIF 21
//Settings
int fontSize = 3;     // Set screen font size
bool silentMode = false; //set hub silent mode
//Bluetooth 
BLEHandler ble; //Create a bluetooth handler object 
bool newData = false;
DataReceived dataReceived;

//Encoder 
int counter = 0; //Tracks encoders current position
int prevCounter = 0;
int aState;     //Tracks the current state of A
int bLastState; //Tracks the previous state of b
int bState;
int cwCount = 0;
int ccwCount = 0;


//LED math
float N = 1.0; //Tracks the total number of students in the class, e.g. 1 for demo
int L = 15; //Tracks number of LED pairs that should be lit (range 0-15)
int prevR = 0; //helper splice var
int currR = 0;  //helper splice var
int ratingSum = 0; //tracks the total student engagement level
float avgRating = 0; //tracks the average student engagement level 

std::vector<std::string> questions = {};  
int q_idx = 0;
int next_idx = 0;
bool encoderChange = false;
bool buttonPressed = false;

void setup() {
  //Setup Start Screen 
  tft.init();          // Initialize TFT
  tft.setRotation(1);  // Set screen rotation (0-3)
  tft.fillScreen(TFT_WHITE); // Clear screen
  tft.setTextColor(TFT_BLACK);  
  tft.setTextSize(fontSize);  

  pinMode(CLR_BUTTON_PIN, INPUT_PULLUP);    //Set clear button at input
  pinMode(ROT_A, INPUT);                  // Set encoder A pin as input
  pinMode(ROT_B, INPUT);                  //Set encoder B pin as input
  pinMode(LED_NOTIF,OUTPUT);              //Set LED at output
  Serial.begin(115200);
  Serial.print("Basic Encoder Test:");
  //Set initial Conditionns
  bLastState = digitalRead(ROT_B);        //Get initial value of rot A pin
  if(questions.size() == 0){
    drawWrappedText("No Active Questions", TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
    digitalWrite(LED_NOTIF,LOW);
  }else{
    drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
    digitalWrite(LED_NOTIF,HIGH);
  }
  ble.init();
  
}

void loop() {
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
    if(dataReceived.source == "S"){ //check if it is a setting change: data = fontSize.toString() + "/" + silentMode.toString() + "%";
      int endModeIdx = dataReceived.data.find("%");
      int endSizeIdx = dataReceived.data.find("/");
      silentMode = (std::stoi((dataReceived.data.substr(endSizeIdx+1,endModeIdx))) != 0 ); //update silent mode (steo convert to number then != does bool)
      fontSize = std::stoi(dataReceived.data.substr(0,endSizeIdx)); //Update fontsize (stoi converts string number to integer number)
      tft.setTextSize(fontSize);
    } else if(dataReceived.source == "Q"){  //String data = question + "%";
      int endQIdx = dataReceived.data.find("%");
      if(questions.size() == 0){
        questions.push_back(dataReceived.data.substr(0,endQIdx)); // Add new question to the quesiton queue 
        tft.fillScreen(TFT_WHITE);
        tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
        q_idx = 0;
        drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft); // print to screen
      } else{
        questions.push_back(dataReceived.data.substr(0,endQIdx)); // Just add new question to the quesiton queue 
      }
    } else if(dataReceived.source == "R"){ //String data = prevRating.toString() + "/" + currRating.toString() + "%";
      int endprevIdx = dataReceived.data.find("/");
      int endcurrIdx = dataReceived.data.find("%");
      prevR = std::stoi(dataReceived.data.substr(0,endprevIdx));
      currR = std::stoi(dataReceived.data.substr(endprevIdx + 1,endcurrIdx)); 
      //LED ARRAY CALCULATIONS
      ratingSum = (ratingSum - prevR) + currR;
      avgRating = ratingSum/N; //Calculate the updated average rating
      L = (int)((3*avgRating) + 0.5); //Calculate the amount of LED to light
      }
    }
  //CLEAR BUTTON
  int CLRbuttonState = digitalRead(CLR_BUTTON_PIN);  // Read the state of the button
  if (CLRbuttonState == LOW) {  // Button is pressed (because the internal pull-up resistor pulls it HIGH when not pressed)
      Serial.println("Button Pressed!");
      buttonPressed = true;
    } 

  // ROTARY ENCORDER
  aState = digitalRead(ROT_A); //Get current A state
  bState = digitalRead(ROT_B);
  if(bState != bLastState){ //Check if on rising edge
    if(bState != aState){ //Clockwise Turn
      prevCounter = counter;
      counter++;
      encoderChange = true;
      cwCount++;
    } else{ //CounterClockwise Turn
      prevCounter = counter;
      counter--;
      encoderChange = true;
      ccwCount++;
    }
    Serial.print("Encoder Position: ");
    Serial.println(counter);
    Serial.print("ccwCount: ");
    Serial.println(ccwCount);
    Serial.print("cwCount: ");
    Serial.println(cwCount);

  }
  bLastState = bState;

  //QUESTION LOGIC
  if(questions.size() != 0){ //check if question queue empty
    if(encoderChange){
      //if(counter < prevCounter){ //turned counterclockwise = go decrease index pos
      if(ccwCount >= 2){ //turned in CCW dorection= go decrease index pos
        next_idx = q_idx-1;
        if(next_idx >= 0 && next_idx < questions.size()){ //still without bounds 
          tft.fillScreen(TFT_WHITE);
          tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
          //tft.println(questions[next_idx]);
          q_idx = next_idx;
          drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
        } else{ //loop back around to last index
          tft.fillScreen(TFT_WHITE);
          tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
          q_idx = questions.size()-1;
          //tft.println(questions[q_idx]);
          drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
        }
      }
      //if(counter > prevCounter){ // turned clockwise = go increase index pos
      else{
        if(cwCount >=2){
          next_idx = q_idx+1;
          if(next_idx >= 0 && next_idx < questions.size()){ //still without bounds 
            tft.fillScreen(TFT_WHITE);
            tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
            //tft.println(questions[next_idx]);
            q_idx = next_idx;
            drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
          } else{ //loop back around to 0 index
            tft.fillScreen(TFT_WHITE);
            tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
            q_idx = 0;
            //tft.println(questions[q_idx]);
            drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
          }
        }
      }
    }
    if(buttonPressed){ //clear button was pressed
      if(q_idx >=0 && q_idx <questions.size()){
        questions.erase(questions.begin()+q_idx);
        if(q_idx >=0 && q_idx <questions.size()){ // removed questions from middle of queue 
          tft.fillScreen(TFT_WHITE);
          tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
          drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
        }
        else{
          if(questions.size() == 0){ //removed all questions from queue
            tft.fillScreen(TFT_WHITE);
            tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
            drawWrappedText("No Active Questions", TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
          }
          else{ //removed last question in queue
            q_idx--;
            if(q_idx >=0 && q_idx <questions.size()){ 
              tft.fillScreen(TFT_WHITE);
              tft.setCursor(SCREEN_WIDTH/3, SCREEN_HEIGHT/3);
              drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
            } 
          }
        }
      }
    }
  } 

  //NOTIFICATION SYSTEM
  if(questions.size() > 0){
    digitalWrite(LED_NOTIF, HIGH); //LED ON
  }
  else{
    digitalWrite(LED_NOTIF,LOW); //LED OFF
  }

  //reset variables
  newData = false;
  encoderChange = false;  
  buttonPressed = false;
  if(cwCount >= 2 || ccwCount >= 2){
    cwCount = 0;
    ccwCount = 0;
  }
}




