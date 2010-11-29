////////////////////////////////////////////////////////
// all text to be displayed on screen
////////////////////////////////////////////////////////

//  WARNING!!! Memphis font family needs to be installed in your system

int titlePos = 1500;
float alfachanger = 0;
int sorsolasPos = 660;

class Texts
{
  Texts()
  {
    font = createFont("MemphisLTPro-Bold", 22);
  }
  
  void startText()
  {
    fill(106,208,243);
    textAlign(CENTER);
    textFont(font);
    text("ÁBRAKORI JÁTÉK INDULÁSRA KÉSZ \n csatlakoztasd az osc-t, lépkedj a stációk között a \n fel/le nyíllal", width/2, titlePos);
    textAlign(LEFT);
  }
  
  void drawing()
  {
    alfachanger +=0.05;
    float alfaValue = sin(alfachanger)*100+200;
    fill(106,208,243,alfaValue);
    textAlign(CENTER);
    textFont(font);
    text("FIGYELEM, RAJZOLÁS INDUL!!!", width/2, height/2-30);
    textAlign(LEFT);
  }
  
  void sorsolas()
  {
    textAlign(CENTER);
    textFont(font);
    alfachanger +=0.05;
    float alfaValue = sin(alfachanger)*100+200;
    fill(255,alfaValue);
    text("Sorsolás következik...", width/2, sorsolasPos);
    textAlign(LEFT);
  }
  
  void nyertes()
  {
    textAlign(CENTER);
    textFont(font);
    alfachanger +=0.05;
    float alfaValue = sin(alfachanger)*100+200;
    fill(255,alfaValue);
    text("Ki lesz a nyertes?", width/2, 100);
    textAlign(LEFT);
  }
  
  void congrat()
  {
    textAlign(CENTER);
    textFont(font);
    alfachanger +=0.05;
    float alfaValue = sin(alfachanger)*100+200;
    fill(0,alfaValue);
    text("GRATULÁLUNK, NYERTÉL!!!", width/2, 700);
    textAlign(LEFT);
  }  
}

