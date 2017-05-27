public class RectCollision //Fixed with Cam's help, and Sean's a nice person
{
  //This is the class for 2d rectangular collsion. Credited to Talbot and above's help.
  public PShape rect; //Use a class already given by Processing. It has gives us the basics of a rectangle. Might not be needed.
  public int x1, y1, x2, y2, w, h; //The two elements of the top left point's coordinates. The two elements of the bottom right point's coordinates. The width and the height of the rectangle.
  
  public RectCollision(int x, int y, int w, int h)
  {
    rect = createShape(RECT, x, y, w, h);
    x1=x; y1=y; x2=x+w; y2=y+h;
    this.w = w; this.h = h;
  }
  
  public RectCollision()
  {
    rect = null;
  }
  
  public void show()
  {
    fill(0,0,255);
    rect(x1,y1,w,h);
    fill(255);
  }
  
  public boolean isColliding(RectCollision other) // THIS WORKS!!!!. Got this method idea from <https://stackoverflow.com/questions/31022269/collision-detection-between-two-rectangles-in-java>
  { // other = l2.x&y, r2.x&y (x1,y1)(x2,y2)
    if(this.x1 > other.x2 || other.x1 > this.x2) //this  = l1.x&y, r1.x&y (x1,y1)(x2,y2)
    {      return false;    }
    
    if(this.y1 > other.y2 || other.y1 > this.y2)
    {      return false;    }
    
    else
    {
    return true;
    }
  }
  
  public void updateCol(int x, int y) //You pass in where the collision should now be and updates its location.
  {
    this.x1 = x; this.y1 = y;
    x2=x+w; y2=y+h;
  }
}