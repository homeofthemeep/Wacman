import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project extends PApplet {



public Board board; // The board the game will be played on. The layout image can be found inside Board class.
public Ghost ghost; // This is a special ghost that will call relatively important stuff for all ghosts. This ghost is never put in the game.
public Player player; // This  is the player. I mean it's a  game right? You got to want to play it? Why am I explaining this!?!?!?
public Ghost[] gList; // This is the list of ghosts that will in the game serving as enemies to the player.
public Scoreboard sboard;
public SoundFile shoot, wacka, gDed, meDed, nextlvl, startup, mmmusic, gomusic;
PImage gameOverBackground;
PImage gameMenuBackground;

public Pellet lastpellet;
int framers;
int direction; // This is the direction the player is going in if inputed. 
int ghostCounter; //This is a good workaround that allows the code to keep track of which type of ghost it is spawning.
boolean checkRelease; //This checks to see if the keyPressed is now released. Limits inputd.
ArrayList<Bullet> bList;//This is the ArrayList of Bullets that the player will create into the world. We don't know how many bullets the player will create so we use an ArrayList.
boolean gameMode, gameOver=false;
boolean gameMenu=true;
float musicCounter, musicCounter2;

public void setup() // Pretty sure this is the entry point
{ 
  shoot = new SoundFile(this, "/sounds/shoot.wav");
  wacka = new SoundFile(this, "/sounds/dc.wav");
  gDed  = new SoundFile(this, "/sounds/tri.wav");
  meDed = new SoundFile(this, "/sounds/wacman_playerdeath.wav");
  nextlvl = new SoundFile(this, "/sounds/wacman_nextlevel.wav");
  startup = new SoundFile(this, "/sounds/wacman_startup.wav");
  mmmusic = new SoundFile(this, "/sounds/wacman_mainmenu_music.wav");
  gomusic = new SoundFile(this, "/sounds/wacman_gameover_music.wav");
  musicCounter = mmmusic.frames(); musicCounter2 = gomusic.frames();
  
  gameMenuBackground = loadImage("/data/images/wacman_mainmenu.png");
  gameOverBackground = loadImage("/data/images/wacman_gameover.png");
  checkRelease = true;
  direction = 2;
  ghostCounter = 0;
  framers = -179;
  
  bList = new ArrayList<Bullet>();
  board  = new Board();
  player = new Player(board.nList[16].x1,board.nList[16].y1,50,50); // Places the player in the near center of the board, on a node.
  sboard = new Scoreboard();
  
  ghost = new Ghost();
  gList = new Ghost[4];
  
  background(51);
  
  //board.show();
}

public void setup(int score) // Pretty sure this is the entry point
{ 
  shoot = new SoundFile(this, "/sounds/shoot.wav");
  wacka = new SoundFile(this, "/sounds/dc.wav");
  gDed  = new SoundFile(this, "/sounds/tri.wav");
  meDed = new SoundFile(this, "/sounds/wacman_playerdeath.wav");
  nextlvl = new SoundFile(this, "/sounds/wacman_nextlevel.wav");
  startup = new SoundFile(this, "/sounds/wacman_startup.wav");
  mmmusic = new SoundFile(this, "/sounds/wacman_mainmenu_music.wav");
  gomusic = new SoundFile(this, "/sounds/wacman_gameover_music.wav");
  musicCounter = mmmusic.frames(); musicCounter2 = gomusic.frames();
  
  gameMenuBackground = loadImage("/data/images/wacman_mainmenu.png");
  gameOverBackground = loadImage("/data/images/wacman_gameover.png");
  checkRelease = true;
  direction = 2;
  ghostCounter = 0;
  framers = -179;
  
  bList = new ArrayList<Bullet>();
  board  = new Board();
  player = new Player(board.nList[16].x1,board.nList[16].y1,50,50); // Places the player in the near center of the board, on a node.
  sboard = new Scoreboard();
  
  player.score = score;
  
  ghost = new Ghost();
  gList = new Ghost[4];
  
  background(51);
  fullScreen();
  //board.show();
}

public void draw()
{  
  background(51);
  if(gameMenu==true)  {image(gameMenuBackground,0,0); if((mmmusic.frames()/(60)) < musicCounter){mmmusic.play(); musicCounter = 0;} musicCounter+=12.5f;}
  
  if(gameMode==true && !board.ifWin())
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
        else
          bList.remove(i);
      }  
    }
    if(framers % 180 == 0 && ghostCounter < 4 )  {    ghost.spawn();  ghostCounter++; framers = -179;} //Spawns ghost on 5 sec intervals and maxes out at 4 ghosts.
    
    for(int i = 0; i < gList.length; i++)  
    {
      if(gList[i] != null)    
      {  
        gList[i].curNode = gList[i].getNodeAtPos(i);  
        gList[i].move(); 
        gList[i].show();
      }  // Goes through the array of ghosts. Update their current nodes, moves them, then draws them.
      
    }
    //if(!board.ifWin())
    player.show();  //Draws the player.
    sboard.show();
    framers++;
    
   }
   if(board.ifWin())
    {
      player.idle.display(lastpellet.x,lastpellet.y);
      nextlvl.play();
      delay((int)((nextlvl.duration()*1000)+250));
      setup(player.score);
    }
   if(gameOver==true)  {image(gameOverBackground,0,0); if((gomusic.frames()/(60)) < musicCounter2){gomusic.play(); musicCounter2 = 0;} musicCounter2+=12.5f;}
  
  
}

