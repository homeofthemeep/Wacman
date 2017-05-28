public Board board; // The board the game will be played on. The layout image can be found inside Board class.
public Ghost ghost; // This is a special ghost that will call relatively important stuff for all ghosts. This ghost is never put in the game.
public Player player; // This  is the player. I mean it's a  game right? You got to want to play it? Why am I explaining this!?!?!?
public Ghost[] gList; // This is the list of ghosts that will in the game serving as enemies to the player.

PImage gameOverBackground;
PImage gameMenuBackground;

int direction; // This is the direction the player is going in if inputed. 
int ghostCounter; //This is a good workaround that allows the code to keep track of which type of ghost it is spawning.
boolean checkRelease; //This checks to see if the keyPressed is now released. Limits inputd.
ArrayList<Bullet> bList;//This is the ArrayList of Bullets that the player will create into the world. We don't know how many bullets the player will create so we use an ArrayList.
boolean gameMode, gameOver=false;
boolean gameMenu=true;

void setup() // Pretty sure this is the entry point
{ 
  gameMenuBackground = loadImage("wacman_mainmenu.png");
  gameOverBackground = loadImage("wacman_gameover.png");
  checkRelease = true;
  direction = 2;
  ghostCounter = 0;
  
  bList = new ArrayList<Bullet>();
  board  = new Board();
  player = new Player(board.nList[7][5].x1,board.nList[7][5].y1,50,50); // Places the player in the near center of the board, on a node.
  
  ghost = new Ghost();
  gList = new Ghost[4];
  
  background(51);
  fullScreen();
  //board.show();
}

void draw()
{
  background(51);
  if(gameMenu==true)  image(gameMenuBackground,0,0);
    
  if(gameMode==true)
  {
    player.curNode = player.getNodeAtPos(); // I could put this in a new player method but this works fine. Constantly checks if the player is at a node and setting it.
    player.move(); //This method moves the player.
    board.updatePellet(); //This method checks to see if any pellets are picked up by the player
    ghost.updateGhost(); //The usefully useless "ghost" calls this method. Checks to see if a bullet hits a ghost
    board.show(); //Draws the board
    
    for(int i=0; i<bList.size(); i++) // Goes through the ArrayList of bullets. Moves them, updates them, then draws them.
    {
      if(bList.get(i)!=null)
      {
        bList.get(i).move();      
        bList.get(i).updateBullet();
        if(bList.get(i)!=null)//After update gotta make sure you are able to draw it
          bList.get(i).show();
      }  
    }
    if(frameCount % 180 == 0 && ghostCounter < 4 && gameMode==true)  {    ghost.spawn();  ghostCounter++;} //Spawns ghost on 5 sec intervals and maxes out at 4 ghosts.
    
    for(int i = 0; i < gList.length; i++)    if(gList[i] != null)    {      gList[i].curNode = gList[i].getNodeAtPos(i);  gList[i].move(); gList[i].show();    }  // Goes through the array of ghosts. Update their current nodes, moves them, then draws them.
    
    player.show();  //Draws the player.
   }
   if(gameOver==true)  image(gameOverBackground,0,0);
  
  
}

void keyPressed() //W,A,S,D movement. K is shoot. You can only shoot in the direction you are going in.
{
  if(key=='w' && checkRelease) {direction = 0;  player.changePos(direction); checkRelease = false;}
  if(key=='s' && checkRelease) {direction = 1;  player.changePos(direction); checkRelease = false;}
  if(key=='a' && checkRelease) {direction = 2;  player.changePos(direction); checkRelease = false;}
  if(key=='d' && checkRelease) {direction = 3;  player.changePos(direction); checkRelease = false;}  
  if(key=='k' && checkRelease) if(player.ammo>0){bList.add(new Bullet(player.x+25, player.y+25, player.direction)); player.ammo-=1;checkRelease=false;}
}

void keyReleased()//This method is responsible for making sure checkRelease works as intended and limits inputs.
{
  if(key=='w') {checkRelease = true;}
  if(key=='s') {checkRelease = true;}
  if(key=='a') {checkRelease = true;}
  if(key=='d') {checkRelease = true;}
  if(key=='k') {checkRelease = true;}
}

void mouseClicked()
{
  
  //mainmenu workers
  if(mouseX> 1040 && mouseX<1840 && mouseY> 300 && mouseY<400 && gameMenu==true) {  gameMenu=false;  gameMode=true; gameOver=false; } //play button
  if(mouseX> 1040 && mouseX<1840 && mouseY> 500 && mouseY<600 && gameMenu==true) { exit(); } //exit
  
  //gameover workers
  if(mouseX> 1040 && mouseX<1840 && mouseY> 300 && mouseY<400 && gameOver==true) {  gameMenu=false;  gameMode=true; gameOver=false;} //play button
  if(mouseX> 1040 && mouseX<1840 && mouseY> 500 && mouseY<600 && gameOver==true) {  gameMenu=true;  gameMode=false; gameOver=false; } //menu button
 
}