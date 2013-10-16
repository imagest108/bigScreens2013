  
   var  VerletPhysics2D = toxi.physics2d.VerletPhysics2D,
        VerletParticle2D = toxi.physics2d.VerletParticle2D,
        AttractionBehavior = toxi.physics2d.behaviors.AttractionBehavior,
        GravityBehavior = toxi.physics2d.behaviors.GravityBehavior,
        Vec2D = toxi.geom.Vec2D,
        Rect = toxi.geom.Rect;
  
//Particle.prototype = new toxi.physics2d.VerletParticle2D();
//Particle.prototype.constructor = Particle;

//Attractor.prototype = new toxi.physics2d.VerletParticle2D();
//Attractor.prototype.constructor = Attractor;

  
  
  import toxi.geom.*;
  import toxi.physics2d.*;
  import toxi.physics2d.behaviors.*;
  
  VerletPhysics2D physics;
  AttractionBehavior mouseAttractor;
  ArrayList<User> userList;
  User user;

  Vec2D mousePos;
  
  void setup() {
    size(screen.width, screen.height);
    // setup physics with 10% drag
    physics = new VerletPhysics2D();
    physics.setDrag(0.05);
    physics.setWorldBounds(new Rect(0, 0, width, height));
    // the NEW way to add gravity to the simulation, using behaviors
    //physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.15)));
    userList = new ArrayList<User>();
  
  }

  void addParticle(String id) {
   
   Vec2D randLoc = Vec2D.randomVector().scale(5).addSelf(width / 2, height/2);
   VerletParticle2D p = new VerletParticle2D(randLoc);
   physics.addParticle(p);
   console.log("Paricle number = "+physics.particles.length+","+id);
   
   user = new User(id, physics.particles.length);
   userList.add(user); 
   console.log(userList);

    // add a negative attraction force field around the new particle
   physics.addBehavior(new AttractionBehavior(p, 20, -1.2, 0.01))
  
  }



  void draw() {
    background(0,0,255);
    noStroke();
    fill(255);

    physics.update();
    
    for (int i=0;i<userList.size();i++) {
        //console.log(userList.get(i).id);
    }

  }
  
  void mousePressed() {
    //addParticle();
    mousePos = new Vec2D(mouseX, mouseY);
    // create a new positive attraction force field around the mouse position (radius=250px)
    mouseAttractor = new AttractionBehavior(mousePos, 250, 0.9);
    physics.addBehavior(mouseAttractor);
  }
  
  void mouseDragged() {
    // update mouse attraction focal point
    mousePos.set(mouseX, mouseY);
  }
  
  void mouseReleased() {
    // remove the mouse attraction when button has been released
    physics.removeBehavior(mouseAttractor);
  }

  class User {

    String id;
    int index;
    VerletParticle2D p;

    User(String _id, int _index){

        id = _id;
        index = _index;
        p = physics.particles.get(index-1);
    }

    void display(){

        console.log(p.x+" = p.x , "+p.y+" = p.y")

        fill(255);
        ellipse(p.x, p.y, 50, 50);
        fill(0);
        text(index, p.x, p.y);

    }


  }