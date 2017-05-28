
public class Board
{
  PImage background; //The background image that is going to drawn.
  public int x,y,w,h;
  RectCollision[] colList; //An array of collisons that are bounds to stop the player and ghosts.
  Node[][] nList; // An array of nodes that the player and ghosts are moving through 
  Pellet[] pList; //An array of pellets that the player will be picking up
  
  public Board()
  {
    background = loadImage("wacman_layout1.png");
    colList = new RectCollision[64];
    nList = new Node[14][10];
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
    //NODES
    
    
      for(int c=0; c<nList[0].length; c++) //1st row
      {
        nList[0][c] = new Node((width/2-250+(c*50)), height/2-350, 49,49);//done 
      }
      for(int c=0; c<nList[1].length; c++) //2nd row
      {
        //if(!((width/2-250+(c*50))==50 ||(width/2-250+(c*50))==150 ||(width/2-250+(c*50))==200 ||(width/2-250+(c*50))==250 ||(width/2-250+(c*50))==300 ||(width/2-250+(c*50))==400))
        nList[1][c] = new Node((width/2-250+(c*50)), (height/2-350)+50, 49,49);//done
      }
      for(int c=0; c<nList[2].length; c++) //3rd row
      {
        nList[2][c] = new Node((width/2-250+(c*50)), (height/2-350)+100, 49,49);//done
      }
      for(int c=0; c<nList[3].length; c++) //4th row
      {
        if(!((width/2-250+(c*50))==50 ||(width/2-250+(c*50))==150 ||(width/2-250+(c*50))==200 ||(width/2-250+(c*50))==250 ||(width/2-250+(c*50))==300 ||(width/2-250+(c*50))==400))
        nList[3][c] = new Node((width/2-250+(c*50)), (height/2-350)+150, 49,49);//done
      }
      for(int c=0; c<nList[4].length; c++) //5th row
      {
        if(!((width/2-250+(c*50))==50 ||(width/2-250+(c*50))==150 ||(width/2-250+(c*50))==200 ||(width/2-250+(c*50))==250 ||(width/2-250+(c*50))==300 ||(width/2-250+(c*50))==400))
        nList[4][c] = new Node((width/2-250+(c*50)), (height/2-350)+200, 49,49); //done
      }
      for(int c=0; c<nList[5].length; c++) //6th row
      {
        nList[5][c] = new Node((width/2-250+(c*50)), (height/2-350)+250, 49,49); //done
      }
      for(int c=0; c<nList[6].length; c++) //7th row
      {
        if(!(((width/2-250+(c*50))==50||((width/2-250+(c*50))==50))))
        nList[0][c] = new Node((width/2-250+(c*50)), (height/2-350)+300, 49,49);//done
      }
      for(int c=0; c<nList[7].length; c++) //8th row
      {
        nList[7][c] = new Node((width/2-250+(c*50)), (height/2-350)+350, 49,49);//done
      }
      for(int c=0; c<nList[8].length; c++) //9th row
      {
        if(!(((width/2-250+(c*50))==50)||((width/2-250+(c*50))==100)||((width/2-250+(c*50))==150)||((width/2-250+(c*50))==250)||((width/2-250+(c*50))==300)||((width/2-250+(c*50))==350)||((width/2-250+(c*50)==400))))
        nList[8][c] = new Node((width/2-250+(c*50)), (height/2-350)+400, 49,49);//done
      }
      for(int c=0; c<nList[9].length; c++) //10th row
      {
        nList[9][c] = new Node((width/2-250+(c*50)), (height/2-350)+450, 49,49);//done
      }
      for(int c=0; c<nList[10].length; c++) //11th row
      {
        if(!(((width/2-250+(c*50))==50)||((width/2-250+(c*50))==100)||((width/2-250+(c*50))==150)||((width/2-250+(c*50))==200)||((width/2-250+(c*50))==300)||((width/2-250+(c*50))==350)||((width/2-250+(c*50)==400))))
        nList[10][c] = new Node((width/2-250+(c*50)), (height/2-350)+500, 49,49);//done
      }
      for(int c=0; c<nList[11].length; c++) //12th row
      {
        if(!(((width/2-250+(c*50))==50)||((width/2-250+(c*50))==400)))
        nList[11][c] = new Node((width/2-250+(c*50)), (height/2-350)+550, 49,49);//done
      }
      for(int c=0; c<nList[12].length; c++) //13th row
      {
        if(!((width/2-250+(c*50))==50 ||(width/2-250+(c*50))==150 ||(width/2-250+(c*50))==200 ||(width/2-250+(c*50))==250 ||(width/2-250+(c*50))==300 ||(width/2-250+(c*50))==400))
        nList[12][c] = new Node((width/2-250+(c*50)), (height/2-350)+600, 49,49);//done
      }
      for(int c=0; c<nList[13].length; c++) //14th row
      {
        nList[13][c] = new Node((width/2-250+(c*50)), (height/2-350)+650, 49,49);//done
      }
      
      
      //NEIGHBORS
      
    Node[] neighbors = new Node[4];
    neighbors[0] = null;
    neighbors[1] = null;
    neighbors[2] = null;
    neighbors[3] = null;
    for(int r = 0; r < nList.length; r++) // This loop draws each pellet
    {
      for(int c = 0; c < nList[r].length; c++) // This loop draws each pellet
      {
        if(r!=0  && nList[r-1][c]!=null) neighbors[0]=nList[r-1][c];
        if(r!=13 && nList[r+1][c]!=null) neighbors[1]=nList[r+1][c];
        if(c!=0  && nList[r][c-1]!=null) neighbors[2]=nList[r][c-1];
        if(c!=9  && nList[r][c+1]!=null) neighbors[3]=nList[r][c+1];
        if(nList[r][c]!=null)
        nList[r][c].setNeighbors(neighbors);
      }
      
    }
    
    
    
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
        pList[i] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2-350)+y, 8,8);
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
        pList[i+130] = new Pellet(width/2-250 + (i*50), height/2-350, (width/2-250 + (i*50))+x, (height/2+300)+y, 8,8);
    }
    //END PELLETS
  }
  
  
  
  //void setTheNeighbors()
 // {
    
    
    
  //}
  
  void show()
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
    for(int r = 0; r < nList.length; r++) // This loop draws each pellet
    {
      for(int c = 0; c < nList[r].length; c++) // This loop draws each pellet
      {
        if(nList[r][c] != null)
        nList[r][c].show();
      }
    }
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
        player.ammo+=5;
      }
      else
      {
        pList[checker] = null;
        player.score++;
        player.ammo+=1;
      }
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
  
  public int[] isOLappingNode() //This checks if the player is overlapping with a node. Returns the index of the node in the array of nodes declared above. Return -1 if none of them are.
  {
    for(int r = 0; r < nList.length; r++) // This loop draws each pellet
    {
      for(int c = 0; c < nList[r].length; c++) // This loop draws each pellet
      {
        if(nList[r][c] != null && nList[r][c].x1 == player.x && nList[r][c].y1 == player.y)
        {
          return new int[]{r,c};
        }
      }
    }
    return new int[]{-1,-1};
  }
  
  public int[] isGOLappingNode(int z)  //This checks if the ghost in the ghost array at int z is overlapping with a node. Returns the index of the node in the array of nodes declared above. Return -1 if none of them are.
  {
    for(int r = 0; r < nList.length; r++) // This loop draws each pellet
    {
      for(int c = 0; c < nList[r].length; c++) // This loop draws each pellet
      {
        if(nList[r][c] != null && nList[r][c].x1 == gList[z].x && nList[r][c].y1 == gList[z].y)
        {
          return new int[]{r,c};
        }
      }
  }
    return new int[]{-1,-1};
  }
  
}