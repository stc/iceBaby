////////////////////////////////////////////////////////
// all text to be displayed on screen
////////////////////////////////////////////////////////

//  WARNING!!! Memphis font family needs to be installed in your system

class Texts
{
  Texts()
  {
    font = createFont("MemphisLTPro-Bold", 22);
  }
  
  void startText()
  {
    textAlign(CENTER);
    textFont(font);
    text("ÁBRAKORI JÁTÉK INDULÁSRA KÉSZ \n csatlakoztasd az osc-t, lépkedj a stációk között a \n fel/le nyíllal", width/2, height/2-100);
    textAlign(LEFT);
  }
  
  void sorsolas()
  {
    textAlign(CENTER);
    textFont(font);
    text("Sorsolás...", width/2, height-40);
    textAlign(LEFT);
  }
}

