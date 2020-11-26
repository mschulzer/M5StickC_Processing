import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;

String data="";
float roll = 0.0, pitch = 0.0;
PShape s;

void setup() {
  size (960, 640, P3D);
  myPort = new Serial(this, "/dev/tty.usbserial-914E16968B", 115200); // Ændr til den rigtige port (!)
  myPort.bufferUntil('\n');
  

  ambientLight(153, 102, 0);
  s = loadShape("M5StickC.obj");
  s.setFill(color(204, 102, 0));
  frameRate(30.0);
}

void draw() {
  translate(width/2, height/2, 0);
  background(33);
  textSize(22);
  
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch), -100, 265);

  ambientLight(128,128,128);
  directionalLight(153, 153, 153, .5, 0, -1);

  rotateX(radians(roll));
  rotateZ(radians(-pitch));
  
  textSize(30);
  
  // Tegn M5StickC
  //fill(204, 102, 0);
  //box (386, 80, 170);
  
  // Brug 3D-model af M5StickC
  rotate(180*PI/180);
  pushMatrix();
  scale(5);
  ambient(255,0,0);
  shape(s, 0, 0);
  popMatrix();
  
  // Tegn skærm
  pushMatrix();
  translate(43, 60, 0);
  ambient(0,0,0);
  noStroke();
  box (110, 10, 56);
  popMatrix();
}

void serialEvent (Serial myPort) { 

  data = myPort.readStringUntil('\n');

  if (data != null) {
    data = trim(data);

    String items[] = split(data, ',');
    if (items.length > 1) {

      pitch = (float(items[0])*-1);
      roll = float(items[1]);
    }
  }
}
