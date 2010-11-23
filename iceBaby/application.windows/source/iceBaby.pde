//----------------------------------------------------------------------------------------------------------------
//
//
//  ABRAKORI -- visual content
//  stc@basilar.net
//  2010
//
//
//----------------------------------------------------------------------------------------------------------------

import processing.opengl.*;
import javax.media.opengl.*;
import codeanticode.glgraphics.*;
import TUIO.*;
import oscP5.*;
import netP5.*;

GLTexture halo;
GLTexture[] haloz;
PGraphicsOpenGL pgl;
GL gl;

TuioProcessing tuioClient;

Sphere mySphere;
Drawing myDrawing;
Winners myWinners;

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
//  filter out files that are not .jpgs

String[] fileNames;
java.io.FilenameFilter txtFilter = new java.io.FilenameFilter() 
{
  boolean accept(File dir, String name) 
  {
    return name.toLowerCase().endsWith(".png");
  }
};

String[] listFileNames(String dir,java.io.FilenameFilter extension) 
{
  File file = new File(dir);
  if (file.isDirectory()) 
  {
    String names[] = file.list(extension);
    return names;
  } 
  else {
    return null;
  }
}

//----------------------------------------------------------------------------------------------------------------

void setup()
{
  size(800,600,OPENGL);


  // set up display & opengl settings

  hint(ENABLE_OPENGL_4X_SMOOTH);
  hint(ENABLE_DEPTH_SORT);
  hint(ENABLE_NATIVE_FONTS);
  smooth();
  pgl = (PGraphicsOpenGL)g;
  gl = pgl.gl;
  
  //  read & init textures from folder
  
  //fileNames = listFileNames(sketchPath + "/data/" + "/faces/2010" + "/loosers", txtFilter);
  
 // fileNames = listFileNames(sketchPath + "/data/" + photoPath + "/loosers", txtFilter);
  //NODE_NUM = fileNames.length;
  //haloz = new GLTexture[NODE_NUM];
  
  for (int i=0; i<NODE_NUM; i++)
  {
    
  //  haloz[i] = new GLTexture(this, sketchPath + "/data/" + "faces/2010" + "/loosers/" + fileNames[i]);
   // haloz[i] = new GLTexture(this, sketchPath + "/data/" + photoPath + "/loosers/" + fileNames[i]);
    
}

  //  set up communication channels

  tuioClient  = new TuioProcessing(this);

  receiveAtPort = 12345;
  sendToPort = 1234;
  host = "127.0.0.1";
  oscP5event = "oscEvent";
  oscP5 = new OscP5(this,host, sendToPort,receiveAtPort,oscP5event);  
  myRemoteLocation = new NetAddress(host,sendToPort);

  //  set up custom classes to be displayed as a sequence

  mySphere = new Sphere();
  myDrawing = new Drawing();
  myWinners = new Winners();
  
}

//----------------------------------------------------------------------------------------------------------------

void draw()
{


  switch(sequence) 
  {
  case 0:
    break;

  case 1:
    println("Tutorial video started");  
    background(0);

    break;

  case 2:
    println("Drawing started");
    fill(0,5);  //  do not refresh, slow fading out
    noStroke();
    rect(0,0,width,height);       
    myDrawing.display();
    break;

  case 3:
    background(0);
    println("Read photos...");
    fileNames = listFileNames(sketchPath + "/data/" + photoPath + "/loosers", txtFilter);
   // println(sketchPath + "data/" + "2010" + "/loosers");
     //sketchPath + "data/" + photoPath + "/" + winnerFilenames[0] , winnertxtFilter
    
    NODE_NUM = fileNames.length;
    haloz = new GLTexture[NODE_NUM];
    for (int i = 0; i< NODE_NUM; i++)
    {
      //haloz[i].releaseTexture(); //  kill previous textures
      //haloz[i] = null;
      haloz[i] = new GLTexture(this, sketchPath + "/data/" + photoPath + "/loosers/" + fileNames[i]);
    }
    sequence = 4; //  run only once, jump to next case
    break;
  
  case 4: 
    background(0);
    //fill(0,20);
    //rect(0,0,width,height);
    println("Display photo sphere");
    mySphere.display();
    break;

  case 5:
    background(0);
    println("Displaying winners");
    myWinners.load();
    sequence = 6;
    break;
   
  case 6:
    background(0);
    myWinners.display();
    
}
  
}

//----------------------------------------------------------------------------------------------------------------
//  SEQUENCING EVENTS WITH KEYS

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
//  SEQUENCING EVENTS WITH INCOMING OSC DATA


void oscEvent(OscMessage theOscMessage)
{
  if(theOscMessage.checkAddrPattern("/FACES_SAVED")==true)
  {  
      oscData = theOscMessage.addrPattern();
      sequence = 3; //  display photoSphere
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
      sequence = 1; //  start tutorial video
      println(oscData);
      
      OscMessage myMessage = new OscMessage(oscData);
      oscP5.send(myMessage, myRemoteLocation);
      return;
 }
}


