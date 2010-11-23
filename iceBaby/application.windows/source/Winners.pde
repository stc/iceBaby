////////////////////////////////////////////////////////
//  displaying winner pictures 
////////////////////////////////////////////////////////
PImage head;
PImage body;


String[] winnerfileNames;

java.io.FilenameFilter winnertxtFilter = new java.io.FilenameFilter() 
{
  boolean accept(File winnerdir, String name) 
  {
    return name.toLowerCase().endsWith(".png");
  }
};

String[] listwinnerFileNames(String dir,java.io.FilenameFilter extension) 
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
  
  void load()
  {
    
    winnerfileNames = listFileNames(sketchPath + "/data/" + photoPath + "/winners/",  winnertxtFilter);
    println(winnerfileNames);
    
    head = loadImage(sketchPath + "/data/" + photoPath + "/winners/"+ winnerfileNames[0]);
    body = loadImage("skeleton.jpg");
  }
  
  void display()
  {
    image(body,0,0,width,height);
    //rotateZ(radians(20));
    rotate(radians(-20));
     //rotate(radians(-20));
    
     scale(0.8);
     
    
   translate(0,0,1);
    image(head,width/2-40,height/2-20);
      
}
}
