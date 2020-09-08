ArrayList<RayWall> walls;
ArrayList<Whale> whales;
ArrayList<LifeOrb> orbs;
RayEmitter emitter;
LifeOrb lifeOrb;
/// The Character
Character character;
/// Timestamps to calculate timed events
int whaleSpawnTimestamp;
int orbSpawnTimestamp;

void setupGameplay(){
  hint(ENABLE_STROKE_PERSPECTIVE);
  hint(DISABLE_OPTIMIZED_STROKE);

  whaleSpawnTimestamp = millis();
  orbSpawnTimestamp = millis();

  //Setting up character
  character = new Character();
  
  //Setting up walls
  walls = new ArrayList<RayWall>();
  walls.add(new RayWall(width+1, 0, width+1, height));
  walls.add(new RayWall(width, height, 0, height));
  walls.add(new RayWall(-1, height, -1, 0));
  
  // walls.add(new RayWall(600, 200, 1000, 230));

  //Setting up ray emitter
  emitter = new RayEmitter();
  emitter.update(width/2, -750);

  //Setting up whales
  whales = new ArrayList<Whale>();
  whales.add(new Whale());
  walls.add(whales.get(0).rayWall);

  //Setting up orbs
  orbs = new ArrayList<LifeOrb>();

  walls.add(character.rayWall);
}

void drawGameplay(){
  noCursor();

  emitter.show();
  emitter.look(walls);
  walls.remove(character.rayWall);

  character.update(easeMouseMovement());
  character.show();

  whalesHandler();

  orbsHandler();

  drawHUD();

  if(character.currentLife == 0){
    currentGameState = GameStates.Died;
  }

  if(GOD_MODE == true){
    character.currentLife = 100;
  }

  walls.add(character.rayWall);
}

void orbsHandler(){
  if (timePassed(orbSpawnTimestamp, 20)){
    LifeOrb newOrb = new LifeOrb();
    orbs.add(newOrb);
    orbSpawnTimestamp = millis();
  }

  for (int i = orbs.size() - 1; i >= 0; i--) {
    if(orbs.get(i).position.x < -10){
      if(orbs.remove(orbs.get(i)) && DEBUG_MODE){
        println("LifeOrb removed");
      }
    } else {
      orbs.get(i).update();
      orbs.get(i).show();
    }
  }
}

void whalesHandler(){
  if (timePassed(whaleSpawnTimestamp, 8)){
    Whale newWhale = new Whale();
    whales.add(newWhale);
    walls.add(newWhale.rayWall);
    whaleSpawnTimestamp = millis();
  }

  for (int i = whales.size() - 1; i >= 0; i--) {
    if(whales.get(i).position.x < 0 - whales.get(i).w){
      if(walls.remove(whales.get(i).rayWall) && DEBUG_MODE){
        println("Whale wall removed");
      }
      if(whales.remove(whales.get(i)) && DEBUG_MODE){
        println("Whale removed");
      }
    } else {
      whales.get(i).update();
      whales.get(i).show();
    }
  }
}

float x;
float y;
float easing = 0.05;
PVector easeMouseMovement(){
    float targetX = mouseX;
    float dx = targetX - x;
    x += dx * easing;
    
    float targetY = mouseY;
    float dy = targetY - y;
    y += dy * easing;

    return new PVector(x, y);
}

boolean timePassed(int timestamp, int seconds){
    if((millis() - timestamp >= seconds*1000)){
      return true;
    } 
    return false;
}

void drawHUD(){
  noStroke();
  fill(0,65,100);
  rect(width/2-206/2, 5, 206, 21);
  fill(0,130,210);
  rect(width/2-200/2, 8, map(character.currentLife, 0, 100, 0, 200), 15);
}