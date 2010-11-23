import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import javax.media.opengl.*; 
import codeanticode.glgraphics.*; 
import TUIO.*; 
import oscP5.*; 
import netP5.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class iceBaby extends PApplet {

//----------------------------------------------------------------------------------------------------------------
//
//
//  ABRAKORI -- visual content
//  stc@basilar.net
//  2010
//
//
//----------------------------------------------------------------------------------------------------------------








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
  public boolean accept(File dir, String name) 
  {
    return name.toLowerCase().endsWith(".png");
  }
};

public String[] listFileNames(String dir,java.io.FilenameFilter extension) 
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

public void setup()
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

public void draw()
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

public void keyPressed()
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


public void oscEvent(OscMessage theOscMessage)
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


////////////////////////////////////////////////////////
// draw lines based on incoming tuio data  
////////////////////////////////////////////////////////

float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

class Drawing 
{

  Drawing()
  {
    font = createFont("Arial", 18);
    scale_factor = height/table_size;   
  }
  
  public void display()
  {
    textFont(font,18*scale_factor);
    float obj_size = object_size*scale_factor; 
    float cur_size = cursor_size*scale_factor; 
   
    Vector tuioObjectList = tuioClient.getTuioObjects();
    for (int i=0;i<tuioObjectList.size();i++) 
    {
      TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
      stroke(255);
      fill(0);
      pushMatrix();
      translate(tobj.getScreenX(width),tobj.getScreenY(height));
      rotate(tobj.getAngle());
      rect(-obj_size/2,-obj_size/2,obj_size,obj_size);
      popMatrix();
      fill(255,0,0);
      text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
    }
   
   Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<tuioCursorList.size();i++) 
   {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      Vector pointList = tcur.getPath();
      
      if (pointList.size()>0) 
      {
        
        stroke(0,19,100,20);
        TuioPoint start_point = (TuioPoint)pointList.firstElement();;
        for (int j=0;j<pointList.size();j++) 
        {
           TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
           strokeWeight(1);
           
           line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
           start_point = end_point;
        }
        
        strokeWeight(1);
        stroke(192,192,192);
        //fill(192,192,192);
        ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
        //fill(0);
        //text(""+ tcur.getCursorID(),  tcur.getScreenX(width)-5,  tcur.getScreenY(height)+5);
      }
    }
   
  }        
}

