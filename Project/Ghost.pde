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
    maxHealth = 3;
    direction = (int)random(0, 4);
    if(types[0])
    {
      idle = new GhostAnim("blinky_big_anim", 2);
    }
    if(types[1])
    {
      idle = new GhostAnim("pinky_big_anim", 2);
    }
    if(types[2])
    {
      idle = new GhostAnim("inky_big_anim", 2);
    }
    if(types[3])
    {
      idle = new GhostAnim("clyde_big_anim", 2);
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
  
  void spawn() //This method spawns ghost of different types in different places
  {    
    //The method uses a var called iter to loop through the ghosts that are alive and not spawned
    if(iter>=4){iter--;}
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
        gList[checker] = null;
        ghostCounter--;
      }      
    }    
  }
  
  
}