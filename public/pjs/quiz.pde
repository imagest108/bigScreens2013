import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

ArrayList<Particle> particles;
Attractor attractor;
int i=0;
VerletPhysics2D physics;
boolean moving = false;
String one="1",two="2",three="3";
void setup () {
  size (900, 300);
  physics = new VerletPhysics2D ();
  physics.setDrag (0.01);
  
  particles = new ArrayList<Particle>();
  //for (int i = 0; i < 50; i++) {
    //particles.add(new Particle(new Vec2D(random(width),random(height))));
  //}
  
  attractor = new Attractor(new Vec2D(width/2,height/2));
}


void draw () {
  background (255);  
  physics.update ();

  //attractor.display();
  
  for (Particle p: particles) {
      p.display();  
  }
  pushMatrix();
  noFill();
  stroke(0);
  rect(0, 0, 300, 300);
  rect(300, 0, 300, 300);
  rect(600, 0, 300, 300);
  popMatrix();
  pushMatrix();
  fill(0);
  textSize(150);
  text(one, 100,50,200,200);
  text(two, 400,50,200,200);
  text(three, 700,50,200,200);
  popMatrix();
  if (keyPressed) {
    attractor.lock();
    if(key == '1'){
      attractor.set((30 + width/3)/2,height/2);
    } else if(key =='2'){
      attractor.set((width/3 + (width*2/3))/2, height/2);
    } else if(key =='3'){
      attractor.set(((width*2/3) + (width-30))/2, height/2);
    }
  } else {
    attractor.unlock();
  }
}

void keyPressed(){
  if(key=='s' || key =='S'){
    particles.add(new Particle(new Vec2D(8+(i*8*2),height-30)));
    i++;
  }
  if(key =='j' || key =='J'){
    //attractor = new Attractor(new Vec2D(width/2,height/2));
  }
}

class Attractor extends VerletParticle2D {

  float r;

  Attractor (Vec2D loc) {
    super (loc);
    r = 24;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, width, 0.1));
  }

  void display () {
    fill(0);
    ellipse (x, y, r*2, r*2);
  }
}


class Particle extends VerletParticle2D {

  float r;

  Particle (Vec2D loc) {
    super(loc);
    r = 8;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, r*4, -1));
  }

  void addMoving(){
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, r*4, -1));
  }
  void display () {
    fill (127);
    stroke (0);
    strokeWeight(2);
    ellipse (x, y, r*2, r*2);
  }
}


