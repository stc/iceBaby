//----------------------------------------------------------------------------------------------------------------
//
//
// ABRAKORI -- visual content
// stc@basilar.net
// 2010
//
//
//----------------------------------------------------------------------------------------------------------------

import processing.opengl.*;
import javax.media.opengl.*;
import TUIO.*;
import oscP5.*;
import netP5.*;
import jmcvideo.*;

TuioProcessing tuioClient;

Sphere mySphere;
Drawing myDrawing;
Winners myWinners;
Diagram myDiagram;
Texts myTexts;
Tutorial myTutorial;

OscP5 oscP5;
NetAddress myRemoteLocation;
int sequence;
int receiveAtPort;
int sendToPort;
String oscP5event;
String oscData;
String host;
String photoPath;

//----------------------------------------------------------------------------------------------------------------

void setup()
{
  size(800,600,OPENGL);
  
  // set up display & opengl settings

  hint(ENABLE_OPENGL_4X_SMOOTH);
  hint(ENABLE_DEPTH_SORT);
  hint(ENABLE_NATIVE_FONTS);
  smooth();
 
  // set up communication channels

  tuioClient = new TuioProcessing(this);

  receiveAtPort = 12345;
  sendToPort = 1234;
  host = "127.0.0.1";
  oscP5event = "oscEvent";
  oscP5 = new OscP5(this,host, sendToPort,receiveAtPort,oscP5event);
  myRemoteLocation = new NetAddress(host,sendToPort);

  // set up custom classes to be displayed as a sequence

  mySphere = new Sphere();
  myDrawing = new Drawing();
  myWinners = new Winners();
  myDiagram = new Diagram();
  myTexts = new Texts();
  myTutorial = new Tutorial();
}

//----------------------------------------------------------------------------------------------------------------

void draw()
{
  switch(sequence)
  {
  case 0:
    background(112,38,67);
    myTexts.startText();
    break;

  case 1:
<<<<<<< HEAD
    println("Tutorial video started");
=======
    println("Tutorial video started"); 
>>>>>>> 756528003ad97d2001b2137d43112023e25a1b46
    background(0);
    myTutorial.load();
    sequence = 2;
    break;

  case 2:
    //background(0);
    myTutorial.display();
    break;
    
  case 3:
    println("Drawing started");
    fill(0,5); // do not refresh, slow fading out
    noStroke();
    rect(0,0,width,height);
    myDrawing.display();
    break;
    
  case 4:
<<<<<<< HEAD
    fill(0,5); // do not refresh, slow fading out
=======
    fill(0,5);  //  do not refresh, slow fading out
>>>>>>> 756528003ad97d2001b2137d43112023e25a1b46
    noStroke();
    rect(0,0,width,height);
    myDrawing.display();
    myDiagram.display();
    break;

  case 5:
    background(0);
    println("Read photos...");
    fileNames = listFileNames(sketchPath + "/data/" + photoPath + "/loosers", txtFilter);
    
    NODE_NUM = fileNames.length;
    nodes = new Node[NODE_NUM];
    for (int i=0; i<NODE_NUM; i++)
    {
      nodes[i] = new Node(i, sketchPath + "/data/" + photoPath + "/loosers/" + fileNames[i]);
    }
<<<<<<< HEAD
    sequence = 6; // run only once, jump to next case
    break;
  
  case 6:
=======
    sequence = 6; //  run only once, jump to next case
    break;
  
  case 6: 
>>>>>>> 756528003ad97d2001b2137d43112023e25a1b46
    background(0);
    println("Display photo sphere");
    mySphere.display();
    break;

  case 7:
    background(0);
    println("Displaying winners");
    winnerfileNames = listFileNames(sketchPath + "/data/" + photoPath + "/winners/", winnertxtFilter);
    for (int i = 0; i < winnerfileNames.length; i++)
    {
      myWinners.load(sketchPath + "/data/" + photoPath + "/winners/" + winnerfileNames[i]);
    }
<<<<<<< HEAD
    sequence = 8; // run only once, jump to next case
=======
    sequence = 8; //  run only once, jump to next case
>>>>>>> 756528003ad97d2001b2137d43112023e25a1b46
    break;
   
  case 8:
    background(0);
    myWinners.display();
  }
}

//----------------------------------------------------------------------------------------------------------------
// SEQUENCING EVENTS WITH KEYS

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      sequence--;
    }
    else if (keyCode == DOWN)
    {
      sequence++;
    }
    else
    {
      
    }
  }
}

//----------------------------------------------------------------------------------------------------------------
// SEQUENCING EVENTS WITH INCOMING OSC DATA


void oscEvent(OscMessage theOscMessage)
{
  if(theOscMessage.checkAddrPattern("/FACES_SAVED")==true)
  {
      oscData = theOscMessage.addrPattern();
<<<<<<< HEAD
      sequence = 5; // display photoSphere
=======
      sequence = 5; //  display photoSphere
>>>>>>> 756528003ad97d2001b2137d43112023e25a1b46
      println(oscData);
      
      String Value = theOscMessage.get(0).stringValue(); // get the third osc argument
      println(Value);
      photoPath = Value;
      OscMessage myMessage = new OscMessage(oscData);
      oscP5.send(myMessage, myRemoteLocation);
      return;
  }
 if(theOscMessage.checkAddrPattern("/START_THE_GAME")==true)
 {
      oscData = theOscMessage.addrPattern();
      sequence = 1; // start tutorial video
      println(oscData);
      
      OscMessage myMessage = new OscMessage(oscData);
      oscP5.send(myMessage, myRemoteLocation);
      return;
 }
}
<<<<<<< HEAD
=======

>>>>>>> 756528003ad97d2001b2137d43112023e25a1b46
