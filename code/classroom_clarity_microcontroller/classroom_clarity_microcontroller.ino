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
#define TEXT_MARGIN 0
#define TWO_MINUTES_MS 120000

#define CLR_BUTTON_PIN 16 //6 //Clear button pin  16
#define ROT_A 4 // 33
#define ROT_B 5 //27
#define LED_NOTIF 3 //21
#define MOTOR 7

#define LED_R5 35
#define LED_R4 36
#define LED_R3 37
#define LED_R2 38
#define LED_R1 39

#define LED_Y5 40
#define LED_Y4 41
#define LED_Y3 42
#define LED_Y2 2
#define LED_Y1 1

#define LED_G5 8
#define LED_G4 18
#define LED_G3 17
#define LED_G2 16
#define LED_G1 15

//Settings
int fontSize = 2;     // Set screen font size
bool silentMode = false; //set hub silent mode

//Bluetooth 
BLEHandler ble; //Create a bluetooth handler object 
bool newData = false;
DataReceived dataReceived;
//Password
int instructor_password;  //holds the randomly generated instructor password
int student_password;   // holds the randomly generated student password
std::string s_password_printout;
std::string i_password_printout;

//Encoder 
int counter = 0; //Tracks encoders current position
int prevCounter = 0;
int aState;     //Tracks the current state of A
int bLastState; //Tracks the previous state of b
int bState;
int cwCount = 0;
int ccwCount = 0;

//Motor
int previousActivationTime = 0;
int currentActivationTime = 0;

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
  pinMode(MOTOR,OUTPUT);  

  pinMode(LED_R1,OUTPUT);              //Set LED at output
  pinMode(LED_R2,OUTPUT);              //Set LED at output
  pinMode(LED_R3,OUTPUT);              //Set LED at output
  pinMode(LED_R4,OUTPUT);              //Set LED at output
  pinMode(LED_R5,OUTPUT);              //Set LED at output

  pinMode(LED_Y1,OUTPUT);              //Set LED at output
  pinMode(LED_Y2,OUTPUT);              //Set LED at output
  pinMode(LED_Y3,OUTPUT);              //Set LED at output
  pinMode(LED_Y4,OUTPUT);              //Set LED at output
  pinMode(LED_Y5,OUTPUT);              //Set LED at output

  pinMode(LED_G1,OUTPUT);              //Set LED at output
  pinMode(LED_G2,OUTPUT);              //Set LED at output
  pinMode(LED_G3,OUTPUT);              //Set LED at output
  pinMode(LED_G4,OUTPUT);              //Set LED at output
  pinMode(LED_G5,OUTPUT);              //Set LED at output

  Serial.begin(115200);
  Serial.print("Basic Encoder Test:");

  //Set initial Conditionns
  instructor_password = random(100000, 999999);  // Random 6 digit number
  student_password = random(100000, 999999);  // Random 6 digit number
  s_password_printout = "student code: " + std::to_string(student_password);
  i_password_printout = "instructor code: " + std::to_string(instructor_password);
  bLastState = digitalRead(ROT_B);        //Get initial value of rot A pin
  if(questions.size() == 0){
    drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
    drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
    drawWrappedText("No Active Questions", TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
    digitalWrite(LED_NOTIF,LOW);
  }else{
    drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
    drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
    drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
    digitalWrite(LED_NOTIF,HIGH);
    if(silentMode == false){
      digitalWrite(MOTOR, HIGH);
      delay(300);
      digitalWrite(MOTOR,LOW);
      previousActivationTime = millis();
    }
  }
  //Engagement Level
  setEngagementLevel(L);

  ble.init(); //initialize bluetooth
  Serial.println("finish setup");
}

