
import android.os.Bundle;
import android.content.Intent; 

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

import ketai.sensors.*;
import ketai.camera.*;

import cassette.audiofiles.SoundFile;

KetaiSensor sensor;
KetaiCamera camera;
PVector accelerometer;
float light, proximity;
KetaiLocation location;
double longitude, latitude, altitude;

KetaiList connectionList;
String info = ""; 
boolean isConfiguring = true;
String UIText;

ArrayList<String> devices = new ArrayList<String>();
boolean isWatching = false;

String message = "";
color c = color(150, 0, 150);

int currentEvent = -1;
SoundFile honk;

void setup() {
  orientation(PORTRAIT);
  background(150, 0, 150);
  stroke(255);
    
  sensor = new KetaiSensor(this);
  camera = new KetaiCamera(this, 1280, 768, 30);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  location = new KetaiLocation(this);
  sensor.enableProximity();
  sensor.enableLight();
  camera.setCameraID(1); 
  imageMode(CENTER);
  
  honk = new SoundFile(this, "tonopr.mp3");
}

void draw() {
  textAlign(CENTER,CENTER);
  textSize(60);
  background(c);
  text(message, 10, 30, width, height);
  
}
