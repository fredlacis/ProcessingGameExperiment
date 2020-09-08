class RayWall {
  PVector a, b;
  String id = null;
  RayWall(float x1, float y1, float x2, float  y2) {
    this.a = new PVector(x1, y1);
    this.b = new PVector(x2, y2);
  }

  void setId(String id){
    this.id = id;
  }

  String getId(){
    return this.id;
  }
  
  void update(float x1, float y1, float x2, float  y2){
    this.a.x = x1;
    this.a.y = y1;
    this.b.x = x2;
    this.b.y = y2;
  }
  
  void show() {
    stroke(255);
    strokeWeight(1);
    line(this.a.x, this.a.y, this.b.x, this.b.y);
  }
}

class Ray {
  PVector pos, dir;
  Ray(PVector _pos, float angle) {
    this.pos = _pos;
    this.dir = PVector.fromAngle(angle);
  }

  void lookAt(float x, float y) {
    this.dir.x = x - this.pos.x;
    this.dir.y = y - this.pos.y;
    this.dir.normalize();
  }

  void show() {
    //stroke(255);
    // strokeWeight(15);
    pushMatrix();
    translate(this.pos.x, this.pos.y);
    line(0, 0, this.dir.x * 10, this.dir.y * 10);
    popMatrix();
  }

  PVector cast(RayWall wall) {
    float x1 = wall.a.x;
    float y1 = wall.a.y;
    float x2 = wall.b.x;
    float y2 = wall.b.y;

    float x3 = this.pos.x;
    float y3 = this.pos.y;
    float x4 = this.pos.x + this.dir.x;
    float y4 = this.pos.y + this.dir.y;

    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) {
      return null;
    }

    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
    if (t > 0 && t < 1 && u > 0) {
      PVector pt = new PVector();
      pt.x = x1 + t * (x2 - x1);
      pt.y = y1 + t * (y2 - y1);
      return pt;
    } else {
      return null;
    }
  }
}

class RayEmitter {
  PVector pos;
  Ray[] rays;
  RayEmitter() {
    this.pos = new PVector(width / 2, height / 2);
    this.rays = new Ray[360];
    for (int a = 0; a < this.rays.length; a += 1) {
      this.rays[a] = new Ray(this.pos, radians(a));
    }
  }

  void update(float x, float y) {
    this.pos.set(x, y);
  }

  void look(ArrayList<RayWall> walls) {
    for (int i = 0; i < this.rays.length; i++) {
      Ray ray = this.rays[i];
      PVector closest = null;
      float record = 500000000;
      for (RayWall wall : walls) {
        PVector pt = ray.cast(wall);
        if (pt != null) {
          float d = PVector.dist(this.pos, pt);
          if (d < record) {
            record = d;
            closest = pt;
            if(wall.getId() != null){
              character.damage(5);
            } 
          }
        }
      }
      if (closest != null) {
        colorMode(HSB);
        int n = (i + frameCount * 2) % 360;
        if(n <= 360/2){
          n = (int)map(n, 0, 360, 0, 255);
        } else {
          n = (int)map(n, 0, 360, 255, 0);
        }
        stroke(30, n, 255, 35); 
        strokeWeight(15);
        line(this.pos.x, this.pos.y, closest.x, closest.y);
        colorMode(RGB);
      }
    }
  }

  void show() {
    for (Ray ray : this.rays) {
      ray.show();
    }
  }
}