public void addTuioObject(TuioObject tobj) {
  //println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
public void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
public void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    //      +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
public void addTuioCursor(TuioCursor tcur) {
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
public void updateTuioCursor (TuioCursor tcur) {
  //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    //      +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
public void removeTuioCursor(TuioCursor tcur) {
  //println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
public void refresh(TuioTime bundleTime) { 
  redraw();
}
////////////////////////////////////////////////////////
//  smoothing a stream of floats by averaging them
////////////////////////////////////////////////////////

class Smooth
{
  
  int NUM_VALUES = 70;
  float[] values;
  int index = 0;
  float total = 0;
  float average = 0;
  float result;
  
  Smooth()
  {
     
    values = new float[ NUM_VALUES ];
     
    //  initialize values to 0
    for ( int thisValue = 0; thisValue < NUM_VALUES; thisValue++ )
    values[ thisValue ] = 0;
  }
  
  public float getAverage( float avg )
  {
    //  substract last reading
    total = total - values[index];
    //  fill in number stream from outside
    values[index] = avg;
    //  add the value to the total
    total = total + values[index];
    //  next position in the array
    index = index + 1;
    //  check if end of array
    if ( index >= NUM_VALUES ) index = 0;
    // calc average
    average = total/NUM_VALUES;
    //  return the average value
    return average;
  }
}
////////////////////////////////////////////////////////
//  photo sphere composed of opengl textures
////////////////////////////////////////////////////////

Node[] nodes;
int NODE_NUM = 100;
float R = 150.0f;

class Sphere 
{
  Sphere()
  {  
    nodes = new Node[NODE_NUM];
    for (int i=0; i<NODE_NUM; i++)
    {
      nodes[i] = new Node(i);
    }
  }

  
  
  public void display()
  {
     for(int i=0;i<NODE_NUM;i++)
     {
        nodes[i].moveMe();
        nodes[i].drawMe(i);
      }
    }
}


int quadDisplayList;
int id;

class Node
{
  
  float _x, _y, _z;
  
  float lat, lon;
  float dlat, dlon;
  float speed = 0.1f / 20.00f;
  
  Node(int ID)
  {
    initGL();
    
    id = ID;
    lat = random(0, TWO_PI);
    lon = random(0, PI);
    dlat = random(0, TWO_PI) * speed;
    dlon = random(0, PI) * speed;
   
  }
  
  public void moveMe()
  {
    lat += speed * noise(dlat * 0.005f + frameCount, dlon * 0.005f + frameCount);
    lon += speed * noise(dlat * 0.005f + frameCount, dlon * 0.005f + frameCount);  
  }
  
  public void drawMe(int ID)
  {
    id = ID;
    
    float x = R * cos(lat) * cos(lon);
    float y = R * cos(lat) * sin(lon);
    float z = R * sin(lat);
    
 
    
    //float quadScale = (sin(millis() * .001f) + 1) * .5f;
    //quadScale *= height;
  //background(0);
  //rotateY(x/200);
  //rotateZ(y/130);
  
  pgl.beginGL();

  gl.glPushMatrix();
  gl.glTranslatef(x +width/2f, y +height/2f, z*2);
  //gl.glScalef(quadScale, quadScale, quadScale);
  gl.glScalef(20f,20f,20f);
  gl.glActiveTexture(GL.GL_TEXTURE0);
  gl.glEnable(GL.GL_TEXTURE_2D);
  gl.glBindTexture(GL.GL_TEXTURE_2D, haloz[id].getTextureID());
  
  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glColor4f(1.0f, 1.0f, 1.0f, z/200);
  gl.glCallList(quadDisplayList);
  gl.glPopMatrix();
  
  gl.glDisable(GL.GL_TEXTURE_2D);
  pgl.endGL();
  
  pushMatrix();
  translate(x +width/2f, y +height/2f, z*2);
  noFill();
  stroke(255,255,255,z);
  translate(0,0,0);
  ellipse(0,0,30, 30);
  popMatrix();
  }
}

private void initGL()
{
  pgl.beginGL();
  quadDisplayList = gl.glGenLists(1);
  gl.glNewList(quadDisplayList, GL.GL_COMPILE);
  gl.glBegin(GL.GL_POLYGON);
  gl.glTexCoord2f(0, 0);

  gl.glVertex2f(-.5f, -.5f);
  gl.glTexCoord2f(1, 0);

  gl.glVertex2f( .5f, -.5f);
  gl.glTexCoord2f(1, 1);

  gl.glVertex2f( .5f,  .5f);
  gl.glTexCoord2f(0, 1);

  gl.glVertex2f(-.5f,  .5f);
  gl.glEnd();
  gl.glEndList();
  
  pgl.endGL();
}
////////////////////////////////////////////////////////
//  all text to be displayed on screen
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//  playing video with jmc library
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//  displaying winner pictures 
////////////////////////////////////////////////////////
PImage head;
PImage body;


String[] winnerfileNames;

java.io.FilenameFilter winnertxtFilter = new java.io.FilenameFilter() 
{
  public boolean accept(File winnerdir, String name) 
  {
    return name.toLowerCase().endsWith(".png");
  }
};

public String[] listwinnerFileNames(String dir,java.io.FilenameFilter extension) 
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

class Winners
{
  Winners()
  {
    //winnerfileNames = null;
     
    //println(sketchPath + "/data/" + "faces/2010" + "/winners/" + winnerfileNames[0]);
    

  }
  
  public void load()
  {
    
    winnerfileNames = listFileNames(sketchPath + "/data/" + photoPath + "/winners/",  winnertxtFilter);
    println(winnerfileNames);
    
    head = loadImage(sketchPath + "/data/" + photoPath + "/winners/"+ winnerfileNames[0]);
    body = loadImage("skeleton.jpg");
  }
  
  public void display()
  {
    image(body,0,0,width,height);
    //rotateZ(radians(20));
    rotate(radians(-20));
     //rotate(radians(-20));
    
     scale(0.8f);
     
    
   translate(0,0,1);
    image(head,width/2-40,height/2-20);
      
}
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "iceBaby" });
  }
}
