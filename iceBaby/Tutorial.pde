////////////////////////////////////////////////////////
//  playing video with jmc library
////////////////////////////////////////////////////////
JMCMovieGL myMovie;
int pvw, pvh;


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
    //myMovie.alpha = 20f/255f;
    myMovie.image(gl, 20, 30, myMovie.width, myMovie.height);
  }
  pgl.endGL();
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







