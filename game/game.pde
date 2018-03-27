PShape bo;
Starfield starfield;
Comet comet;
Comet comet2;
Comet comet3;
Ship ship;
Torpedo torpedo;
PImage boom;


import processing.sound.*;
SoundFile soundfile;
SoundFile soundfile2;

int boom_count = 0;
int comet_boom_count = 0;

int boom2_count = 0;
int comet2_boom_count = 0;

int boom3_count = 0;
int comet3_boom_count = 0;

boolean gameOver = false;

void setup() {
  size(640, 480, P3D);
  starfield = new Starfield( 100 );
  PImage cimg = loadImage( "dorito.gif" );
  comet = new Comet( width + cimg.width/2, height*0.25, 4, cimg );
  comet2 = new Comet( width + cimg.width/2, height*0.75, 3, cimg );
  comet3 = new Comet( width + cimg.width/2, height*0.95, 5, cimg );



  PImage simg = loadImage( "shipcopy.png" );
  ship = new Ship( 100, height/2, 3, simg );
  bo = loadShape ("plane.obj");
  bo.scale(20); 
  shapeMode(CENTER);

  boom = loadImage( "boom.gif" );
  torpedo = new Torpedo(20, 10, 240);
  torpedo.active = false;

  frameRate( 25 );
  smooth();
  soundfile = new SoundFile(this, "shootsound.wav");
  soundfile2 = new SoundFile(this, "explosion2.wav");
}



void draw() {
  background(0);
  lights();

  if (!gameOver) {
    starfield.draw();
    torpedo.update();
    torpedo.draw();
    ship.gravity();

    if ( boom_count == 0 && boom2_count==0 ) {
      if ( keyPressed == true && key == CODED ) {
        if ( keyCode == UP ) {
          ship.up();
        } else if ( keyCode == DOWN ) {
          ship.down();
        }
      }
      ship.draw();
    } else {
      image( boom, ship.getBox().x1, ship.getBox().y1 );
      comet.reset();
      comet2.reset();
      comet3.reset();
      boom_count--;
      boom2_count--;
      boom3_count--;
      gameOver = true;
      boom_count=0;
      boom2_count=0;
      boom3_count=0;
    }

    checkComet();
    checkComet2();
    checkComet3();
  } else {
    background(0);
    //show soemthing here
  }

  println(gameOver);
}




void checkComet() {
  if ( ship.getBox().isOverlap( comet.getBox())) {
    boom_count = 25;
  }
  if ( torpedo.active && comet.getBox().isOverlap( torpedo.getBox())) {
    comet_boom_count = 25;
    torpedo.active = false;
    soundfile2.play();
  }
  if ( comet_boom_count == 0 ) {
    comet.update();
    comet.draw();
  } else if ( comet_boom_count == 1 ) {   
    comet.reset();
    comet_boom_count--;
  } else {
    image( boom, comet.getBox().x1, comet.getBox().y1);
    comet_boom_count--;
  }
}


void checkComet3() {
  if ( ship.getBox().isOverlap( comet2.getBox())) {
    boom_count = 25;
  }
  if ( torpedo.active && comet2.getBox().isOverlap( torpedo.getBox())) {
    comet2_boom_count = 25;
    torpedo.active = false;
    soundfile2.play();
  }
  if ( comet2_boom_count == 0 ) {
    comet2.update();
    comet2.draw();
  } else if ( comet2_boom_count == 1 ) {   
    comet2.reset();
    comet2_boom_count--;
  } else {
    image( boom, comet2.getBox().x1, comet2.getBox().y1);
    comet2_boom_count--;
  }
}

void checkComet2() {
  if ( ship.getBox().isOverlap( comet3.getBox())) {
    boom_count = 25;
  }
  if ( torpedo.active && comet3.getBox().isOverlap( torpedo.getBox())) {
    comet3_boom_count = 25;
    torpedo.active = false;
    soundfile2.play();
  }
  if ( comet3_boom_count == 0 ) {
    comet3.update();
    comet3.draw();
  } else if ( comet3_boom_count == 1 ) {   
    comet3.reset();
    comet3_boom_count--;
  } else {
    image( boom, comet3.getBox().x1, comet3.getBox().y1);
    comet3_boom_count--;
  }
}
void keyPressed() {
  if ( key == ' ' && !torpedo.active ) {
    soundfile.play(); 
    torpedo.x = ship.x+85;// + ship.img.width/2 - 20;
    torpedo.y = ship.y-ship.img.height/2-30;
    torpedo.active = true;
  }

  // restart
  if (key=='s') {
    gameOver=!gameOver;
  }
}