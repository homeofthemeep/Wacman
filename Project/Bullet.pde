public class Bullet
{
  int x,y,bulletDir;
  RectCollision bulletBody;
  
  public Bullet(int x, int y, int direction)
  {
    bulletBody = new RectCollision(x,y,5,5);
    this.x=x;
    this.y=y;
    this.bulletDir = direction;
  }
  
  void move()//Move the bullet at break-neck speeds
  {
    switch(bulletDir)
    {
      case 0: y-=20;break;
      case 1: y+=20;break;
      case 2: x-=20;break;
      case 3: x+=20;break;
    }
    bulletBody.updateCol(x,y);
    
  }
  void show()
  {
    fill(0,255,0);
    ellipse(x,y, 8, 8);
    fill(255);
  }
  
  void updateBullet() //If the bullet hits a wall set the sucker to null
  {
    int checker = board.isBulletTouchingWall(); //returns the index of the bullet that hits the wall
    if(checker!=-1 && bList.size()>0)
    {
      bList.set(checker, null);
    } 
  }
      
}