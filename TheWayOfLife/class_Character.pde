class Character{

  public final int totalLife = 100;

  public int currentLife = 100;
  public boolean isDead = false;

  private PVector position = new PVector(mouseX,mouseY);

  public Animation animation;

  public RayWall rayWall;

  private int damageTimestamp;

  Character(){
      animation = new Animation(dataPath("") + "/character/frame", 8, 3);

      rayWall = new RayWall(position.x+40, position.y+55, position.x+109, position.y+30);
      rayWall.setId("charWall");

      damageTimestamp = millis();
  }

  void addDamageDelay(int delay){
    damageTimestamp = millis() + (delay * 1000);
  }

  void update(PVector pos){
      position.x = pos.x;
      position.y = pos.y;
      rayWall.update(position.x+40, position.y+55, position.x+109, position.y+30);
  }

  void show() {
    animation.display(position.x, position.y);
  }

  void damage(int amount){
    if((millis() - damageTimestamp >= 1000)){
      currentLife -= amount;
      damageTimestamp = millis();
    }

    if(currentLife <= 0){
      isDead = true;
    }
  }

}