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

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
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
  
  void display(float xpos, float ypos) {
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