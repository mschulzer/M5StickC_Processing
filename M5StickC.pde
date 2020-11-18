import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;

String data="";
float roll, pitch;
PShape s;

void setup() {
  size (960, 640, P3D);
  myPort = new Serial(this, "/dev/tty.usbserial-35562B968B", 115200);
  myPort.bufferUntil('\n');
  
  s = loadShape("M5StickC.obj");
  s.setFill(color(204, 102, 0));

}
void draw() {
  translate(width/2, height/2, 0);
  background(33);
  textSize(22);
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch), -100, 265);
  
  rotateX(radians(roll));
  rotateZ(radians(-pitch));
  
  textSize(30);
  
  // Tegn M5StickC
  //fill(204, 102, 0);
  //box (386, 80, 170);
  
  // Brug 3D-model af M5StickC
  rotate(180*PI/180);
  scale(5);
  shape(s, 0, 0);
  
  textSize(25);
  fill(255, 255, 255);

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
