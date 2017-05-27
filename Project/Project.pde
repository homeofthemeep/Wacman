public Board board;
public Ghost ghost;
public Player player;

int direction;
boolean checkRelease;

void setup()
{ 
  checkRelease = true;
  direction = 2;
  
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
  board.show();
  player.curNode = player.getNodeAtPos();
  player.move();
  player.show(); 
  
}

void keyPressed()
{
  if(key=='w' && checkRelease) {direction = 0;  player.changePos(direction); checkRelease = false;}
  if(key=='s' && checkRelease) {direction = 1;  player.changePos(direction); checkRelease = false;}
  if(key=='a' && checkRelease) {direction = 2;  player.changePos(direction); checkRelease = false;}
  if(key=='d' && checkRelease) {direction = 3;  player.changePos(direction); checkRelease = false;}  
}

void keyReleased()
{
  if(key=='w') {checkRelease = true;}
  if(key=='s') {checkRelease = true;}
  if(key=='a') {checkRelease = true;}
  if(key=='d') {checkRelease = true;}
}