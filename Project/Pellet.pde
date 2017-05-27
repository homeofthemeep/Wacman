public class Pellet extends RectCollision
{
  int x, y;
  
  public Pellet(int x, int y, int superX, int superY, int w, int h)
  {
    super(superX,superY,w,h);
    this.x = x; this.y = y;
  }    
  
  public void show()//Going to be replaced with an image. 
  {    
    fill(0,255,0);
    rect(super.x1,super.y1,w,h);
    fill(255);
  }

}

public class BigPellet extends Pellet
{
  public BigPellet(int x, int y, int superX, int superY, int w, int h)
  {
    super(x,y, superX, superY,w, h);
    this.x = x; this.y = y;
  }
  
  public void show()//Going to be replaced with an image. 
  {
    
    fill(0,255,255);
    rect(super.x1,super.y1,w,h);
    fill(255);
  }
      
}