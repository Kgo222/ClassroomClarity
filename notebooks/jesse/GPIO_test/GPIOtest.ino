#define LED_NOTIF 3
#define CLEAR 6
#define SCREEN_LED 21

int question_size = 3;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED_NOTIF,OUTPUT);              //Set LED at output
  pinMode(CLEAR,INPUT_PULLUP);
  pinMode(SCREEN_LED, OUTPUT);
  Serial.begin(9600);
  // digitalWrite(LED_NOTIF,HIGH);
  Serial.println("INITIALIZING...");
  digitalWrite(SCREEN_LED, HIGH);
}

void loop() {
  int CLRbuttonState = digitalRead(CLEAR);  // Read the state of the button
  if (CLRbuttonState == LOW) {  // Button is pressed (because the internal pull-up resistor pulls it HIGH when not pressed)
      Serial.println("Button Pressed!");
      question_size = question_size - 1;
      delay(2000);
      Serial.println("question_size = ");
      Serial.println(question_size);
    }
  
  if (question_size > 0) {
    digitalWrite(LED_NOTIF, HIGH);
  }
  else {
    digitalWrite(LED_NOTIF, LOW);
  }
  

  // Turn LED on and off every 1s
  // delay(8000);
  // digitalWrite(LED_NOTIF,LOW);
  // Serial.println("LED OFF");
  // delay(8000);
  // digitalWrite(LED_NOTIF,HIGH);
  // Serial.println("LED ON");
}
