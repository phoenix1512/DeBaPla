void onAccelerometerEvent(float x, float y, float z){
  accelerometer.set(x, y, z);
  testSensorEvent();
}
 
void onLightEvent(float v) {
  light = v;
  testSensorEvent();
}
 
void onProximityEvent(float v) {
  proximity = v;
  testSensorEvent();
}
 
void onLocationEvent(double _latitude, double _longitude, double _altitude) {
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  testSensorEvent();
}
 
void onSavePhotoEvent(String filename) {
  camera.addToMediaLibrary(filename); 
}

void onCameraPreviewEvent() { 
  camera.read(); 
}

void eventInTheCar(int event) {
  String alerta = "";
  switch(event){ 
    case Eventos.PROXIMITY_EVENT:
      alerta = "POSIBLE INTRUSO HUSMEANDO";
      //camera.start();
      //if (camera.isStarted()) camera.savePhoto();
      //camera.stop();
      c = color(0,0,150);
      break;
    case Eventos.TOUCH_EVENT:
      alerta = "ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES";
      c = color(220,88,0);
      break;
    case Eventos.CAR_DISTURBANCE_EVENT:
      alerta = "PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS";
      c = color(150,0,0);
      break;
    case Eventos.INTRUDER_EVENT:
      alerta = "INTRUSO EN EL AUTO";
      c = color(0,150,0);
      break;
    case Eventos.GPS_EVENT:
      alerta = "EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO";
      c = color(0,135,150);
    case Eventos.HIT:
      alerta = "GOLPE POR ALCANCE";
      c = color(0,0,0);
      break;
    default:
      alerta = "";
      c = color(150,0,150);
      break;
  }
  if(currentEvent != event && event >= 0 && event <=4){
    honk.play();
  }
  
    //println("Se ha levantado la siguiente alerta: " + alerta + "\n Pero no hay dispositivo que nos escuche.");
  message = alerta;
  currentEvent = event;
}
 
class Eventos {
  static final int PROXIMITY_EVENT = 0;
  static final int TOUCH_EVENT = 1;
  static final int CAR_DISTURBANCE_EVENT = 2;
  static final int INTRUDER_EVENT = 3;
  static final int GPS_EVENT = 4;
  static final int HIT = 5;
}
 
 
void testSensorEvent() {
  if (touchIsStarted) {  
    eventInTheCar(Eventos.TOUCH_EVENT);
  } else if((accelerometer.x > 3.00 || accelerometer.x < -3.00) && accelerometer.z > 2.00 ){
    eventInTheCar(Eventos.CAR_DISTURBANCE_EVENT);
  } else if (light > 1000.0){
    eventInTheCar(Eventos.INTRUDER_EVENT);
  } else if(proximity == 0){   
    eventInTheCar(Eventos.PROXIMITY_EVENT);
  } else if(latitude != 0 && longitude != 0 && altitude!=0 && accelerometer.x > 3.00 && accelerometer.z > 2.00){
    eventInTheCar(Eventos.GPS_EVENT);
  } else{
    eventInTheCar(-1);
  }
}
