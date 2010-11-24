float[][] faceBoxDataX_Y_SC_R = {{},
{ 529.0, 336.0, 1.4999995, 0.13962634 }, 
{ 699.0, 266.0, 1.4399996, 0.10471976, 353.0, 409.0, 1.4399996, -0.24434613 },
{ 312.0, 249.0, 1.1299999, 0.19198623 ,746.0, 210.0, 1.1199999, -0.13962634 ,552.0, 490.0, 1.1199999, 0.4014257 }, 
{ 191.0, 228.0, 1.0899999, -0.26179942 ,847.0, 357.0, 1.0999999, 0.13962634 ,436.0, 507.0, 1.0999999, -0.43633226 ,604.0, 190.0, 1.0799999, 0.22689283 }, 
{ 204.0, 246.0, 0.95000005, -0.19198623 ,538.0, 176.0, 0.95000005, 0.13962634 ,849.0, 221.0, 0.95000005, -0.12217305 ,404.0, 539.0, 0.95000005, 0.15707964 ,727.0, 507.0, 0.95000005, -0.03490659 }
};

class Winners
{
  PImage bg;
  FaceBox faceSelected;
  ArrayList winners;
  boolean dragging;
  
  Winners()
  {
    winners = new ArrayList();
    faceSelected = null;
  }
  
  void load(ArrayList imageNames)
  {
    if (imageNames.size() > 0)
    {
       winners.clear();
       for (int i = 0; i < imageNames.size(); i++)
       {
           println("Loading: " + (String)imageNames.get(i));
           PImage img = loadImage((String)imageNames.get(i));    
           FaceBox b = new FaceBox(img);
           loadData(b, imageNames.size(), i);
           winners.add(b);
       }
       bg = loadImage("tablo/tablo" + winners.size() + ".png");  
    }
  }
  
  void display()
  {
    for (int i = 0; i < winners.size(); i++)
    {
       FaceBox b = (FaceBox)winners.get(i);
       b.draw(b == faceSelected);
    }
    if (faceSelected != null) 
    {
      if (dragging) faceSelected._set(mouseX, mouseY);  
    }
    
    tint(255);
    image(bg, 0, 0, width, height);  
  }
  
  void loadData(FaceBox b, int id, int nth)
  {
    b.x = faceBoxDataX_Y_SC_R[id][0 + nth * 4];
    b.y = faceBoxDataX_Y_SC_R[id][1 + nth * 4];
    b.sc = faceBoxDataX_Y_SC_R[id][2 + nth * 4];
    b.r = faceBoxDataX_Y_SC_R[id][3 + nth * 4];
  }
  void keyPressed()
  {
    if (keyCode == ENTER)
    {
      dragging = !dragging;
    }
    if (keyCode >= 48 && keyCode <=57)
    {
       int n = (int)constrain(keyCode - 48, 0, winners.size() - 1);
       faceSelected = (FaceBox)winners.get(n);
    }
    if (keyCode == LEFT)
    {
      if (faceSelected != null) faceSelected._rotate(-1);
    }
    if (keyCode == RIGHT)
    {
      if (faceSelected != null) faceSelected._rotate(1);
    }
    if (keyCode == UP)
    {
      if (faceSelected != null) faceSelected._scale(0.01);
    }
    if (keyCode == DOWN)
    {
      if (faceSelected != null) faceSelected._scale(-0.01);
    }
    if (key == 's')
    {
       print("{ ");
       for (int i = 0; i < winners.size(); i++)
       {
         FaceBox b = (FaceBox)winners.get(i);
         if (i > 0) print(" ,");
         print(b.x + ", " + b.y + ", " + b.sc + ", " + b.r);
       }
       println(" }");
     }
  }  
}

class FaceBox
{
  FaceBox(PImage _face)
  {
    face = _face;
    x = y = r = 0;
    sc = 1;
  }
  
  void _set(float _x, float _y) {x = _x; y = _y;}
  void _rotate(float _r) {r += radians(_r);}
  void _scale(float s) {sc += s;}
  
  void draw(boolean selected)
  {
    pushMatrix();
      translate(x, y);
      scale(sc);
      rotate(r);
      if (selected) tint(255, 0, 0); else tint(255);
      image(face, -face.width / 2.f, -face.height / 2.f);
    popMatrix();
  }
  
  PImage face;
  float x, y;
  float r;
  float sc;
}
