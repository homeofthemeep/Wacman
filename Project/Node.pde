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