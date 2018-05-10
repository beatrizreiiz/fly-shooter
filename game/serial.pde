import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

float sensor1 = 0;
float sensor2 = 0;
float sensor3 = 0;

void setupSerial() {
  printArray(Serial.list());
  try {
    String portName = Serial.list()[1];
    myPort = new Serial(this, portName, 9600);  //115200
    println("connected to -->  " +portName);
    myPort.bufferUntil(','); //enables to split the data via a comma which is set in teh arduino code
  } 
  catch (Exception e) {
    println("no device connection found");
  }
}

void serialEvent(Serial myPort) {

  String inString = myPort.readStringUntil(',');
  // split the string into multiple strings
  // where there is a delimter":"

  // println(inString); //data line coming in

  String items[] = split(inString, ':');
  // if there was more than one string after the split
  if (items.length > 1) {
    String label = trim(items[0]);
    // remove the ',' off the end
    String val = split(items[1], ',')[0];

    // check what the label was and update the appropriate variable
    if (label.equals("S1")) {
      println("looks like sensor 1 was   "+val);
      sensor1 = float(val);
      if (sensor1 > 60) {
        ship.up();
      }
    } 
    // check what the label was and update the appropriate variable
    if (label.equals("S2")) {
      println("looks like sensor 2 was   "+val);
      sensor2 = float(val);
      if (sensor2 > 60) {
        ship.down();
      }
    } 

    if (label.equals("S3")) {
      println("looks like sensor 3 was   "+val);
      sensor3 = float(val);
      if (sensor3 > 70 && !torpedo.active) {
        soundfile.play();
        torpedo.x = ship.x+85;// + ship.img.width/2 - 20;
        torpedo.y = ship.y-ship.img.height/2-30;
        torpedo.active = true;
      }
    } 

    // more if statements for more possible data streams
  }
}