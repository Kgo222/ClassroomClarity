
#define RED1 39
#define RED2 38
#define RED3 37
#define RED4 36
#define RED5 35 
#define button 6

int button_cycle = 0;

void setup() {
  // DECLARE OUTPUTS
  pinMode(RED1, OUTPUT);
  pinMode(RED2, OUTPUT);
  pinMode(RED3, OUTPUT);
  pinMode(RED4, OUTPUT);
  pinMode(RED5, OUTPUT);

  // DECLARE INPUTS
  pinMode(button, INPUT);

  // INITIALIZE LED OUTPUTS
  digitalWrite(RED1, LOW);
  digitalWrite(RED2, LOW);
  digitalWrite(RED3, LOW);
  digitalWrite(RED4, LOW);
  digitalWrite(RED5, LOW);
}



void loop() {
int button_state = digitalRead(button);
  if (button_state = LOW) {

    if (button_cycle = 0) {
      digitalWrite(RED1, LOW);
      digitalWrite(RED2, LOW);
      digitalWrite(RED3, LOW);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
      button_cycle = 1;
    }
    else if (button_cycle = 1) {
      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, LOW);
      digitalWrite(RED3, LOW);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
      button_cycle = 2;
    }
    else if (button_cycle = 2) {
      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, LOW);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
      button_cycle = 3;
    }
    else if (button_cycle = 3) {
      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, HIGH);
      digitalWrite(RED4, LOW);
      digitalWrite(RED5, LOW);
      button_cycle = 4;
    }
    else if (button_cycle = 4) {
      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, HIGH);
      digitalWrite(RED4, HIGH);
      digitalWrite(RED5, LOW);
      button_cycle = 5;
    }
    else if (button_cycle = 5) {
      digitalWrite(RED1, HIGH);
      digitalWrite(RED2, HIGH);
      digitalWrite(RED3, HIGH);
      digitalWrite(RED4, HIGH);
      digitalWrite(RED5, HIGH);
      button_cycle = 4;
    }
  }
  else {
    digitalWrite(RED1, LOW);
    digitalWrite(RED2, LOW);
    digitalWrite(RED3, LOW);
    digitalWrite(RED4, LOW);
    digitalWrite(RED5, LOW);
  }


}
