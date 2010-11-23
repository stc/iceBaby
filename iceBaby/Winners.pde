////////////////////////////////////////////////////////
//  displaying winner pictures 
////////////////////////////////////////////////////////
PImage head;
String path;

class Winners
{
  Winners()
  {
  }
  
  void load( String winnerfiles )
  {
    
    path = winnerfiles;
    head = loadImage(winnerfiles);
    println(path);
  }
  
  void display()
  {
    translate(0,0,0);
    tint(255,255,255,255);
    image(head,mouseX-50,mouseY-50,100,100);   
  }
}
