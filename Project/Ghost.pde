public class Ghost
{
  public int x, y, direction;
  public boolean[] types;
  public Node curNode, prevNode, targetNode;
  public RectCollision body;
  
  public Ghost(int x, int y, int wCol, int hCol, boolean[] b)
  {
    body = new RectCollision(width/2, height/2, wCol-1, hCol-1);
    this.x = x; this.y = y;  
    types = b;
  }
  
  public void show()
  {
    if(types[0] == true) //Blinky
    {
      fill(255,0,0);
      rect(x,y,49,49);
      fill(255);
    }
    
    if(types[1] == true) //Pinky
    {
      fill(255,192,192);
      rect(x,y,49,49);
      fill(255);
    }
    
    if(types[2] == true) //Inky
    {
      fill(0,255,255);
      rect(x,y,49,49);
      fill(255);
    }
    
    if(types[3] == true) //Clyde
    {
      fill(255,170,0);
      rect(x,y,49,49);
      fill(255);
    }
    
  }
  
  public void move()
  {
  
  }
  
}