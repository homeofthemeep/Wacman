public class Player
{
  public int x, y, direction, storedDir, score, ammo;
  
  public Node curNode, prevNode, targetNode;
  RectCollision body;
  
  
  //CONSTRUCTOR
  public Player(int x, int y, int wCol, int hCol)
  {
    body = new RectCollision(width/2, height/2, wCol-1, hCol-1);
    this.x = x; this.y = y;  
    direction = 2;
    storedDir = 2;
    score = 0;
    changePos(direction);
  }
  //END CONSTUCTOR
  
  
  
  //SHOW
  void show()  {    rect(this.x, this.y, 49, 49);          }
  //END SHOW
  
  //Start out on this node:
  public void getFirstNode()
  {
    Node temp = getNodeAtPos();
    if(temp != null)    {      curNode = temp; curNode.setNeighbors(temp.neighbors);    }
    else                {      curNode = board.nList[5];    }
    //changePos(direction);
  }
  
  
  
  //Check which node the player is at in global space,
  public Node getNodeAtPos()
  {
    int checker = board.isOLappingNode();
    if(checker != -1)
    {
      return board.nList[checker];
    }
    return null;
  }
  
  public void changePos(int dir)
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
  
  public void move()
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
    }
    /*else
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
      
    }
    */
    if (targetNode != curNode && targetNode != null)
    {
      if(frameCount%2 == 0)
      switch(direction)
      {
        case 0: y-=5; break;
        case 1: y+=5; break;
        case 2: x-=5; break;
        case 3: x+=5; break;
      }
      body.updateCol(x,y);
    }
    
    if(board.isTouchingWall())
    {
      //System.out.println(board.isTouchingWall());
      if(frameCount%2 == 0)
      switch(direction)
      {
        case 0: y+=5; break;
        case 1: y-=5; break;
        case 2: x+=5; break;
        case 3: x-=5; break;
      }
      body.updateCol(x,y);
    }
  }
  
  //THIS MOVES THE CHARACTER TO ONE OF THE POSSIBLE NEIGHBORING NODES  
  public void moveToNode(int dir)
  {
    Node moveToNode = canMove(dir);
    if(moveToNode != null)  
    {
      player.x = moveToNode.x1;
      player.y = moveToNode.y1; 
      body.updateCol(x,y); 
      curNode = moveToNode;
      direction = dir;
      System.out.println("Player @ ("+ player.x + ", "+ player.y + ")");
    }
  }
  //THIS METHOD SUPPLEMENTS "void moveToNode(int dir)"
  public Node canMove(int dir)
  {
    Node moveToNode = null;        
    for(int i = 0; i < curNode.neighbors.length; i++)
    {
      if(curNode.bools[i] == true && i == dir)  {  moveToNode = curNode.neighbors[i];  break;  }
    }
    return moveToNode;    
  }
  /*
  public Node canMove(int dir)
  {
    Node moveToNode = null;        
    for(int i = 0; i < curNode.neighbors.length; i++)
    {
      if(curNode.bools[i] == true && i == dir)  {  moveToNode = curNode.neighbors[i];  break;  }
    }
    return moveToNode;    
  }
  */
  // THIS METHOD WILL FIND OUT IF THE PLAYER HAS OVERSHOT THE TARGET NODE THY WERE GOING TO
  public boolean overShotTarget()
  {
    float nodeToTarget = lengthFromNode (targetNode.x1, targetNode.y1);
    float nodeToSelf = lengthFromNode (player.x, player.y);
  
    return nodeToSelf > nodeToTarget;
  }
  //THIS METHOD FINDS OUT THE LENGTH BEWTEEN THE PREVIOUS NODE AND THE TARGET POSITION OF THE NEXT NODE
  public float lengthFromNode (int x, int y)
  {
    int tempX = x - prevNode.x1;
    int tempY = y - prevNode.y1;
    
    return sqrt(abs(sq(tempX)+sq(tempY)));
  }
  
  boolean isTouchingGhost()
  {
    for(int i =0; i<gList.length; i++)
    {
      if(gList[i]!=null && gList[i].body.isColliding(new RectCollision(player.body.x1+25, player.body.y1+25, 1, 1)))
      {
        return true;
      }
    }
    return false;
    
  }
}