void loop() {
  Serial.println("loop start");
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
        if(std::stoi(entered_password) == instructor_password){
          Serial.println("Instructor is authenticated, access granted.");
          ble.notifyESP("1"); //tell app the password was accepted
        }else{
          Serial.println("Incorrect Instructor Password");
          ble.notifyESP("2"); //tell app the password was denied
        }
      }else if (typeP == "S") { // check if the password inputted was for student
        if(std::stoi(entered_password) == student_password){
          Serial.println("Student is authenticated, access granted.");
          ble.notifyESP("3"); //tell app password was accepted
        }else{
          Serial.println("Incorrect Student Password");
          ble.notifyESP("4"); //tell app password was denied
        }
      }
    } else if(dataReceived.source == "S"){ //check if it is a setting change: data = fontSize.toString() + "/" + silentMode.toString() + "%";
      int endModeIdx = dataReceived.data.find("%");
      int endSizeIdx = dataReceived.data.find("/");
      if(dataReceived.data.substr(endSizeIdx+1,endModeIdx-endSizeIdx-1) == "true"){ //update silentMode based on recieved message
        silentMode = true;
      } else{
        silentMode = false;
      }
      int newFontSize = std::stoi(dataReceived.data.substr(0,endSizeIdx)); // converts string number to integer number
      if(fontSize != newFontSize){
        fontSize = newFontSize; //Update fontSize
        tft.setTextSize(fontSize);
        tft.fillScreen(TFT_WHITE); //Do print screen with new font size
        drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
        drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
        if(questions.size() == 0){
          drawWrappedText("No Active Questions", TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);     
        }else {
          drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);     
        }
      }
    } else if(dataReceived.source == "Q"){  //String data = "name/question%";
      int endQIdx = dataReceived.data.find("%");
      if(questions.size() == 0){
        questions.push_back(dataReceived.data.substr(0,endQIdx)); // Add new question to the quesiton queue 
        tft.fillScreen(TFT_WHITE);
        drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
        drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
        q_idx = 0;
        drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);     
           
        if(silentMode == false){ // Check if activate motor 
          digitalWrite(MOTOR, HIGH);
          delay(300);
          digitalWrite(MOTOR,LOW);
          previousActivationTime = millis();
        }
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
      setEngagementLevel(L);
      }
    }
  //CLEAR BUTTON
  int CLRbuttonState = digitalRead(CLR_BUTTON_PIN);  // Read the state of the button
  if (CLRbuttonState == LOW) {  // Button is pressed (because the internal pull-up resistor pulls it HIGH when not pressed)
      Serial.println("Clear Button Pressed!");
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
          drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
          drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
          //tft.println(questions[next_idx]);
          q_idx = next_idx;
          drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
        } else{ //loop back around to last index
          tft.fillScreen(TFT_WHITE);
          drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
          drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
          q_idx = questions.size()-1;
          //tft.println(questions[q_idx]);
          drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
        }
      }
      //if(counter > prevCounter){ // turned clockwise = go increase index pos
      else{
        if(cwCount >=2){
          next_idx = q_idx+1;
          if(next_idx >= 0 && next_idx < questions.size()){ //still without bounds 
            tft.fillScreen(TFT_WHITE);
            drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
            drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
            //tft.println(questions[next_idx]);
            q_idx = next_idx;
            drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
          } else{ //loop back around to 0 index
            tft.fillScreen(TFT_WHITE);
            drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
            drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
            q_idx = 0;
            //tft.println(questions[q_idx]);
            drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
          }
        }
      }
    }
    if(buttonPressed){ //clear button was pressed
      if(q_idx >=0 && q_idx <questions.size()){
        questions.erase(questions.begin()+q_idx);
        if(q_idx >=0 && q_idx <questions.size()){ // removed questions from middle of queue 
          tft.fillScreen(TFT_WHITE);
          drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
          drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
          drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
        }
        else{
          if(questions.size() == 0){ //removed all questions from queue
            tft.fillScreen(TFT_WHITE);
            drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
            drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
            drawWrappedText("No Active Questions", TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
          }
          else{ //removed last question in queue
            q_idx--;
            if(q_idx >=0 && q_idx <questions.size()){ 
              tft.fillScreen(TFT_WHITE);
              drawWrappedText(s_password_printout, 0,0, SCREEN_WIDTH, &tft);
              drawWrappedText(i_password_printout, 0,tft.fontHeight()+4, SCREEN_WIDTH, &tft);
              drawWrappedText(questionFormat(questions[q_idx]), TEXT_MARGIN, 2*tft.fontHeight()+15, SCREEN_WIDTH-TEXT_MARGIN, &tft);
            } 
          }
        }
      }
    }
    currentActivationTime = millis();
    if(silentMode == false && currentActivationTime-previousActivationTime >= TWO_MINUTES_MS){
      digitalWrite(MOTOR,HIGH);
      delay(300); //let it run for 300ms = 0.3s
      digitalWrite(MOTOR,LOW);
      previousActivationTime = millis();
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


std::string questionFormat(std::string name_question){
  Serial.print("Input to questionFormat:");
  Serial.println(name_question.c_str());
  int midQIdx = name_question.find("/");
  std::string name = name_question.substr(0,midQIdx);
  std::string question = name_question.substr(midQIdx + 1);
  std::string outputFormat = name + ": " + question;
  Serial.print("OutputFormat:");
  Serial.println(outputFormat.c_str());
  return outputFormat;
} 

void setEngagementLevel(int L){
  if(L==1){
    digitalWrite(LED_R1,HIGH);
    digitalWrite(LED_R2,LOW);
    digitalWrite(LED_R3,LOW);
    digitalWrite(LED_R4,LOW);
    digitalWrite(LED_R5,LOW);
    digitalWrite(LED_Y1,LOW);
    digitalWrite(LED_Y2,LOW);
    digitalWrite(LED_Y3,LOW);
    digitalWrite(LED_Y4,LOW);
    digitalWrite(LED_Y5,LOW);
    digitalWrite(LED_G1,LOW);
    digitalWrite(LED_G2,LOW);
    digitalWrite(LED_G3,LOW);
    digitalWrite(LED_G4,LOW);
    digitalWrite(LED_G5,LOW); 
  }else if(L==2){
    digitalWrite(LED_R1,HIGH);
    digitalWrite(LED_R2,HIGH);
    digitalWrite(LED_R3,LOW);
    digitalWrite(LED_R4,LOW);
    digitalWrite(LED_R5,LOW);
    digitalWrite(LED_Y1,LOW);
    digitalWrite(LED_Y2,LOW);
    digitalWrite(LED_Y3,LOW);
    digitalWrite(LED_Y4,LOW);
    digitalWrite(LED_Y5,LOW);
    digitalWrite(LED_G1,LOW);
    digitalWrite(LED_G2,LOW);
    digitalWrite(LED_G3,LOW);
    digitalWrite(LED_G4,LOW);
    digitalWrite(LED_G5,LOW);
  }else if(L==3){
    digitalWrite(LED_R1,HIGH);
    digitalWrite(LED_R2,HIGH);
    digitalWrite(LED_R3,HIGH);
    digitalWrite(LED_R4,LOW);
    digitalWrite(LED_R5,LOW);
    digitalWrite(LED_Y1,LOW);
    digitalWrite(LED_Y2,LOW);
    digitalWrite(LED_Y3,LOW);
    digitalWrite(LED_Y4,LOW);
    digitalWrite(LED_Y5,LOW);
    digitalWrite(LED_G1,LOW);
    digitalWrite(LED_G2,LOW);
    digitalWrite(LED_G3,LOW);
    digitalWrite(LED_G4,LOW);
    digitalWrite(LED_G5,LOW);
  }else if(L==4){
    digitalWrite(LED_R1,HIGH);
    digitalWrite(LED_R2,HIGH);
    digitalWrite(LED_R3,HIGH);
    digitalWrite(LED_R4,HIGH);
    digitalWrite(LED_R5,LOW);
    digitalWrite(LED_Y1,LOW);
    digitalWrite(LED_Y2,LOW);
    digitalWrite(LED_Y3,LOW);
    digitalWrite(LED_Y4,LOW);
    digitalWrite(LED_Y5,LOW);
    digitalWrite(LED_G1,LOW);
    digitalWrite(LED_G2,LOW);
    digitalWrite(LED_G3,LOW);
    digitalWrite(LED_G4,LOW);
    digitalWrite(LED_G5,LOW);
  }else if(L==5){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,LOW);
      digitalWrite(LED_Y2,LOW);
      digitalWrite(LED_Y3,LOW);
      digitalWrite(LED_Y4,LOW);
      digitalWrite(LED_Y5,LOW);
      digitalWrite(LED_G1,LOW);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==6){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,LOW);
      digitalWrite(LED_Y3,LOW);
      digitalWrite(LED_Y4,LOW);
      digitalWrite(LED_Y5,LOW);
      digitalWrite(LED_G1,LOW);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==7){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,LOW);
      digitalWrite(LED_Y4,LOW);
      digitalWrite(LED_Y5,LOW);
      digitalWrite(LED_G1,LOW);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==8){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,LOW);
      digitalWrite(LED_Y5,LOW);
      digitalWrite(LED_G1,LOW);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==9){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,LOW);
      digitalWrite(LED_G1,LOW);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==10){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,HIGH);
      digitalWrite(LED_G1,LOW);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==11){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,HIGH);
      digitalWrite(LED_G1,HIGH);
      digitalWrite(LED_G2,LOW);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==12){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,HIGH);
      digitalWrite(LED_G1,HIGH);
      digitalWrite(LED_G2,HIGH);
      digitalWrite(LED_G3,LOW);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==13){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,HIGH);
      digitalWrite(LED_G1,HIGH);
      digitalWrite(LED_G2,HIGH);
      digitalWrite(LED_G3,HIGH);
      digitalWrite(LED_G4,LOW);
      digitalWrite(LED_G5,LOW);
  }else if(L==14){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,HIGH);
      digitalWrite(LED_G1,HIGH);
      digitalWrite(LED_G2,HIGH);
      digitalWrite(LED_G3,HIGH);
      digitalWrite(LED_G4,HIGH);
      digitalWrite(LED_G5,LOW);
  }else if(L==15){
      digitalWrite(LED_R1,HIGH);
      digitalWrite(LED_R2,HIGH);
      digitalWrite(LED_R3,HIGH);
      digitalWrite(LED_R4,HIGH);
      digitalWrite(LED_R5,HIGH);
      digitalWrite(LED_Y1,HIGH);
      digitalWrite(LED_Y2,HIGH);
      digitalWrite(LED_Y3,HIGH);
      digitalWrite(LED_Y4,HIGH);
      digitalWrite(LED_Y5,HIGH);
      digitalWrite(LED_G1,HIGH);
      digitalWrite(LED_G2,HIGH);
      digitalWrite(LED_G3,HIGH);
      digitalWrite(LED_G4,HIGH);
      digitalWrite(LED_G5,HIGH);
  }
  
}
