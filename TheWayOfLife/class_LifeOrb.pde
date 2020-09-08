class LifeOrb{

    private PVector position = new PVector();
    public int life;
    private float acceleration;
    private int size = 10;
    private boolean grow = true;
    private boolean display = true;

    LifeOrb(){
        position.x = width;
        position.y = random(20, height - 300);
        acceleration = random(6, 10);
        life = int(random(20, 50));
    }

    void update(){
        position.x -= acceleration;
        if(display){
            heal();
        }
    }

    void show(){
        if(display){
            ellipseMode(CENTER);

            if(size == 20){
                grow = false;
            } else if(size == 5){
                grow = true;
            }

            if(grow){
                size++;
            } else {
                size--;
            }

            circle(position.x, position.y, size);
        }
    }

    void heal(){
        if(position.x >= mouseX+30 && position.x <= mouseX + 100
        && position.y >= mouseY    && position.y <= mouseY + 100){
            if(character.currentLife + life > 100){
                character.currentLife = 100;
            } else {
                character.currentLife += life;
            }
            display = false;
        }
    }
}