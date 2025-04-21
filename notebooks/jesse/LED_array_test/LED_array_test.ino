
#define RED1 39
#define RED2 38
#define RED3 37
#define RED4 36
#define RED5 35 
#define button 6
#define notif 3

int button_cycle = 0;

void setup() {
  // DECLARE OUTPUTS
  pinMode(RED1, OUTPUT);
  pinMode(RED2, OUTPUT);
  pinMode(RED3, OUTPUT);
  pinMode(RED4, OUTPUT);
  pinMode(RED5, OUTPUT);
  pinMode(notif, OUTPUT);

  // DECLARE INPUTS
  pinMode(button, INPUT);

  // INITIALIZE LED OUTPUTS
  digitalWrite(RED1, LOW);
  digitalWrite(RED2, LOW);
  digitalWrite(RED3, LOW);
  digitalWrite(RED4, LOW);
  digitalWrite(RED5, LOW);
  digitalWrite(notif, LOW);
}



void loop() {

      digitalWrite(RED1, LOW);
      digitalWrite(RED2, LOW);
      digitalWrite(RED3, LOW);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
  
  delay(500);

      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, LOW);
      digitalWrite(RED3, LOW);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);

  delay(500);

      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, LOW);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
  
  delay(500);

      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, HIGH);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
   
  delay(500);

      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, HIGH);
      digitalWrite(RED4, HIGH);
      digitalWrite(RED5, LOW);

    delay(500);

      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, HIGH);
      digitalWrite(RED4, HIGH);
      digitalWrite(RED5, HIGH);
 
  delay(500);

    digitalWrite(RED1, LOW);
    digitalWrite(RED2, LOW);
    digitalWrite(RED3, LOW);
    digitalWrite(RED4, LOW);
    digitalWrite(RED5, LOW);

  delay(500);

  digitalWrite(notif, HIGH);
  delay(2000);
  digitalWrite(notif, LOW);

}
