// Original whale image from: https://sdwhalewatch.com/what-we-see/humpback-whale/
class Whale{
    private PVector position = new PVector();
    private int w;
    private int h;
    private float acceleration;
    public Animation whaleAnimation;
    public Animation glowAnimation;
    public RayWall rayWall;

    Whale(){
        whaleAnimation = new Animation(dataPath("") + "/whale/frameWhale", 6, 5);
        glowAnimation = new Animation(dataPath("") + "/whale/frameGlow", 6, 5);
        whaleAnimation.setTint(120,100,int(random(70,255)));
        position.x = width;
        position.y = random(20, height - 300);
        h = int(random(80, 120));
        w = h * 4;
        acceleration = random(3.5, 5.5);
        whaleAnimation.setSpriteSize(w, h);
        glowAnimation.setSpriteSize(w, h);
        rayWall = new RayWall(position.x, position.y+(0.4750 * h), position.x+(0.9313 * w), position.y+(0.5250 * h));
    }

    void update(){
        position.x -= acceleration;
        rayWall.update(position.x, position.y+(0.4750 * h), position.x+(0.9313 * w), position.y+(0.5250 * h));
    }

    void show(){
        whaleAnimation.display(position.x, position.y);
        glowAnimation.display(position.x, position.y);
    }

}