public void keyPressed() //W,A,S,D movement. K is shoot. You can only shoot in the direction you are going in.
{
  if(key==ESC)                 { exit();}
  if(key=='w' && checkRelease) {direction = 0;  player.changePos(direction); checkRelease = false;}
  if(key=='s' && checkRelease) {direction = 1;  player.changePos(direction); checkRelease = false;}
  if(key=='a' && checkRelease) {direction = 2;  player.changePos(direction); checkRelease = false;}
  if(key=='d' && checkRelease) {direction = 3;  player.changePos(direction); checkRelease = false;}  
  if(key=='k' && checkRelease) if(player.ammo>0){bList.add(new Bullet(player.x+25, player.y+25, direction)); player.ammo-=1;checkRelease=false; shoot.play();}
}

public void keyReleased()//This method is responsible for making sure checkRelease works as intended and limits inputs.
{
  if(key=='w') {checkRelease = true;}
  if(key=='s') {checkRelease = true;}
  if(key=='a') {checkRelease = true;}
  if(key=='d') {checkRelease = true;}
  if(key=='k') {checkRelease = true;}
}

public void mouseClicked()
{
  
  //mainmenu workers
  if(mouseX> 1040 && mouseX<1840 && mouseY> 300 && mouseY<400 && gameMenu==true) {  gameMenu=false;  gameMode=true; gameOver=false; mmmusic.stop(); startup.play(); delay((int)(startup.duration()*1000));} //play button
  if(mouseX> 1040 && mouseX<1840 && mouseY> 500 && mouseY<600 && gameMenu==true) {  exit(); } //exit
  
  //gameover workers
  if(mouseX> 1040 && mouseX<1840 && mouseY> 300 && mouseY<400 && gameOver==true) {  gameMenu=false;  gameMode=true; gameOver=false; gomusic.stop(); startup.play(); delay((int)(startup.duration()*1000));} //play button
  if(mouseX> 1040 && mouseX<1840 && mouseY> 500 && mouseY<600 && gameOver==true) {  gameMenu=true;  gameMode=false; gameOver=false; gomusic.stop();} //menu button
 
}
class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i+1, 1) + ".png";
      images[i] = loadImage(filename);
    }
  }

  public void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  public int getWidth() {
    return images[0].width;
  }
}

class GhostAnim extends Animation
{
  GhostAnim(String imagePrefix, int count)
  {
    super(imagePrefix, count);
    super.frame = 0;
  }
  
  public void display(float xpos, float ypos) {
    if(super.frame < 30)
    {
      image(images[0], xpos, ypos); frame++;
    }
    else
    {
      image(images[1], xpos, ypos); frame++;
    }
    if(super.frame > 60)
    {
      frame = 0;
    }
    
  }
}
/*
class PlayerAnim extends Animation
{
  PlayerAnim(String imagePrefix, int count)
  {
    super(imagePrefix, count);
    super.frame = 0;
  }
  
  void display(float xpos, float ypos) {
    if(super.frame < 6)
    {
      image(images[0], xpos, ypos); frame++;
    }
    else if(super.frame < 12)
    {
      image(images[1], xpos, ypos); frame++;
    }
    else if(super.frame < 18)
    {
      image(images[0], xpos, ypos); frame++;
    }
    else if(super.frame < 24)
    {
      image(images[1], xpos, ypos); frame++;
    }
    else if(super.frame < 30)
    {
      image(images[0], xpos, ypos); frame++;
    }
    else if(super.frame < 36)
    {
      image(images[2], xpos, ypos); frame++;
    }
    else if(super.frame < 42)
    {
      image(images[3], xpos, ypos); frame++;
    }
    else if(super.frame < 48)
    {
      image(images[2], xpos, ypos); frame++;
    }
    else if(super.frame < 54)
    {
      image(images[3], xpos, ypos); frame++;
    }
    else if(super.frame < 60)
    {
      image(images[2], xpos, ypos); frame++;
    }
    if(super.frame > 59)
    {
      frame = 0;
    }
    
  }
}
*/

