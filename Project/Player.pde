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
    ammo = 6;
    changePos(direction);
  }
  //END CONSTUCTOR
        
  void show()  {    idle.display(this.x, this.y);          }//SHOW
          
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
      sboard.saveHighScore();
      setup();
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