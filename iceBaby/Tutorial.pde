////////////////////////////////////////////////////////
// playing video with jmc library
////////////////////////////////////////////////////////
JMCMovieGL myMovie;
int pvw, pvh;
int fadeUp = 255;
int end = 0;


class Tutorial
{
  Tutorial()
  {
    myMovie = movieFromDataPath("axis.mov");
  }
  
  void load()
  {
    myMovie.play();
  }
  
  void display()
  {
    PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;
    GL gl = pgl.beginGL();
    {
    if (pvw != width || pvh != height)
    {
      background(0);
      gl.glViewport(0, 0, width, height);
      pvw = width;
      pvh = height;
    }
    myMovie.image(gl, 125, 100, myMovie.width, myMovie.height);
  }
  pgl.endGL();
  
 // text to be written
  
    fill(106,208,243);
    noStroke();
    rectMode(CORNERS);
    rect(125,height-180,width-130,height-100); 
    
    fill(255);
    translate(0,0,1);
    text("bevezető animáció",140, height-140);
    
    fadeUp -=5;
    if(fadeUp<0)fadeUp=0;
    fill(255,fadeUp);
    rect(0,0,width,height);  
  }
  
  void stopMe()
  {
    end+=40;
    PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;
    GL gl = pgl.beginGL();
    {
      if (pvw != width || pvh != height)
      {
        background(0);
        gl.glViewport(0, 0, width, height);
        pvw = width;
        pvh = height;
      }
      myMovie.image(gl, 125, 100-end, myMovie.width, myMovie.height);
    }
    pgl.endGL();
    
    fill(106,208,243);
    noStroke();
    rectMode(CORNERS);
    rect(125,height-170+end,width-130,height-100+end); 
    fill(255);
    translate(0,0,1);
    text("bevezető animáció",140, height-130+end);
  }
}

JMCMovieGL movieFromDataPath(String filename)
{
  return new JMCMovieGL(this, filename, RGB);
}

JMCMovieGL movieFromFile(String filename)
{
  return new JMCMovieGL(this, new File(filename), RGB);
}

JMCMovieGL movieFromURL(String urlname)
{
  URL url = null;

  try
  {
    url = new URL(urlname);
  }
  catch(Exception e)
  {
    println("URL error...");
  }
  return new JMCMovieGL(this, url, RGB);
}

