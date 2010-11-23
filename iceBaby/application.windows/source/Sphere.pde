////////////////////////////////////////////////////////
//  photo sphere composed of opengl textures
////////////////////////////////////////////////////////

Node[] nodes;
int NODE_NUM = 100;
float R = 150.0;

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

  
  
  void display()
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
  float speed = 0.1 / 20.00;
  
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
    lat += speed * noise(dlat * 0.005 + frameCount, dlon * 0.005 + frameCount);
    lon += speed * noise(dlat * 0.005 + frameCount, dlon * 0.005 + frameCount);  
  }
  
  void drawMe(int ID)
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
