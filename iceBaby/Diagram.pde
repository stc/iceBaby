float[] numbers;
float counter;
int xPos;
int yPos;
int xSize;
int ySize;

PFont diagramfont;
PFont percentfont;

class Diagram
{
  Diagram(int _xPos, int _yPos, int _xSize, int _ySize)
  {
     xPos = _xPos;
     yPos = _yPos;
     xSize = _xSize;
     ySize = _ySize;
     numbers = new float[xSize-60];
     diagramfont = createFont("Arial-Black", 10); 
     percentfont = createFont("Arial-Black", 24);
     hint(DISABLE_DEPTH_TEST);
     hint(DISABLE_DEPTH_SORT);    
  }
  
  void load()
  {
  }
  
  void display()
  {   
    GL gl=((PGraphicsOpenGL)g).beginGL();
        gl.glClear(GL.GL_DEPTH_BUFFER_BIT);
        ((PGraphicsOpenGL)g).endGL();
        fill(52);
        noStroke();
        rectMode(CORNERS);
        rect(0,height-200,width,height); 
        translate(0,0,2);
        strokeWeight(1);
        noFill();
        
        counter += random(1)/3 - 0.14;
        stroke(255,200);
        line(xPos,yPos+ySize/2,xPos+xSize,yPos+ySize/2);
        line(xPos,yPos+15,xPos+xSize,yPos+15);
        stroke(255,98,0);
        beginShape();
        for(int i = 0; i<numbers.length;i++)
        {
          vertex(i,yPos+ySize-numbers[i]);
        }
        endShape();
  
    for(int i = 1; i<numbers.length;i++)
    {
      numbers[i-1] = numbers[i];
    }
     
     float mod = counter%10;
     if(mod>7){ numbers[numbers.length-1] = counter + sin(counter)*3-1.5;}  
     fill(20);
     textFont(diagramfont);
     text("100%", xPos+10+1, yPos+10+1);
     text("50%", xPos+10+1, yPos+ySize/2-5+1);
     fill(255);
     text("100%", xPos+10, yPos+10);
     text("50%", xPos+10, yPos+ySize/2-5);
     float percent = counter + sin(counter)*3-1.5;
     textFont(percentfont);
     fill(100);
     text(int(percent/2) + "%",xSize-70+3,height-percent+3);
     fill(255); 
     text(int(percent/2) + "%",xSize-70,height-percent);  
    }
}
