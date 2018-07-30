int echo = 2;
int trigger = 3;
int echo2 = 6;
int trigger2 = 7;
double velocidadSonido = 0.0343;
double v = 0.0;
double r = 0.0;

void setup() {
  Serial.begin(9600);
  pinMode(echo, INPUT);  //echo
  pinMode(trigger, OUTPUT); //trigger
  pinMode(echo2, INPUT);
  pinMode(trigger2, OUTPUT);
}

void loop() {
  digitalWrite(trigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigger, LOW);

  //Serial.print("distancia izquierda: ");
  //se divide entre dos porque el pulseIn retorna el tiempo de ida y vuelta
  //Serial.print( (velocidadSonido * pulseIn(echo, HIGH)) / 2);
  
  //Serial.println(" cm");
  v = velocidadSonido * pulseIn(echo, HIGH) / 2;

  digitalWrite(trigger2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigger2, LOW);

  //Serial.print("distancia derecha: ");
  //se divide entre dos porque el pulseIn retorna el tiempo de ida y vuelta
  //Serial.print( (velocidadSonido * pulseIn(echo2, HIGH)) / 2);
  //Serial.println(" cm");
  r = velocidadSonido * pulseIn(echo2, HIGH) / 2;
  Serial.print(v);
  Serial.print(" ");
  Serial.println(r);
  delay(1000);
}
