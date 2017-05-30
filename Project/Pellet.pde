public class Pellet extends RectCollision
{
  PImage sprite;
  int x, y;
  
  public Pellet(int x, int y, int superX, int superY, int w, int h)
  {
    super(superX,superY,w,h);
    this.x = x; this.y = y;
    sprite = loadImage("smallPellet.png");
  }    
  
  public void show()//Going to be replaced with an image. 
  {    
    image(sprite, super.x1-21, super.y1-21);
  }

}

public class BigPellet extends Pellet
{
  public BigPellet(int x, int y, int superX, int superY, int w, int h)
  {
    super(x,y, superX, superY,w, h);
    this.x = x; this.y = y;
    sprite = loadImage("bigPellet.png");
  }
  
  public void show()//Going to be replaced with an image. 
  {    
    image(sprite, super.x1-14, super.y1-14);
  }
      
}