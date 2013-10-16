var  VerletPhysics2D = toxi.physics2d.VerletPhysics2D,
     VerletParticle2D = toxi.physics2d.VerletParticle2D,
     AttractionBehavior = toxi.physics2d.behaviors.AttractionBehavior,
     GravityBehavior = toxi.physics2d.behaviors.GravityBehavior,
     Vec2D = toxi.geom.Vec2D,
     Rect = toxi.geom.Rect;  

Particle.prototype = new toxi.physics2d.VerletParticle2D();
Particle.prototype.constructor = Particle;

Attractor.prototype = new toxi.physics2d.VerletParticle2D();
Attractor.prototype.constructor = Attractor;


AttractionBehavior stageAttractor;

ArrayList<Particle> particles;
Particle p;
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
  for (int i = 0; i < 50; i++) {
    particles.add(new Particle(new Vec2D(random(width),random(height)),"00000"));
  }
  //stageAttractor = new AttractionBehavior(new Vec2D(mouseX,mouseY),-1, 0.01);
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.15)));
  attractor = new Attractor(new Vec2D(width/2,height/2));
}


void draw () {
  background (255);  
  physics.update ();

  //attractor.display();
  /*
  for (Particle p: particles) {
      p.addMoving();  
      p.display();
  }
*/
  //console.log("Running: " + frameCount);
  for(int i=0; i<particles.size(); i++){
  
        //particles.get(i).addMoving();
        particles.get(i).display();
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



void removeBall(String id){
  for(int i=0; i<particles.size(); i++){
  
    if(particles.get(i).getId() == id){
        particles.remove(i);
    }
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

class Attractor extends toxi.physics2d.VerletParticle2D {

  float r;
  Vec2D loc;
  Attractor (Vec2D _loc) {
    loc = new Vec2D(_loc.x, _loc.y);
    r = 24;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, width, 0.1));
  }

  void display () {
    fill(0);
    ellipse (loc.x, loc.y, r*2, r*2);
  }
}

void addUser(String id){

  p = new Particle(new Vec2D(random(0,width/5),height/3),id);
  particles.add(p);

}

class Particle extends toxi.physics2d.VerletParticle2D {

  float r;
  String id;
  Vec2D loc;

  Particle (Vec2D _loc, String _id) {

    id = _id;
    loc = new Vec2D(_loc.x, _loc.y);
    r = 8;
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior(this, r*4, -1));


  }
  void addMoving(){
    //physics.addParticle(this);
    //physics.addBehavior(new AttractionBehavior(this, r*4, -1));
  }
  void display () {
    fill (127);
    stroke (0);
    strokeWeight(2);
    ellipse (loc.x, loc.y, r*2, r*2);
  } 

  String getId(){
    return id;
  }

}