public class Board
{
  PImage background; //The background image that is going to drawn.
  public int x,y,w,h;
  RectCollision[] colList; //An array of collisons that are bounds to stop the player and ghosts.
  Node[] nList; // An array of nodes that the player and ghosts are moving through 
  Pellet[] pList; //An array of pellets that the player will be picking up
  
  public Board()
  {
    background = loadImage("/data/images/wacman_layout1_det.png");
    colList = new RectCollision[64];
    nList = new Node[64];
    pList = new Pellet[140];
    
    //x = 0; y = 0; w = 1336; h = 50;    
    //colList[0] = new RectCollision(x,y,w,h);
    
    //The following the creation of all wall collisions. Credit to Wyatt for making this.
    colList[0] = new RectCollision(width/2-150, height/2-50, 299,49);
    colList[1] = new RectCollision(width/2, height/2+50, 199,49);
    colList[2] = new RectCollision(width/2-300, height/2-400, 599,49);//top
    colList[3] = new RectCollision(width/2-300, height/2-351, 49,750);//left
    colList[4] = new RectCollision(width/2-300, height/2-400+750, 599,49);//bottom
    colList[5] = new RectCollision(width/2-300+550, height/2-400, 49,799);//right
    colList[6] = new RectCollision(width/2-200, height/2+50, 149,49);//right
    colList[7] = new RectCollision(width/2-250, height/2-50, 49,49);
    colList[8] = new RectCollision(width/2-200, height/2-200, 49,99);
    colList[9] = new RectCollision(width/2-200, height/2-300, 49,49);
    colList[10] = new RectCollision(width/2-100, height/2-300, 199,49);
    colList[11] = new RectCollision(width/2+150, height/2-300, 49,49);
    colList[12] = new RectCollision(width/2+150, height/2-200, 49,99);//
    colList[13] = new RectCollision(width/2+200, height/2-50, 49,49);//
    colList[14] = new RectCollision(width/2-100, height/2-200, 199,99);//
    colList[15] = new RectCollision(width/2-200, height/2+150, 199,49);//
    colList[16] = new RectCollision(width/2-100, height/2-200, 199,99);//
    colList[17] = new RectCollision(width/2-200, height/2+150, 49,149);//
    colList[18] = new RectCollision(width/2+50, height/2+150, 149,49);//
    colList[19] = new RectCollision(width/2+150, height/2+150, 49,149);//
    colList[20] = new RectCollision(width/2-100, height/2+250, 199, 49);
    
    //The flowing set of lists are the nodes that are created for wacman to travel on. 
    nList[0] = new Node(width/2-250, height/2-350, 49,49);//top-line
    nList[1] = new Node(width/2-150, height/2-350, 49,49);
    nList[2] = new Node(width/2+100, height/2-350, 49,49);
    nList[3] = new Node(width/2+200, height/2-350, 49,49);
    
    nList[4] = new Node(width/2-250, height/2-250, 49,49);//2nd line
    nList[5] = new Node(width/2-150, height/2-250, 49,49);
    nList[6] = new Node(width/2+100, height/2-250, 49,49);
    nList[7] = new Node(width/2+200, height/2-250, 49,49);
    
    nList[8] = new Node(width/2-250, height/2-100, 49,49);//3rd line
    nList[9] = new Node(width/2-200, height/2-100, 49,49);
    nList[10] = new Node(width/2-150, height/2-100, 49,49);
    nList[11]= new Node(width/2+100, height/2-100, 49,49);
    nList[12]= new Node(width/2+150, height/2-100, 49,49);
    nList[13] = new Node(width/2+200, height/2-100, 49,49);
    
    nList[14] = new Node(width/2-250, height/2, 49,49);//4th line
    nList[15] = new Node(width/2-200, height/2, 49,49);
    nList[16] = new Node(width/2-50, height/2, 49,49);
    nList[17]= new Node(width/2+150, height/2, 49,49);
    nList[18]= new Node(width/2+200, height/2, 49,49);
    
    nList[19] = new Node(width/2-250, height/2+100, 49,49);//5th line
    nList[20] = new Node(width/2-50, height/2+100, 49,49);
    nList[21] = new Node(width/2, height/2+100, 49,49);
    nList[22]= new Node(width/2+200, height/2+100, 49,49);
    
    nList[23] = new Node(width/2-150, height/2+200, 49,49);//6th line
    nList[24] = new Node(width/2, height/2+200, 49,49);
    nList[25]= new Node(width/2+100, height/2+200, 49,49);
    
    nList[26] = new Node(width/2-250, height/2+300, 49,49);//7th line
    nList[27] = new Node(width/2-150, height/2+300, 49,49);
    nList[28] = new Node(width/2+100, height/2+300, 49,49);
    nList[29] = new Node(width/2+200, height/2+300, 49,49);
    
    //This following set of lists set the neighbors of each node. This is so that valid directions are found out from each node to it neighbors.
    //This was all done by hand
    nList[0].setNeighbors(new Node[]{null, nList[4], null, nList[1]});//Neighboring nodes from top line
    nList[1].setNeighbors(new Node[]{null, nList[5], nList[0], nList[2]});
    nList[2].setNeighbors(new Node[]{null, nList[6], nList[1], nList[3]});
    nList[3].setNeighbors(new Node[]{null, nList[7], nList[2], null});
    
    nList[4].setNeighbors(new Node[]{nList[0], nList[8], null, nList[5]});//Neighboring nodes from 2nd line
    nList[5].setNeighbors(new Node[]{nList[1], nList[10], nList[4], nList[6]});
    nList[6].setNeighbors(new Node[]{nList[2], nList[11], nList[5], nList[7]});
    nList[7].setNeighbors(new Node[]{nList[3], nList[13], nList[6], null});
    
    nList[8].setNeighbors(new Node[]{nList[4], null, null, nList[9]});//Neighboring nodes from 3rd line
    nList[9].setNeighbors(new Node[]{null, nList[15], nList[8], nList[10]});
    nList[10].setNeighbors(new Node[]{nList[5], null, nList[9], nList[11]});
    nList[11].setNeighbors(new Node[]{nList[6], null, nList[10], nList[12]});
    nList[12].setNeighbors(new Node[]{null, nList[17], nList[11], nList[13]});
    nList[13].setNeighbors(new Node[]{nList[7], null, nList[12], null});
    
    nList[14].setNeighbors(new Node[]{null, nList[19], null, nList[15]});//Neighboring nodes from 4th line
    nList[15].setNeighbors(new Node[]{nList[9], null, nList[14], nList[16]});
    nList[16].setNeighbors(new Node[]{null, nList[20], nList[15], nList[17]});
    nList[17].setNeighbors(new Node[]{nList[12], null, nList[16], nList[18]});
    nList[18].setNeighbors(new Node[]{null, nList[22], nList[17], null});
    
    nList[19].setNeighbors(new Node[]{nList[14], nList[26], null, nList[20]});//Neighboring nodes from 5th line
    nList[20].setNeighbors(new Node[]{nList[16], null, nList[19], nList[21]});
    nList[21].setNeighbors(new Node[]{null, nList[24], nList[20], nList[22]});
    nList[22].setNeighbors(new Node[]{nList[18], nList[29], nList[21], null});
    
    nList[23].setNeighbors(new Node[]{null, nList[27], null, nList[24]});//Neighboring nodes from 6th line
    nList[24].setNeighbors(new Node[]{nList[21], null, nList[23], nList[25]});
    nList[25].setNeighbors(new Node[]{null, nList[28], nList[24], null});
    
    nList[26].setNeighbors(new Node[]{nList[19], null, null, nList[27]});//Neighboring nodes from 7th line
    nList[27].setNeighbors(new Node[]{nList[23], null, nList[26], nList[28]});
    nList[28].setNeighbors(new Node[]{nList[25], null, nList[27], nList[29]});
    nList[29].setNeighbors(new Node[]{nList[22], null, nList[28], null});
    
    //PELLETS
    //I used some mental math to create some loops that accurately place pellets. THIS IS INCREDIBLY INNEFICIENT STILL. I use a lot less spaces in the array memory than I need. This was just quicker than doing it by hand like above.
    x = y = 21;
    for(int i = 0; i < 10; i++)
    {
      x=y=14;
      if(i==0 || i==9)
      {
        pList[i] = new BigPellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2-350)+y, 22,22);
        x=y=21;
      }
      else
      {
        x=y=21;
        pList[i] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2-350)+y, 8,8);
      }
    }
    for(int i = 0; i < 10; i++)
    {
      if(i != 1 && i != 3 && i != 4 && i != 5 && i != 6 && i != 8)
      pList[i+10] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2-300)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      pList[i+20] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2-250)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i != 1 && i != 3 && i != 4 && i != 5 && i != 6 && i != 8)
      pList[i+30] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2-200)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i != 1 && i != 3 && i != 4 && i != 5 && i != 6 && i != 8)
      pList[i+40] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2-150)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      pList[i+50] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2-100)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i == 1 || i == 8)
      pList[i+60] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2-50)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      pList[i+70] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i == 0 || i == 4 || i == 9)
      pList[i+80] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2+50)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      pList[i+90] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2+100)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i == 0 || i == 5 || i == 9)
      pList[i+100] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2+150)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i != 1 && i != 8)
      pList[i+110] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2+200)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      if(i == 0 || i == 2 || i == 7 || i == 9)
      pList[i+120] = new Pellet(width/2-250 + (i*50), height/2-300, (width/2-250 + (i*50))+x, (height/2+250)+y, 8,8);
    }
    for(int i = 0; i < 10; i++)
    {
      x=y=14;
      if(i==0 || i==9)
      {
        pList[i+130] = new BigPellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2+300)+y, 22,22);
        x=y=21;
      }
      else
      {
        x=y=21;
        pList[i+130] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2+300)+y, 8,8);
      }
    }
    //END PELLETS
  }
  
  public void show()
  {
    image(background, width/2-300, height/2-400);//Draws the image on the bottom
    //The following commented code is for debugging purposes. This draws the nodes and collision that have been made. Only do this for testing.
    /*
    for(int i = 0; i < colList.length; i++)
    {
      if(colList[i] != null)
        colList[i].show();
    }
    
    for(int i = 0; i < nList.length; i++)
    {
      if(nList[i] != null)
        nList[i].show();
    }
    */
    for(int i = 0; i < pList.length; i++) // This loop draws each pellet
    {
      if(pList[i] != null)
        pList[i].show();
    }
  }
  
  public boolean ifWin()
  {
    for(int i = 0; i < pList.length; i++)
    {
      if(pList[i]!=null)
      {
        lastpellet = pList[i];
        return false;     
      }
    }
    return true;
  }
  
  public void updatePellet() //Finds if any pellet on the board is picked up. Checks for bigPellets too.
  {
    int checker = isTouchingPellet();
    
    if(checker != -1)
    {
      if(checker==0 || checker==9 || checker == 130 || checker ==139)
      {
        
        pList[checker] = null;
        player.score+=10;
        player.ammo+=3;
      }
      else
      {
        pList[checker] = null;
        player.score++;
      }
      wacka.play();
    }
  }
  
  public boolean isTouchingWall() //Checks if the player is colliding with any wall.
  {
    for(int i = 0; i < colList.length; i++)
    {
      if(colList[i] != null && player.body.isColliding(colList[i]))
      {
        return true;
      }
    }
    return false;
  }
  
  public boolean isGhostTouchingWall() //Checks if any ghost is colliding with any wall.
  {
    for(int i = 0; i < colList.length; i++)
    {
      for(int z = 0; z< gList.length; z++)
      {
        if(colList[i] != null && gList[z] !=null && gList[z].body.isColliding(colList[i]))
        {  
          return true;
        }
      }
    }
    return false;
  }
  
  public int isBulletTouchingWall() // Checks if any bullet is colliding with any wall.
  {
    for(int i = 0; i < colList.length; i++)
    {
      for(int z = 0; z<bList.size(); z++)
      {
        if(colList[i] != null && bList.get(z)!=null&& bList.get(z).bulletBody.isColliding(colList[i]))
        {  
          return z;
        }
      }
    }
    return -1;
  }
  
  
  
  public int isTouchingPellet() //This checks if the player has touched any pellet. If so then return the index of the pellet in the array of pellets declared above. Return -1 if none of them are.
  {
    for(int i = 0; i < pList.length; i++)
    {
      if(pList[i] != null && player.body.isColliding(pList[i]))
      {
        return i;
      }
    }
    return -1;
  }
  
  public int isOLappingNode() //This checks if the player is overlapping with a node. Returns the index of the node in the array of nodes declared above. Return -1 if none of them are.
  {
    for(int i = 0; i < nList.length; i++)
    {
      if(nList[i] != null && nList[i].x1 == player.x && nList[i].y1 == player.y)
      {
        return i;
      }
    }
    return -1;
  }
  
  public int isGOLappingNode(int z)  //This checks if the ghost in the ghost array at int z is overlapping with a node. Returns the index of the node in the array of nodes declared above. Return -1 if none of them are.
  {
    for(int i = 0; i < nList.length; i++)
    {
      if(nList[i] != null && nList[i].x1 == gList[z].x && nList[i].y1 == gList[z].y)
      {
        return i;
      }
    }
    return -1;
  }
  
}
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
  
  public void move()//Move the bullet at break-neck speeds
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
  public void show()
  {
    fill(0,255,0);
    ellipse(x,y, 8, 8);
    fill(255);
  }
  
  public void updateBullet() //If the bullet hits a wall set the sucker to null
  {
    int checker = board.isBulletTouchingWall(); //returns the index of the bullet that hits the wall
    if(checker!=-1 && bList.size()>0)
    {
      bList.set(checker, null);
    } 
  }
      
}
public class Ghost
{
  public int x, y, direction, maxHealth; // Ghosts have health as they can be shot until they are nullified
  public boolean[] types; //This denotes whether the ghost is Blinky, Pinky, Inky, or Clyde
  public Node curNode, prevNode, targetNode; //These are the ingredients for the magic moving stuff
  public RectCollision body;
  public int iter = 0; // This is the iterator that goes over the different types of ghosts to spawn them.
  public Animation idle;
  
