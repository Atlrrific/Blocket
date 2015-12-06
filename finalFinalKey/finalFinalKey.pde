/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/9588*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
import java.util.*;
Cube cube;
Cube cube2;
Cube cube3;
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
int inPin = 3;   // pushbutton connected to digital pin 7
int inPin_2 = 5;
int inPin_3 = 7;
int val = Arduino.LOW;     // variable to store the read value
int val_2 = Arduino.LOW;
int val_3 = Arduino.LOW;


int ledCnt = 0;
float rY = 0;
float rX = 0;
float scaler=1;
int a = 300;
color c = color(255);
float lightX = 0;
float lightY = 0;
float lightZ = 1;
float m=0;
boolean faceMoved = false;
int startVal = 100;
int[] faceVal = new int[6];
boolean[] faceOccupy = new  boolean[6];
Deque<Cube> cubesNotUsed = new ArrayDeque<Cube>();
Queue<Cube> cubesInUse = new LinkedList<Cube>();



void setup() {
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  //arduino.pinMode(ledPin, Arduino.OUTPUT);
  
  arduino.pinMode(inPin, Arduino.INPUT);   
  arduino.pinMode(inPin_2, Arduino.INPUT);
  arduino.pinMode(inPin_3, Arduino.INPUT);
  
  size(500,500,P3D);

  frameRate(25);
  noStroke();
  cube = new Cube(0,0,0);
  cube2 = new Cube(100,0,-25);
  cube3 = new Cube(-100,0,-25);
  cubesNotUsed.push(cube2);
  cubesNotUsed.push(cube3);
  rectMode(CENTER);
}

void draw() {

  background(0);
  fill(c,a);

  //Controlls up and down rotation
  if(keyPressed) {
    if (key == CODED) {
      if (keyCode == DOWN) {
        rY =rY;
        rX-=.1;
      } 
      else {
        rX = rX;
      }
      if (keyCode == UP) {
        rY =rY;
        rX+=.1;
      } 
      else {
        rX = rX;
      }      
    }
  }

  //Controlls side-to-side rotation
  if(keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        rY-=.1;
        rX = rX;
      } 
      else {
        rY = rY;
      }
      if (keyCode == RIGHT) {
        rY+=.1;
        rX = rX;
      } 
      else {
        rY = rY;
      }    
    }

    //Zoom In
    if(key == '=' || key =='+') {
      scaler+=.05;
      scaler = constrain(scaler,1,5.0);
      m +=.5;
      m = constrain(m, 0, 40);
    }

    //Zoom Out
    if(key == '-' || key =='_') {
      scaler-=.05;
      scaler = constrain(scaler,1,2.0);
      m -=.5;
      m = constrain(m, 0, 40);
    }
    //Make more Transparant  
    if(key == '[') {
      a-=3;
      a = constrain(a,0,255);
    }

    //Make more Opaque
    if(key == ']') {
      a+=3;
      a = constrain(a,0,255);
    }

    //Changes color to yellow
    if(key == '1') {
      c = color(255,255,0);
    }

    //Changes color to green
    if(key == '2') {
      c = color(0,255,0);
    }
    //Changes color to red
    if(key == '3') {
      c = color(255,0,0);
    }
    //Changes color to blue
    if(key == '4'||(val_3==1)) {
      c = color(0,0,255);
    }
    //Resets all settings
    if(key == '0' ) {
      c = color(255);
      lightX = 0;
      lightY = 0;
      scaler = 1;
      rX = 0;
      rY = 0;
      a = 255;
      m = 0;
    }
  }
  
  //if((val_3==1)) {
  //    c = color(0,0,255);
      
  //    //cube2.create(-25-m,-25-m,0+m);//usrf
  //    //cube2.create(-25-m,-25-m,-50-m);//usrb
  //    //cube2.create(25+m,-25-m,0+m);//uslf
  //    //cube2.create(25+m,-25-m,-50-m);//uslb
  //    //cube2.create(25+m,25+m,0+m);//dslf
  //    //cube2.create(25+m,25+m,-50-m);//dslb
  //    //cube2.create(-25-m,25+m,0+m);//dsrf
  //    //cube2.create(-25-m,25+m,-50-m);//dsrb
  //    //fill(255,126,0,a);
  //    //cube2.create(0,0,-25);//csc
  // }else{
  //   //c = color(255);
  // }

  
  ambientLight(102, 102, 102);
  directionalLight(126, 126, 126, -lightX, -lightY, -1);

  pushMatrix();
  translate(width/2, height/2);
  scale(scaler);
  rotateY(rY);
  rotateX(rX);

  //cube2.create(-25+m,-25-m,0+m);//usrf
  //cube2.create(-25+m,-25-m,-50-m);//usrb
  //cube2.create(25+m,-25-m,0+m);//uslf
  //cube2.create(25+m,-25-m,-50-m);//uslb
  //cube2.create(25+m,25+m,0+m);//dslf
  //cube2.create(25+m,25+m,-50-m);//dslb
  //cube2.create(-25-m,25+m,0+m);//dsrf
  //cube2.create(-25-m,25+m,-50-m);//dsrb
  //csc
  //When button press we add the cube to the appropiate position. 
  //Else we set it to the resset position. 
  
  if(val == 1){
     Cube temp; 
    if(cubesNotUsed.size()==0){
      temp = cubesInUse.remove();
    }else{
      temp = cubesNotUsed.pop();
    }
    
    
    cubesInUse.add(temp);

   
  }
  
  
  if((val_3==1)) {
    faceMoved = true;
    //cube2.create(50,0,-25);
  }else{
    faceMoved=false;
    startVal = 100;
   //cube2.create(100,0,-25); 
  }
  
  if(faceMoved){
    cube2.moveToFace(4); 
    if(startVal !=50){
      //delay(1);
      startVal-=10;
    }
  }
  else{
   cube2.create(100,0,-25); 
  }
  //cube.create(-25-m,-25-m,0+m);//usrf
  //cube.create(-25-m,-25-m,-50-m);//usrb
  //cube.create(25+m,-25-m,0+m);//uslf
  //cube.create(25+m,-25-m,-50-m);//uslb
  //cube.create(25+m,25+m,0+m);//dslf
  //cube.create(25+m,25+m,-50-m);//dslb
  //cube.create(-25-m,25+m,0+m);//dsrf
  //cube.create(-25-m,25+m,-50-m);//dsrb
  fill(255,126,0,a);
  cube.create(0,0,-25);//csc
  
  
  val = arduino.digitalRead(inPin);   // read the input pin
  val_2 = arduino.digitalRead(inPin_2);
  val_3 = arduino.digitalRead(inPin_3);
  
  println(val,val_2,val_3);
  
  popMatrix();
  
  

}