public class Comet {
  float x;
  float y;
  int speed;
  PImage img;
  float alph;

  public Comet( float x, float y, int speed, PImage img ) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.img = img;
    this.alph = 0;
  }

  public void update() {
    alph-= 0.1;
    x -= speed;
    if ( x < - img.width/2 ) {
      reset();
    }
  }

  public void reset() {
    x = width + img.width/2;
    y = int( random( height - img.width ) + img.width/2);
  }

  public void draw() {
    pushMatrix();
    translate ( x, y );
    rotate( alph );
    image(img, -img.width/2, -img.height/2);
    popMatrix();
  }

  public Box getBox() {
    return new Box( x-img.width/2, y-img.height/2, x+img.width/2, y+img.height/2);
  }
}