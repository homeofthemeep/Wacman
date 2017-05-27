
public class Board
{
  PImage background;
  public int x,y,w,h;
  RectCollision[] colList;
  Node[] nList;
  //RectCollision temp;
  //RectCollision[] isTurnList;
  
  public Board()
  {
    background = loadImage("wacman_layout1.png");
    colList = new RectCollision[64];
    nList = new Node[64];
    
    //x = 0; y = 0; w = 1336; h = 50;    
    //colList[0] = new RectCollision(x,y,w,h);
    
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
    nList[20].setNeighbors(new Node[]{nList[20], null, nList[19], nList[21]});
    nList[21].setNeighbors(new Node[]{null, nList[24], nList[20], nList[22]});
    nList[22].setNeighbors(new Node[]{nList[18], nList[29], nList[21], null});
    
    nList[23].setNeighbors(new Node[]{null, nList[27], null, nList[24]});//Neighboring nodes from 6th line
    nList[24].setNeighbors(new Node[]{nList[21], null, nList[23], nList[25]});
    nList[25].setNeighbors(new Node[]{null, nList[28], nList[24], null});
    
    nList[26].setNeighbors(new Node[]{nList[19], null, null, nList[27]});//Neighboring nodes from 7th line
    nList[27].setNeighbors(new Node[]{nList[23], null, nList[26], nList[28]});
    nList[28].setNeighbors(new Node[]{nList[25], null, nList[27], nList[29]});
    nList[29].setNeighbors(new Node[]{nList[22], null, nList[28], null});
  }
  
  void show()
  {
    image(background, width/2-300, height/2-400);

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
    
  }
  
  public boolean isTouchingWall()
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
  
  public int isOLappingNode()
  {
    for(int i = 0; i < nList.length; i++)
    {
      if(nList[i] != null && nList[i].x1 == player.x && nList[i].y1 == player.y)//NullPointer expection
      {
        return i;
      }
    }
    return -1;
  }
  
}