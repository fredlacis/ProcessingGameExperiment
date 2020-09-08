class Enviroment{

  final int scl = 30;  
  final int w = 4000;
  final int h = 2000; 

  float flyingX = 0;
  float flyingY = 0;

  int cols;
  int rows;
  float[][] terrain;

  Enviroment(){
    cols = w / scl;
    rows = h / scl;
    
    terrain = new float[cols][rows];
  }
  
  void drawEnviroment(){
    //setBackground();
    drawSun();

    flyingX += 0.01;
    //flyingY -= 0.01;
    float yoff = flyingY; //Y Offset
    for (int y = 0; y < rows; y++) {
      float xoff = flyingX; //X Offset
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff,yoff), 0, 1, -200, 100);
        if(x <= cols*2){
          xoff += .1;
        } else {
          xoff -= .1;
        }
        
      }
      yoff += .1;
    }

    pushMatrix();

    translate(width/2, height/2 + 150);
    rotateX(PI/2.01);
    translate(-w/2, -h/2);
    
    for (int y = 0; y < rows-1; y++) {
      fill(map(y, 0, rows, 255, 255), map(y, 0, rows, 145, 230), map(y, 0, rows, 80, 230));  //Adding fog effect
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        //println("X: " + x + "| lastCol: " + lastCol);
        vertex(x*scl, y*scl, terrain[x][y]);
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      }
      endShape(CLOSE);
    }

    popMatrix();
  }

  void drawSun(){
    pushMatrix();
    translate(width/2, height/2 - 200, -2000);
    fill(255, 145, 0);
    noStroke();
    sphere(1000);
    popMatrix();
  }


  final int Y_AXIS = 1;
  final int X_AXIS = 2;

  void setBackground() {

    

    int x = -3000;
    int y = -2000;
    float w = width * 10;
    float h = height * 4;
    color c1 = color(200, 200, 255);
    color c2 = color(255, 145, 80);
    int axis = Y_AXIS;

    noFill();

    pushMatrix();
    translate(width / 2, height / 2, -2001);

    if (axis == Y_AXIS) { // Top to bottom gradient
      for (int i = y; i <= y + h; i++) {
        float inter = map(i, y, y + h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x + w, i);
      }
    } else if (axis == X_AXIS) { // Left to right gradient
      for (int i = x; i <= x + w; i++) {
        float inter = map(i, x, x + w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y + h);
      }
    }

    fill(0);
    rect(x, y, w, h);
    popMatrix();

    
  }


}
