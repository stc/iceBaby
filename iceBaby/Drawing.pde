////////////////////////////////////////////////////////
// draw lines based on incoming tuio data  
////////////////////////////////////////////////////////

float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;


//  variables for easing

float _sx=0;
float _sy=0;
float _ex=0;
float _ey=0;
float speed = 1.8;


class Drawing 
{

  Drawing()
  {
    font = createFont("Arial", 18);
    scale_factor = height/table_size;
  }

  void load()
  {
    fill(106,208,243,255);
    noStroke();
    rect(0,0,width,height);
  }

  void display()
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
        TuioPoint start_point = (TuioPoint)pointList.firstElement();
        ;
        for (int j=0;j<pointList.size();j++) 
        {
          TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
          strokeWeight(1);
          stroke(255,10);
          
          //  easing:
          
          float endStartX = start_point.getScreenX(width);
          float endStartY = start_point.getScreenY(height);
          _sx += (endStartX - _sx) / speed;
          _sy += (endStartY - _sy) / speed;
           
          float endEndX = end_point.getScreenX(width);
          float endEndY = end_point.getScreenY(height);
          _ex += (endEndX - _ex) / speed;
          _ey += (endEndY - _ey) / speed;
           strokeWeight(2);
           line(_sx,_sy,_ex,_ey);
           stroke(86,123,178,10);
           
          line(_sx-1,_sy-1,_ex-1,_ey-1);  
          //line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
          start_point = end_point;
        } 
      }
    }   
  }
}

void addTuioObject(TuioObject tobj) {
  //println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
  //      +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
  //      +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  //println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

