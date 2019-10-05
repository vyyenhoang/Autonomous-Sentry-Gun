//*************************************************************************************** /
//*    Title: Autonomous Sentry Turret - tracking and shoot the target automatically
//*    Author: Vy Hoang
//*    Date: 2018
//*************************************************************************************** /

#include <Servo.h>  //Used to control the Pan/Tilt Servos

char ychannel = 0; //Servo ID for the y-axis servo
char xchannel = 1; //Servo ID for the x-axis servo
char fchannel = 2; //Servo ID for the trigger servo

Servo y; //Name x-axis servo is y
Servo x;  //Name x-axis servo is x
Servo f; //Name trigger servo is f

char ch = 0; //ch hold data from the port
int led = 12; // The red led is attached to pin 12.


void setup() {

  y.attach(7);  //The y-axis servo is attached to pin 7.
  x.attach (8); //The x-axis servo is attached to pin 8.
  f.attach(A3); //The trigger servo is attached to pin 0.

  y.write(90);  //Set 90 degree innitially.
  x.write(90);  //Set 90 degree innitially.
  f.write (0);  // Set 0 degre innitially.

  pinMode (led, OUTPUT); //Output led
 

  Serial.begin(9600);  //Set up a serial connection for 57600 bps.
} //end of void setup ()

void loop() {

  digitalWrite (led, LOW); //Turn Led off when there is no signal of FaceDection from Processing
 
  while (Serial.available() <= 0); //wait for the data to be recieved by andruino

  ch = Serial.read();  //read data (char type) and store it om

  if (ch == ychannel) { // Check if data = servo ID 0 for y-axis servo
    while (Serial.available() <= 0); //Wait for the data from the serial port.
    y.write(Serial.read());  // then y-axis servo set the position according to the data (ch) in the processing
  } //end if

  else if (ch == xchannel) { //Check if data = servo ID 1 for x-axis servo
    while (Serial.available() <= 0); //Wait for the data from the serial port.
    x.write(Serial.read());   //then y-axis servo set the position according to the data (ch) in the processing
  } // end if

  else if (ch == fchannel) { //if data= servo ID 2 for trigger servo
    while (Serial.available() <= 0); //Wait for the data from the serial port.
    f.write(Serial.read());   //then y-axis servo set the position according to the data (ch) in the processing
  
  } // end if

  digitalWrite (led, HIGH); //Turn Led off when there is signal of FaceDection from Processing
  delay (1000);

} // end of void loop ()

//If the character is not the pan or tilt or trigger servo ID, it is ignored.
