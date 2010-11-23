

class Diagram
{
  int successCounter;

  Diagram()
  {
    successCounter = 0;
    font = createFont("Arial", 18);
  }
  
  void load()
  {
  }
  
  void display()
  { 
    
    successCounter++;
    fill(255,0,0);
    rect(0,height-150,width,height-150); 
    GL gl=((PGraphicsOpenGL)g).beginGL();
  gl.glClear(GL.GL_DEPTH_BUFFER_BIT);
  ((PGraphicsOpenGL)g).endGL();
    
    fill(255);
   
   translate(0,0,1);
    text("itt lesz a diagram, plusz a szamlalo" + " " + successCounter + "%", 50, height-100);
       
  }
}
