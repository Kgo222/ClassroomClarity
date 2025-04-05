#define LED_NOTIF 3


void setup() {
  // put your setup code here, to run once:
  pinMode(LED_NOTIF,OUTPUT);              //Set LED at output
  Serial.begin(9600);
  digitalWrite(LED_NOTIF,HIGH);
}

void loop() {
  // put your main code here, to run repeatedly:

}
