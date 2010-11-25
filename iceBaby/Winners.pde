float[][] faceBoxDataX_Y_S_R = {{},
{ 529.0, 336.0, 383.99988, 0.13962634 }, 
{ 699.0, 266.0, 368.6399, 0.10471976 ,353.0, 409.0, 368.6399, -0.24434613 },
{ 312.0, 249.0, 289.27997, 0.19198623 ,746.0, 210.0, 286.71997, -0.13962634 ,552.0, 490.0, 286.71997, 0.4014257 }, 
{ 191.0, 228.0, 279.03998, -0.26179942 ,847.0, 357.0, 281.59998, 0.13962634 ,436.0, 507.0, 281.59998, -0.43633226 ,604.0, 190.0, 276.47998, 0.22689283 },
{ 202.0, 246.0, 239.95, -0.19198623 ,536.0, 176.0, 242.95, 0.13962634 ,853.0, 221.0, 241.95, -0.12217305 ,403.0, 542.0, 256.95, 0.15707964 ,726.0, 508.0, 246.95, -0.03490659 }
};

class Winners
{
  PImage bg;
  //FaceBox faceSelected;
  ArrayList winners;
  //boolean dragging;
  
  Winners()
  {
    winners = new ArrayList();
    //faceSelected = null;
  }
  
  void load(ArrayList imageNames)
  {
    if (imageNames.size() > 0 && imageNames.size() < 6)
    {
       winners.clear();
       for (int i = 0; i < imageNames.size(); i++)
       {
           //println("Loading: " + (String)imageNames.get(i));
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
    hint(DISABLE_DEPTH_TEST);
    hint(DISABLE_DEPTH_SORT);
    for (int i = 0; i < winners.size(); i++)
    {
       FaceBox b = (FaceBox)winners.get(i);
       b.draw(true);//b == faceSelected);
    }
    /*if (faceSelected != null) 
    {
      if (dragging) faceSelected._set(mouseX, mouseY);  
    }*/
    
    tint(255);    
    image(bg, 0, 0);
    hint(ENABLE_DEPTH_SORT);
    hint(ENABLE_DEPTH_TEST);
  }
  
  void loadData(FaceBox b, int id, int nth)
  {
    b.x = faceBoxDataX_Y_S_R[id][0 + nth * 4];
    b.y = faceBoxDataX_Y_S_R[id][1 + nth * 4];
    b.s = faceBoxDataX_Y_S_R[id][2 + nth * 4];      
    b.r = faceBoxDataX_Y_S_R[id][3 + nth * 4];    
  }
  
  void keyPressed()
  {
    /*
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
      if (faceSelected != null) faceSelected._scale(1);
    }
    if (keyCode == DOWN)
    {
      if (faceSelected != null) faceSelected._scale(-1);
    }
    if (key == 's')
    {
       print("{ ");
       for (int i = 0; i < winners.size(); i++)
       {
         FaceBox b = (FaceBox)winners.get(i);
         if (i > 0) print(" ,");
         print(b.x + ", " + b.y + ", " + b.s + ", " + b.r);
       }
       println(" }");
     }
     */
  }    
}

class FaceBox
{
  FaceBox(PImage _face)
  {
    face = _face;
    x = y = r = 0;
    s = 256;
  }
  
  void _set(float _x, float _y) {x = _x; y = _y;}
  void _rotate(float _r) {r += radians(_r);}
  void _scale(float _s) {s += _s;}
  
  void draw(boolean selected)
  {  	
    pushMatrix();
      translate(x, y);
      rotate(r);
      //if (selected) tint(255, 0, 0); else 
      tint(255);
      image(face, -s/2., -s/2., s, s);
    popMatrix();
  }
  
  PImage face;
  float x, y;
  float r;
  float s;
}
