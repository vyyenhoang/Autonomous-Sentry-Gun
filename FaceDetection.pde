import processing.video.*;
//import codeanticode.gsvideo.*;
import gab.opencv.*;
import java.awt.Rectangle;
import processing.serial.*;


OpenCV opencv;
Rectangle[] faces;
Capture cam;

int fps =12;

char posx = 90;
char posy = 90;

char xchannel = 1;
char ychannel =0;


int targetx;
int targety;

int threshold =0;
int thresholdleft;
int thresholdright;
int step = 1;
Serial port;




void setup() {
  opencv = new OpenCV(this, 640,480);
  size(640, 480);
  cam = new Capture(this, 640,480);

  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
  cam.start();
  
  println (Serial.list ());
  port = new Serial(this, Serial.list()[0], 57600);
  port.write (90+ "a");
  delay (1000);
  
  port.write(ychannel);
  port.write(posy);
  port.write(posx);
  port.write(xchannel);
  
}

void draw() { 
  opencv.loadImage(cam); 
  faces = opencv.detect(); 
  image(cam, 0, 0); 
 
  if ((faces!=null) && (faces.length !=0)) { 
    for (int i=0; i< faces.length; i++) { 
      
      targetx = faces[0].x + (faces[0].width/2);
      targety = faces[0].y + (faces[0].height/2);
      stroke(255,255,255);
      strokeWeight(1);
      
      thresholdleft = (640/2) - threshold;
      thresholdright = (640/2) + threshold;
      
      
    
      
      stroke (0,255,0);
      strokeWeight(3);
      
      line (thresholdleft, 0, thresholdleft, 480);
      line (thresholdright, 0, thresholdright, 480);
      
      noFill(); 
      stroke(255, 255, 0); 
      strokeWeight(10); 
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      
      
      //Handle Rotation
      
       if(targety < 220)
      {
        if(posy >= 5)posx -= step;
      }
      
      if (targety > 260)
      {
        if(posy <= 175)posx +=step;
      }
      
      //////////////////////////////
      
      
      if(targetx < thresholdleft)
      {
        if(posx >= 5)posx += step;
      }
      
      if (targetx > thresholdright)
      {
        if(posx <= 175)posx -=step;
      }
      
    //  if ((targetx >= thresholdleft) && (targetx <= thresholdright))
    //  {
    //    port.write ("f");
    //    noFill();
    //    strokeWeight (5 );
    //    stroke (255,0 ,0);
    //    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    //}
 //Update the servo positions by sending the serial command to the Arduino.
  port.write(ychannel);      //Send the tilt servo ID
  port.write(posy); //Send the updated tilt position.
  port.write(xchannel);        //Send the Pan servo ID
  port.write(posx);  //Send the updated pan position.
  delay(1);  

}
  }
  
  //port.write (pos + "a");
  //delay (40);
  
  
  if (faces.length<=0) { 
    textAlign(CENTER); 
    fill(255, 0, 0); 
    textSize(56); 
    println("no faces");
    text("UNDETECTED", 200, 100);
  }
}
 
  
 
void captureEvent(Capture cam) { 
  cam.read();
}