  //CONSTRUCTOR
  public Ghost(int x, int y, int wCol, int hCol, boolean[] b)
  {
    body = new RectCollision(width/2, height/2, wCol-1, hCol-1);
    this.x = x; this.y = y;  
    types = b;
    maxHealth = 1;
    direction = (int)random(0, 4);
    if(types[0])
    {
      idle = new GhostAnim("/data/images/blinky_big_anim", 2);
    }
    if(types[1])
    {
      idle = new GhostAnim("/data/images/pinky_big_anim", 2);
    }
    if(types[2])
    {
      idle = new GhostAnim("/data/images/inky_big_anim", 2);
    }
    if(types[3])
    {
      idle = new GhostAnim("/data/images/clyde_big_anim", 2);
    }
  }
  
  public Ghost()//Empty constructor for usefully useless "ghost"
  {
  }
  //END CONSTRUCTOR
  
  public void show()//Draws the ghost based on which type
  {
    if(types[0] == true) //Blinky
    {
      idle.display(x-3,y+1);
    }
    
    if(types[1] == true) //Pinky
    {
      idle.display(x-3,y+1);
    }
    
    if(types[2] == true) //Inky
    {
      idle.display(x-3,y+1);
    }
    
    if(types[3] == true) //Clyde
    {
      idle.display(x-3,y+1);
    }   
  }
  
