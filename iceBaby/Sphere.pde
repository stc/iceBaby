////////////////////////////////////////////////////////
//  photo sphere composed of opengl textures
////////////////////////////////////////////////////////

Node[] nodes;
int NODE_NUM = 100;
float R = 150.0;
String looserpath;
PImage winPic;

class Sphere 
{
  Sphere()
  {  
  }

  void display()
  {
     for(int i=0;i<NODE_NUM;i++)
     {
        nodes[i].moveMe();
        nodes[i].drawMe(i);
     }
  }
}

int id;

class Node
{
  
  float _x, _y, _z;
  
  float lat, lon;
  float dlat, dlon;
  float speed = 0.1 / 20.00;
  
  Node(int ID, String _path)
  { 
    id = ID;
    looserpath = _path;
    
    lat = random(0, TWO_PI);
    lon = random(0, PI);
    dlat = random(0, TWO_PI) * speed;
    dlon = random(0, PI) * speed;
    winPic = loadImage(looserpath);
   
  }
  
  public void moveMe()
  {
    //  move instances on a surface of a sphere, randomly
    
    lat += speed * noise(dlat * 0.005 + frameCount, dlon * 0.005 + frameCount);
    lon += speed * noise(dlat * 0.005 + frameCount, dlon * 0.005 + frameCount);  
  }
  
  public void drawMe(int ID)
  {
    id = ID;
    
    float x = R * cos(lat) * cos(lon);
    float y = R * cos(lat) * sin(lon);
    float z = R * sin(lat);
    
    pushMatrix();
    translate(x +width/2f, y +height/2f, z);
    noFill();
    stroke(255,255,255,z);
    translate(0,0,0);
    ellipse(0,0,75, 75);
    translate(-30,-30,0);
    tint(255,z+100);
    image(winPic,0,0,60,60);
    popMatrix();
    }
  }


