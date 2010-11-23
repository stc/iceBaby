////////////////////////////////////////////////////////
//  all text to be displayed on screen
////////////////////////////////////////////////////////
class Texts
{
  Texts()
  {
    font = createFont("Arial", 36);
  }
  
  void startText()
  {
    textAlign(CENTER);
    text("ÁBRAKORI JÁTÉK INDULÁSRA KÉSZ \n csatlakoztasd az osc-t, lépkedj a stációk között a \n fel/le nyíllal", width/2, height/2-100);
    textAlign(LEFT);
  }
}