  public Node getNodeAtPos(int z)
  {
    int checker = board.isGOLappingNode(z);
    if(checker != -1)
    {
      return board.nList[checker];
    }
    return null;
  }
  
  public void spawn() //This method spawns ghost of different types in different places
  {    
    //The method uses a var called iter to loop through the ghosts that are alive and not spawned
    if(iter>=4){iter--;}
    if(gList[3] == null){iter = 3;}
    if(gList[2] == null){iter = 2;}
    if(gList[1] == null){iter = 1;}
    if(gList[0] == null){iter = 0;}
    if(iter == 0 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[5].x1, board.nList[5].y1, 50, 50, new boolean[]{true, false, false, false}); //Spawns Blinky's
      curNode = board.nList[5];
      iter++; return;
    }
    else if(gList[iter] != null)  {iter++; return;}
    
    if(iter == 1 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[6].x1, board.nList[6].y1, 50, 50, new boolean[]{false, true, false, false}); //Spawns Pinky's
      curNode = board.nList[6];
      iter++; return;
    }
    else if(gList[iter] != null)  {iter++; return;}
    
    if(iter == 2 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[23].x1, board.nList[23].y1, 50, 50, new boolean[]{false, false, true, false}); //Spawns Inky's
      curNode = board.nList[23];
      iter++; return;
    }
    else if(gList[iter] != null)  {iter++; return;}
    
    if(iter == 3 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[25].x1, board.nList[25].y1, 50, 50, new boolean[]{false, false, false, true}); //Spawns Clyde's
      curNode = board.nList[25];
      iter = 0; return;
    }
    else if(gList[iter] != null)  {iter=0; return;}
    
    framers = 0; 
  }
  
  public void move()//Moves the ghost in 4 different random direction, uses magic
  {
    if(curNode != null)
    {
        direction = (int)random(0, 4);
        while(canMove(direction) == null)//Got to make sure the ghost can move in that random direction, this takes care of that
        {
          direction = (int)random(0, 4);
        }
    }
    if(frameCount%2 == 0)
    switch(direction)
    {
      case 0: y-=5; break;
      case 1: y+=5; break;
      case 2: x-=5; break;
      case 3: x+=5; break;
    }
    body.updateCol(x,y);
    
    if(board.isGhostTouchingWall())
    {
      if(frameCount%2 == 0)
      switch(direction)
      {
        case 0: y+=5; break;
        case 1: y-=5; break;
        case 2: x+=5; break;
        case 3: x-=5; break;
      }
      body.updateCol(x,y);
    }//if ghost is colliding with a wall push them back
  }
  
  public Node canMove(int dir)//Reuturns a valid node that the ghost wants to move to that is a neighbor from the ghost's current node. Returns null if there is no valid node in that direction
  {
    Node moveToNode = null;        
    for(int i = 0; i < curNode.neighbors.length; i++)
    {
      if(curNode.bools[i] == true && i == dir)  {  moveToNode = curNode.neighbors[i];  break;  }
    }
    return moveToNode;    
  }
  
  public int isHit() // This checks to see if a ghost is hit by a bullet. If the ghost is hit we remove the bullet from the game. Returns which ghost got hit
  {
    for(int i = 0; i < bList.size(); i++)
    {
      for(int z = 0; z < gList.length; z++)
      {
        if(bList.get(i) != null && gList[z] !=null && gList[z].body.isColliding(bList.get(i).bulletBody))
        {  
          bList.remove(i);
          return z;
        }
      }      
    }
    return -1;
  }
  
  public void updateGhost()//Called in draw. This method updates ghost health and "aliveness".
  {  
    int checker = ghost.isHit();
    if(checker != -1)
    {
      gList[checker].maxHealth--;
      if(gList[checker].maxHealth <= 0)
      {
        framers = -179;
        gList[checker] = null;
        ghostCounter--;
        player.score+=20;
        gDed.play();
      }      
    }    
  }
  
  
}
public class Node extends RectCollision
{
  public boolean[] bools;
  public Node[] neighbors;
  
