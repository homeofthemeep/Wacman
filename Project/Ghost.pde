public class Ghost
{
  public int x, y, direction, maxHealth;
  public boolean[] types;
  public Node curNode, prevNode, targetNode;
  public RectCollision body;
  public int iter = 0;
  
  public Ghost(int x, int y, int wCol, int hCol, boolean[] b)
  {
    body = new RectCollision(width/2, height/2, wCol-1, hCol-1);
    this.x = x; this.y = y;  
    types = b;
    maxHealth = 3;
    direction = (int)random(0, 4);
  }
  
  public Ghost()
  {
  }
  
  public void show()
  {
    if(types[0] == true) //Blinky
    {
      fill(255,0,0);
      rect(x,y,49,49);
      fill(255);
    }
    
    if(types[1] == true) //Pinky
    {
      fill(255,192,192);
      rect(x,y,49,49);
      fill(255);
    }
    
    if(types[2] == true) //Inky
    {
      fill(0,255,255);
      rect(x,y,49,49);
      fill(255);
    }
    
    if(types[3] == true) //Clyde
    {
      fill(255,170,0);
      rect(x,y,49,49);
      fill(255);
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
  
  void spawn()
  {
    
    
    if(iter == 0 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[5].x1, board.nList[5].y1, 50, 50, new boolean[]{true, false, false, false});
      curNode = board.nList[5];
      iter++; return;
    }
    else if(gList[iter] != null)  {iter++; return;}
    
    if(iter == 1 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[6].x1, board.nList[6].y1, 50, 50, new boolean[]{false, true, false, false});
      curNode = board.nList[6];
      iter++; return;
    }
    else if(gList[iter] != null)  {iter++; return;}
    
    if(iter == 2 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[23].x1, board.nList[23].y1, 50, 50, new boolean[]{false, false, true, false});
      curNode = board.nList[23];
      iter++; return;
    }
    else if(gList[iter] != null)  {iter++; return;}
    
    if(iter == 3 && gList[iter] == null)
    {
      gList[iter] = new Ghost(board.nList[25].x1, board.nList[25].y1, 50, 50, new boolean[]{false, false, false, true});
      curNode = board.nList[25];
      iter = 0; return;
    }
    else if(gList[iter] != null)  {iter=0; return;}
    
  }
  
  public void move()
  {
    if(curNode != null)
    {
        direction = (int)random(0, 4);
        while(canMove(direction) == null)
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
    }
  }
  
  public Node canMove(int dir)
  {
    Node moveToNode = null;        
    for(int i = 0; i < curNode.neighbors.length; i++)
    {
      if(curNode.bools[i] == true && i == dir)  {  moveToNode = curNode.neighbors[i];  break;  }
    }
    return moveToNode;    
  }
  
  public int isHit()
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
  public void updateGhost()
  {
  
    int checker = ghost.isHit();
    if(checker != -1)
    {
      gList[checker].maxHealth--;
      if(gList[checker].maxHealth <= 0)
      {
        gList[checker] = null;
        ghostCounter--;
      }
      
    }
  }
}