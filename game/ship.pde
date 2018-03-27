public class Ship {
  PImage img;
  int speed;
  int x;
  int y;

  public Ship( int x, int y, int speed, PImage img ) {
    this.speed = speed;
    this.x = x;
    this.y = y;
    this.img = img;
  }

  void draw() {
    pushMatrix();
    translate ( x, y );
    //image( img, -img.width/2, -img.height/2 );
    rotateZ(PI);
    rotateY(radians(65));
    shape(bo);
    popMatrix();
  }

  void up() {
    y -= speed;
    if ( y < img.height/2 ) { 
      y = img.height/2;
    }
  }
  
  void gravity() {
  y+=1;
  
  }

  void down() {
    y += speed;
    if ( y > height - img.height/2 +100) { 
      y = height - img.height/2 +100;
    }
  }

  public Box getBox() {
    return new Box( x - img.width/2, y-img.height/2, x+img.height/2, y+img.height/2);
  }
}