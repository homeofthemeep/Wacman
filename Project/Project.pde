public Board board;
public Ghost ghost;
public Player player;

int direction;
boolean checkRelease;
ArrayList<Bullet> bList;
void setup()
{ 
  checkRelease = true;
  direction = 2;
  bList = new ArrayList<Bullet>();
  board  = new Board();
  player = new Player(board.nList[16].x1,board.nList[16].y1,50,50);
  
  player.getFirstNode();
  
  background(51);
  fullScreen();
  //board.show();
}

void draw()
{
  background(51);
  player.curNode = player.getNodeAtPos();
  player.move();
  board.updatePellet();
  board.show();
  player.show(); 
  System.out.println(player.score +" " + player.ammo);
  for(int i=0; i<bList.size(); i++)
  {
    if(bList.get(i)!=null)
    {
      bList.get(i).move();
      bList.get(i).show();
      bList.get(i).updateBullet();
    }  
  }
}

void keyPressed()
{
  if(key=='w' && checkRelease) {direction = 0;  player.changePos(direction); checkRelease = false;}
  if(key=='s' && checkRelease) {direction = 1;  player.changePos(direction); checkRelease = false;}
  if(key=='a' && checkRelease) {direction = 2;  player.changePos(direction); checkRelease = false;}
  if(key=='d' && checkRelease) {direction = 3;  player.changePos(direction); checkRelease = false;}  
  if(key=='k' && checkRelease) if(player.ammo>0){bList.add(new Bullet(player.x+25, player.y+25, player.direction)); player.ammo-=1;checkRelease=false;}
}

void keyReleased()
{
  if(key=='w') {checkRelease = true;}
  if(key=='s') {checkRelease = true;}
  if(key=='a') {checkRelease = true;}
  if(key=='d') {checkRelease = true;}
  if(key=='k') {checkRelease = true;}
}