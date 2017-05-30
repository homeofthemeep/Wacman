public class Scoreboard
{
  PFont font;
  String[] str;
  int highscore;
  public Scoreboard()
  {
    str = new String[1];
    //this.x = x; this.y = y;
    font = createFont("OCRAStd.otf", 32);
    textFont(font);
    str = loadStrings("highscore.txt");
    highscore = int(str[0]);
  }
  
  void show()
  {  
    if(player.score > highscore)
    {
      highscore = player.score;
      
    }
    text("HIGHSCORE: " + (highscore*10), width/2+400, height/2-200);
    text("    SCORE: " + (player.score*10), width/2+400, height/2-168);    
    text("     AMMO: " + (player.ammo), width/2+400, height/2-136); 
  }
  
  void saveHighScore()
  {
    str[0] = str(highscore);
    saveStrings("highscore.txt", str);
  }
  
  
}