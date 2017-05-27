public class Node extends RectCollision
{
  public boolean[] bools;
  public Node[] neighbors;
  
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
  public void setNeighbors(Node[] ne)
  {
    neighbors = new Node[ne.length];
    for(int i = 0; i < neighbors.length; i++)
    {
      neighbors[i] = ne[i];
    }
    setValDir();
  }
  /*
  public void getNeighbors()
  {
    neighbors = new Node[ne.length];
    for(int i = 0; i < neighbors.length; i++)
    {
      neighbors[i] = ne[i];
    }
    setValDir();
  }
  */
  public void setValDir()
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
  
  public boolean isOver(RectCollision other)
  { // other = l2.x&y, r2.x&y (x1,y1)(x2,y2)
    if(this.x1 == other.x1 && other.y1 == this.y1) //this  = l1.x&y, r1.x&y (x1,y1)(x2,y2)
    {      return true;    }
        
    else
    {
    return false;
    }
  }
  public void show()
  {
    fill(255,0,0);
    rect(super.x1,super.y1, super.w, super.h);
    fill(255);
  }
  
  public boolean[] getDir()
  {
    return bools;
  }
  

}