  //CONSTRUCTOR
  public Node(int x, int y, int w, int h, boolean a, boolean b, boolean c, boolean d)
  {
    super(x,y,w,h);
    bools = new boolean[4];
    bools[0] = a;
    bools[1] = b;
    bools[2] = c;
    bools[3] = d;
  }
  
  public Node(int x, int y, int w, int h)
  {
    super(x,y,w,h);
    bools = new boolean[4]; 
    for(int i = 0; i < bools.length; i++)
    {
      bools[i] = false;
    }    
  }
  //END CONSTRUCTOR
  
  public void setNeighbors(Node[] ne)//This method sets the neighbors by passing in the hand made array of neighbors
  {
    neighbors = new Node[ne.length];
    for(int i = 0; i < neighbors.length; i++)
    {
      neighbors[i] = ne[i];
    }
    setValDir();
  }
  
  public void setValDir() //This sets the valid directions the player can go from this node.
  {        
    for(int i = 0; i < neighbors.length; i++)
    {
      //Node neighbor = neighbors[i];
      if(neighbors[i] != null)
      {        
        switch(i)
        {
          case 0: bools[0] = true; break;
          case 1: bools[1] = true; break;
          case 2: bools[2] = true; break;
          case 3: bools[3] = true; break;
        }
      }
      
    }
  }
  
