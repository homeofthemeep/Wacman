class RectCollision //Fixed with Cam's help, and Sean's a nice person
{

  public PShape rect;
  public int[] tl, br;
  public int x1, y1, x2, y2;
  public RectCollision(int x, int y, int w, int h)
  {
    rect = createShape(RECT, x, y, w, h);
    tl = new int[2]; br = new int[2];
    x1=x; y1=y; x2=x+w; y2=y+h;
  }
  
  public boolean isColliding(RectCollision other) // THIS WORKS!!!!
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
}


RectCollision r;
RectCollision x;

void setup()
{
  background(128);
  size(600, 600);
  r = new RectCollision(0,0, 50, 50);
  x = new RectCollision(10,10, 50, 50);
  System.out.println(x.isColliding(r)); 

}
void draw()
{
  shape(r.rect);
  shape(x.rect);
}