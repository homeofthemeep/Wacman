public class Scoreboard
{
  PFont font;
  String[] str;
  int highscore;
  int r, g, b;
  boolean hsGame;
  public Scoreboard()
  {
    hsGame = false;
    str = new String[1];
    //this.x = x; this.y = y;
    font = createFont("/data/OCRAStd.otf", 32);
    textFont(font);
    str = loadStrings("/data/highscore.txt");
    highscore = int(str[0]);
    r = g = b = 255;
  }
  
  void show()
  {  
    if(frameCount%10 == 0 && hsGame)
    {
      r = (int) random(0, 255);
      g = (int) random(0, 255);
      b = (int) random(0, 255);
      
      if(r < 128) {r = 0;} else{r = 255;}
      if(g < 128) {g = 0;} else{g = 255;}
      if(b < 128) {b = 0;} else{b = 255;}
      if(r < 128 && g < 128 && b < 128) {r=g=b=255;}
    }
    
    if(player.score > highscore)
    {
      hsGame = true;
      highscore = player.score;
      fill(r, g, b);
    }
    fill(r,g,b);
    text("HIGHSCORE: " + (highscore*10), width/2+400, height/2-200);
    
    fill(255);
    text("    SCORE: " + (player.score*10), width/2+400, height/2-168);    
    
    fill(255,255,0);
    text("     AMMO: " + (player.ammo), width/2+400, height/2-136); 
    
    fill(255);
  }
  
  void saveHighScore()
  {
    str[0] = str(highscore);
    saveStrings("/data/highscore.txt", str);
  }
  
  
}