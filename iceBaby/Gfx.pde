PImage logo;
int logoPos;
String logoPath;

int Length=300;
float[] X=new float[Length];
float[] Y=new float[Length];
float[] Z=new float[Length];
float[] r=new float[Length];
float[] thetaX=new float[Length];
float[] thetaY=new float[Length];
float[] thetaZ=new float[Length];

class Gfx 
{
  Gfx()
  {
   logo = loadImage("arculat/logo.png");
   logoPos = -300;  
   
   //  this is for falling boxes
   
   for(int i=0;i<Length;i++)
   {
    X[i]=random(width);
    Y[i]=random(-1000,0);
    Z[i]=random(-1000,1000);
    r[i]=random(1,10);
    thetaX[i]=random(0.001,0.1);
    thetaY[i]=random(0.001,0.1);
    thetaZ[i]=random(0.001,0.1);
   }
  }
  
  void load()
  {
  }
  
  void display()
  {
  }
  
  void logoMe()
  {
    imageMode(CENTER);
    tint(255,logoPos);
    image(logo, logoPos, height/2-100);   
  }
  
  void fallingCubes()
  {
    for(int i=0;i<Length;i++)
    {
      pushMatrix();
      translate(X[i],Y[i],Z[i]);
      rotateX(thetaX[i]);
      rotateY(thetaY[i]);
      rotateZ(thetaZ[i]);
      stroke(180,180);
      tint(255,180);
      box(r[i]);
      if(Y[i]>height+50)
      {
        Y[i]=random(-100,0);
      }
      else
      {
        Y[i]+=random(0.5,3);
      }
      thetaX[i]+=random(0.001,0.1);
      thetaY[i]+=random(0.001,0.1);
      popMatrix();
    } 
  }
}
