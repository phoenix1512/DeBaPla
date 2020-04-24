import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;

float x, y, speedX, speedY;
float diam = 10;
float rectSize = 200;

void setup() {
  fullScreen();
  fill(0, 255, 0);
  reset();
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.1.64", 12000);  // 1 Customize!
  textAlign(CENTER, CENTER);
  textSize(24);
}

void reset() {
  x = width/2;
  y = height/2;
  speedX = random(3, 5);
  speedY = random(3, 5);
}

void draw() { 
  background(0);
  
  ellipse(x, y, diam, diam);

  rect(0, 0, 20, height);
  rect(width-30, mouseY-rectSize/2, 10, rectSize);

  x += speedX;
  y += speedY;

  // if ball hits movable bar, invert X direction
  if ( x > width-30 && x < width -20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
    speedX = speedX * -1;
  } 

  // if ball hits wall, change direction of X
  if (x < 25) {
    speedX *= -1.1;
    speedY *= 1.1;
    x += speedX;
  }


  // if ball hits up or down, change direction of Y   
  if ( y > height || y < 0 ) {
    speedY *= -1;
  }
  
  text("Remote Accelerometer Info: " + "\n" +
    "x: "+ nfp(accelerometerX, 1, 3) + "\n" +
    "y: "+ nfp(accelerometerY, 1, 3) + "\n" +
    "z: "+ nfp(accelerometerZ, 1, 3) + "\n\n" +
    "Local Info: \n" + 
    "mousePressed: " + mousePressed, width/2, height/2);

  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add(mouseX);                                  // 2
  myMessage.add(mouseY);                                  // 3
  myMessage.add(int(mousePressed));                       // 4
  oscP5.send(myMessage, remoteLocation);                  // 5
}

void mousePressed() {
  reset();
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("fff"))                  // 6
  {
    accelerometerX =  theOscMessage.get(0).floatValue();  // 7
    accelerometerY =  theOscMessage.get(1).floatValue();
    accelerometerZ =  theOscMessage.get(2).floatValue();
  }
}
