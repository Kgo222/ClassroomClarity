#include <TFT_eSPI.h>  // Include TFT library
#include <SPI.h>       // Include SPI library
#include <vector>
//My classes
#include <screenControl.h>

TFT_eSPI tft = TFT_eSPI();  // Create TFT object
#define SCREEN_WIDTH  420
#define SCREEN_HEIGHT  360
#define TEXT_MARGIN 10

#define CLR_BUTTON_PIN 16 //Clear button pin 
#define ROT_A 33
#define ROT_B 27
#define LED_NOTIF 21

int counter = 0; //Tracks encoders current position
int prevCounter = 0;
int aState;     //Tracks the current state of A
int aLastState; //Tracks the previous state of A
int bState;

int cwCount = 0;
int ccwCount = 0;

std::vector<String> questions = {"Why is the voltage assumed to be 5V?", "How does the diode help rectify AC?", "Why do we use Fourier Transform in signal processing?"};  
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
  tft.setTextSize(3);  

  pinMode(CLR_BUTTON_PIN, INPUT_PULLUP);    //Set clear button at input
  pinMode(ROT_A, INPUT);                  // Set encoder A pin as input
  pinMode(ROT_B, INPUT);                  //Set encoder B pin as input
  pinMode(LED_NOTIF,OUTPUT);              //Set LED at output
  Serial.begin(9600);
  Serial.print("Basic Encoder Test:");
  //Set initial Conditionns
  aLastState = digitalRead(ROT_A);        //Get initial value of rot A pin
  if(questions.size() == 0){
    drawWrappedText("No Active Questions", TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
    digitalWrite(LED_NOTIF,LOW);
  }else{
    drawWrappedText(questions[q_idx], TEXT_MARGIN, SCREEN_HEIGHT/3, SCREEN_WIDTH-TEXT_MARGIN, &tft);
    digitalWrite(LED_NOTIF,HIGH);
  }
  
}

void loop() {
    //CLEAR BUTTON
  int CLRbuttonState = digitalRead(CLR_BUTTON_PIN);  // Read the state of the button
  if (CLRbuttonState == LOW) {  // Button is pressed (because the internal pull-up resistor pulls it HIGH when not pressed)
      Serial.println("Button Pressed!");
      buttonPressed = true;
    } 

    // ROTARY ENCORDER
    aState = digitalRead(ROT_A); //Get current A state
    bState = digitalRead(ROT_B);
    if(aState != aLastState){ //Check if on rising edge
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
    aLastState = aState;

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

    encoderChange = false; //reset variable 
    buttonPressed = false;
    if(cwCount >= 2 || ccwCount >= 2){
      cwCount = 0;
      ccwCount = 0;
    }
}




