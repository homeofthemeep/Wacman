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
  
  void move()
  {
    switch(bulletDir)
    {
      case 0: y-=10;break;
      case 1: y+=10;break;
      case 2: x-=10;break;
      case 3: x+=10;break;
    }
    bulletBody.updateCol(x,y);
    
  }
  void show()
  {
    fill(101,101,101);
    ellipse(x,y, 5, 5);
    fill(255);
  }
  
  void updateBullet()
  {
    /*
    int checker = ghost.isHit();
    if(checker!=-1)
    {
      bList.get(checker).bulletBody = null;
      bList.set(checker, null);
    }
    */
    
    int checker = board.isBulletTouchingWall(); //returns the index of the bullet that hits the wall
    if(checker!=-1 && bList.size()>0)
    {
      bList.set(checker, null);
    } 
  }
  
  
  
}