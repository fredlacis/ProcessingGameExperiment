
class Animation {

  //Source: https://processing.org/examples/animatedsprite.html

  PImage[] images;
  int imageCount;
  int frame;
  int imageWidth = 0;
  int imageHeight = 0;
  int frameSkip;
  color tintColor = 0;
  
  Animation(String imagePrefix, int count, int frameSkip) {
    imageCount = count;
    images = new PImage[imageCount];
    this.frameSkip = frameSkip;

    for (int i = 0; i < imageCount; i++) {
      String filename = imagePrefix + i + ".png";
      images[i] = loadImage(filename);
    }
  }

  void setTint(int r, int g, int b){
    tintColor = color(r,g,b);
  }

  void removeTint(){
    tintColor = 0;
  }

  boolean tintIsSet(){
    return tintColor != 0;
  }

  void setSpriteSize(int imageWidth, int imageHeight){
    this.imageHeight = imageHeight;
    this.imageWidth = imageWidth;
  }

  void display(float xpos, float ypos) {
    if(frameCount % frameSkip == 0){
        frame = (frame+1) % imageCount; 
    }

    if(tintColor != 0){
      tint(tintColor);
    }
    if(imageWidth != 0 && imageHeight != 0){
      image(images[frame], xpos, ypos, imageWidth, imageHeight);
    } else {
      image(images[frame], xpos, ypos);
    }
    noTint();
  }
  
  int getWidth() {
    return images[0].width;
  }
}