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
import de.looksgood.ani.*;

TuioProcessing tuioClient;

Sphere mySphere;
Drawing myDrawing;
Winners myWinners;
Diagram myDiagram;
Texts myTexts;
Tutorial myTutorial;
Gfx myGfx;

OscP5 oscP5;
NetAddress myRemoteLocation;
int sequence;
int receiveAtPort;
int sendToPort;
String oscP5event;
String oscData;
String host;
String photoPath = "faces/2010";
ArrayList photos;

int fadeDraw = 255;

//----------------------------------------------------------------------------------------------------------------

void setup()
{
  size(1024,768,OPENGL);
  
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

  photos = new ArrayList();
  

  // set up custom classes to be displayed as a sequence

  mySphere = new Sphere();
  myDrawing = new Drawing();
  myWinners = new Winners();
  myDiagram = new Diagram(0,height-200,width,200);
  myTexts = new Texts();
  myTutorial = new Tutorial();
  myGfx = new Gfx();
  
  //  setup tweening library
  
  Ani.init(this);
}

//----------------------------------------------------------------------------------------------------------------

void draw()
{
  switch(sequence)
  {
  case 0:
    background(255);
    myGfx.logoMe();
    myTexts.startText();
    break;
   
  case 1:
    background(255);
    myTutorial.load();
    sequence = 2;
    break;

  case 2:
    background(255);
    myTutorial.display();
    break;
  
  case 3:
    background(255);
    myTexts.drawing();
    myTutorial.stopMe();
    break;
  
  case 4:
    background(255);
    myDrawing.load();
    sequence = 5;
    break;
    
  case 5:
    background(106,208,243);
    myDiagram.display();
    fadeDraw--;
    fill(255,fadeDraw); 
    noStroke();
    rect(0,0,width,height);
    break;
    
  case 6:
    myDrawing.display();
    myDiagram.display();
    break;
    
  case 7:
    myDrawing.display();
    myDiagram.display();
    myTexts.sorsolas();
    break;
    
  case 8:
    background(255);
    fileNames = listFileNames(sketchPath + "/data/" + photoPath + "/loosers", txtFilter);
    
    NODE_NUM = fileNames.length;
    nodes = new Node[NODE_NUM];
    for (int i=0; i<NODE_NUM; i++)
    {
       nodes[i] = new Node(i, sketchPath + "/data/" + photoPath + "/loosers/" + fileNames[i]);
    }
    R = 0;
    sequence = 9;
    break;
  
  case 9:
    background(106,208,243);
    myDiagram.display();
    mySphere.display();
    myTexts.nyertes();
    fadeDraw=0;
    break;

  case 10:
    background(106,208,243);
    myDiagram.display();
    mySphere.display();
    myTexts.nyertes();
    fadeDraw++;
    fill(255,fadeDraw);
    rect(0,0,width,height);
    break;
    
  case 11:
    background(255);
    winnerfileNames = listFileNames(sketchPath + "/data/" + photoPath + "/winners/", winnertxtFilter);
    for (int i = 0; i < winnerfileNames.length; i++)
    {  
      photos.add(sketchPath + "/data/" + photoPath + "/winners/" + winnerfileNames[i]);    
      myWinners.load(photos);
    }
    sequence = 12; // run only once, jump to next case
    break;
   
  case 12:
    background(255);
    imageMode(CORNER);
    myWinners.display();
    myTexts.congrat();
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
    else if (keyCode == LEFT)
    {
      Ani.to(this, 1.5, "logoPos", width/2, Ani.BOUNCE_OUT);
      Ani.to(this, 4.5, "titlePos", height/2, Ani.QUART_OUT); 
    }
    else if (keyCode == RIGHT)
    {
      Ani.to(this, 0.5, "logoPos", width+500, Ani.QUART_IN);
      Ani.to(this, 1.5, "titlePos", height+500, Ani.QUART_IN);
      Ani.to(this, 1.5, "R", 150, Ani.BOUNCE_OUT);
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
      sequence = 6;
      println(oscData);
      
      String Value = theOscMessage.get(0).stringValue(); 
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