  public boolean isOver(RectCollision other) //I don't know if this ever used but it checks overlapment. Refer to Board.isOLappingNode()
  { // other = l2.x&y, r2.x&y (x1,y1)(x2,y2)
    if(this.x1 == other.x1 && other.y1 == this.y1) //this  = l1.x&y, r1.x&y (x1,y1)(x2,y2)
    {      return true;    }
        
    else
    {
    return false;
    }
  }
  
  public void show()//Draws the node. THIS IS USUALLY NOT CALLED AS THEY ARE FOR VISUAL DEBUGGING PURPOSES.
  {
    fill(255,0,0);
    rect(super.x1,super.y1, super.w, super.h);
    fill(255);
  }
  
  public boolean[] getDir()//I don't know if this is used it will return the valid directions that have been setup thus far.
  {
    return bools;
  }
  

}
public class Pellet extends RectCollision
{
  PImage sprite;
  int x, y;
  
  public Pellet(int x, int y, int superX, int superY, int w, int h)
  {
    super(superX,superY,w,h);
    this.x = x; this.y = y;
    sprite = loadImage("/data/images/smallPellet.png");
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
    sprite = loadImage("/data/images/bigPellet.png");
  }
  
  public void show()//Going to be replaced with an image. 
  {    
    image(sprite, super.x1-14, super.y1-14);
  }
      
}
public class Player
{
  public int x, y, direction, storedDir, score, ammo;
  public GhostAnim idle;
  public Node curNode, prevNode, targetNode;
  RectCollision body;
  
  
  //CONSTRUCTOR
  public Player(int x, int y, int wCol, int hCol)
  {
    body = new RectCollision(width/2, height/2, wCol-1, hCol-1);
    idle = new GhostAnim("/data/images/wacman_big_anim", 2);
    this.x = x; this.y = y;  
    direction = 2;
    storedDir = 2;
    score = 0;
    ammo = 2;
    changePos(direction);
  }
  //END CONSTUCTOR
        
  public void show()  {    idle.display(this.x, this.y);          }//SHOW
          
  public Node getNodeAtPos()//Check which node the player is at in global space,
  {
    int checker = board.isOLappingNode();
    if(checker != -1)
    {
      return board.nList[checker];
    }
    return null;
  }
  
