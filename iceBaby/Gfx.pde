PImage logo;
int logoPos;
String logoPath;

class Gfx 
{
  Gfx()
  {
   logo = loadImage("arculat/logo.png");
   logoPos = -300;  
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
}
