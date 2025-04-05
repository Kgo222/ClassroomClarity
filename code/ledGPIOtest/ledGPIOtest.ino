#define LED_NOTIF 3


void setup() {
  // put your setup code here, to run once:
  pinMode(LED_NOTIF,OUTPUT);              //Set LED at output
  Serial.begin(9600);
  digitalWrite(LED_NOTIF,HIGH);
  Serial.println("LED ON");
}

void loop() {
  // Turn LED on and off every 1s
  delay(1000);
  digitalWrite(LED_NOTIF,LOW);
  Serial.println("LED OFF");
  delay(1000);
  digitalWrite(LED_NOTIF,HIGH);
  Serial.println("LED ON");
}