  public void changePos(int dir) //This method is responsible for storing a new direction if inputed 
  {
    if(dir != direction)  {storedDir = dir;}
    
    if(curNode != null)  
    {      
      Node moveToNode = canMove(dir);
      
      if(moveToNode != null)
      {
        while(moveToNode.bools[dir])
        {
          moveToNode = moveToNode.neighbors[dir];
        }
        direction = dir;
        targetNode = moveToNode;
        prevNode = curNode;
        curNode = null;
      }      
    }
  }
  
  public void move() //This method combines node-neighbor movement with 2d collision movement to get wacman to move correctly
  {
      if (curNode != null)
      {
        Node moveToNode = canMove(storedDir);
        if(moveToNode != null)
        {
            direction = storedDir;
            targetNode = moveToNode;
            prevNode = curNode;
            curNode = null;
        }
        if(frameCount%2 == 0)
        switch(direction)
        {
          case 0: y-=5; break;
          case 1: y+=5; break;
          case 2: x-=5; break;
          case 3: x+=5; break;
        }
        body.updateCol(x,y);
      }//This if branch makes wacman move, practically magic, I have no idea how I got this working...
      
      else
      {
        Node moveToNode = canMove(storedDir);
        if(moveToNode != null)
        {
            direction = storedDir;
            targetNode = moveToNode;
            prevNode = curNode;
            curNode = null;
        }
        if(frameCount%2 == 0)
        switch(direction)
        {
          case 0: y-=5; break;
          case 1: y+=5; break;
          case 2: x-=5; break;
          case 3: x+=5; break;
        }
        body.updateCol(x,y);        
      }//More magic
      
      if(board.isTouchingWall())
      {
        if(frameCount%2 == 0)
        switch(direction)
        {
          case 0: y+=5; break;
          case 1: y-=5; break;
          case 2: x+=5; break;
          case 3: x-=5; break;
        }
        body.updateCol(x,y);
      }//if player is colliding with a wall push them back
      
    if(player.isTouchingGhost())
    {
      meDed.play();
      sboard.saveHighScore();
      delay((int)(meDed.duration()*1000) + 100);
      setup(0);
      gameMode=false;
      gameOver=true;
    }
  }
  
  //THIS METHOD SUPPLEMENTS "void moveToNode(int dir)"
  public Node canMove(int dir)//Reuturns a valid node that the player wants to move to that is a neighbor from the player's current node. Returns null if there is no valid node in that direction
  {
    Node moveToNode = null;        
    if(curNode != null)
    for(int i = 0; i < curNode.neighbors.length; i++)
    {
      if(curNode.bools[i] == true && i == dir)  {  moveToNode = curNode.neighbors[i];  break;  }
    }
    return moveToNode;    
  }
    
  public boolean isTouchingGhost()//Check to see if player's center point is colliding with a ghost
  {
    for(int i =0; i<gList.length; i++)
    {
      if(gList[i]!=null && gList[i].body.isColliding(new RectCollision(player.body.x1+25, player.body.y1+25, 0, 0)))
      {
        return true;
      }
    }
    return false;
    
  }
}
public class Scoreboard
{
  PFont font;
  String[] str;
  int highscore;
  int r, g, b;
  boolean hsGame;
  public Scoreboard()
  {
    hsGame = false;
    str = new String[1];
    //this.x = x; this.y = y;
    font = createFont("/data/OCRAStd.otf", 32);
    textFont(font);
    str = loadStrings("/data/highscore.txt");
    highscore = PApplet.parseInt(str[0]);
    r = g = b = 255;
  }
  
  public void show()
  {  
    if(frameCount%10 == 0 && hsGame)
    {
      r = (int) random(0, 255);
      g = (int) random(0, 255);
      b = (int) random(0, 255);
      
      if(r < 128) {r = 0;} else{r = 255;}
      if(g < 128) {g = 0;} else{g = 255;}
      if(b < 128) {b = 0;} else{b = 255;}
      if(r < 128 && g < 128 && b < 128) {r=g=b=255;}
    }
    
    if(player.score > highscore)
    {
      hsGame = true;
      highscore = player.score;
      fill(r, g, b);
    }
    fill(r,g,b);
    text("HIGHSCORE: " + (highscore*10), width/2+400, height/2-200);
    
    fill(255);
    text("    SCORE: " + (player.score*10), width/2+400, height/2-168);    
    
    fill(255,255,0);
    text("     AMMO: " + (player.ammo), width/2+400, height/2-136); 
    
    fill(255);
  }
  
  public void saveHighScore()
  {
    str[0] = str(highscore);
    saveStrings("/data/highscore.txt", str);
  }
  public void saveHighScore(int z)
  {
    str[0] = str(z);
    saveStrings("/data/highscore.txt", str);
  }
  
  
}
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
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
