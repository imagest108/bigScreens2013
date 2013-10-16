   var  VerletPhysics2D = toxi.physics2d.VerletPhysics2D,
        VerletParticle2D = toxi.physics2d.VerletParticle2D,
        AttractionBehavior = toxi.physics2d.behaviors.AttractionBehavior,
        GravityBehavior = toxi.physics2d.behaviors.GravityBehavior,
        Vec2D = toxi.geom.Vec2D,
        Rect = toxi.geom.Rect;
  
  import toxi.geom.*;
  import toxi.physics2d.*;
  import toxi.physics2d.behaviors.*;
  
  VerletPhysics2D physics;
  AttractionBehavior mouseAttractor;
  AttractionBehavior attractorSec1;
  AttractionBehavior attractorSec2; 
  AttractionBehavior attractorSec3;


  HashMap userMap;
  Vec2D mousePos;
  Iterator i;  // Get an iterator

  void setup() {
    size(900, 300);
    // setup physics with 10% drag
    physics = new VerletPhysics2D();
    physics.setDrag(0.05);
    physics.setWorldBounds(new Rect(0, 0, width, height));

    attractorSec1 = new AttractionBehavior(new Vec2D(width/6, height/2), -1.2, 0.01);
    attractorSec2 = new AttractionBehavior(new Vec2D(width/2, height/2), -1.2, 0.01);
    attractorSec3 = new AttractionBehavior(new Vec2D(width*4/6, height/2), -1.2, 0.01);
    

    userMap = new HashMap();

  }

  void addParticle(String id) {
   
   Vec2D randLoc = Vec2D.randomVector().scale(5).addSelf(width / 2, height/2);
   VerletParticle2D p = new VerletParticle2D(randLoc, 3);
   physics.addParticle(p);
   //console.log("Paricle number = "+physics.particles.length+","+id);
   
   userMap.put(id, (physics.particles.length));
   //console.log("HashMap: " +userMap.size());

    // add a negative attraction force field around the new particle
   physics.addBehavior(new AttractionBehavior(p, 20, -1.2, 0.01))
  
  }

  void setSection(String id, int sectionID) {
     
    Vec2D sec1loc = Vec2D.randomVector().scale(5).addSelf(width / 6, height/2);
    Vec2D sec2loc = Vec2D.randomVector().scale(5).addSelf(width / 2, height/2);
    Vec2D sec3loc = Vec2D.randomVector().scale(5).addSelf(width*4 / 6, height/2);
    

    i = userMap.entrySet().iterator();  // Get an iterator
    
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
        if (me.getKey() == id) {
           int tempIndex = me.getValue();
           //console.log(tempIndex-1);
        }
     }   
      if(sectionID == 1){
          physics.particles[tempIndex-1] = new VerletParticle2D(sec1loc, 3);
          physics.addBehavior(attractorSec1);
      }
      else if(sectionID == 2){
          physics.particles[tempIndex-1] = new VerletParticle2D(sec2loc, 3);
          physics.addBehavior(attractorSec2);
      }else if(sectionID == 3){
         physics.particles[tempIndex-1] = new VerletParticle2D(sec3loc, 3);
         physics.addBehavior(attractorSec3); 
      }
          //physics.addBehavior(attractorSec1);
      
      //console.log("Processing = User id: " + id +" , section: "+sectionID);

  }

  void draw() {
    background(0,0,255);
    noStroke();
    fill(255);

    physics.update();

    i = userMap.entrySet().iterator();  // Get an iterator
    while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
        drawUsers(me.getValue());
    }
  }

  void drawUsers(int index){

      VerletParticle2D p = physics.particles[index-1];
      fill(255);
      ellipse(p.x, p.y, 30, 30);
      fill(0);
      textSize(12);
      text(index, p.x, p.y); 

  }

  void removeUsers(String id){

    console.log(id + "is removed.");
    //userMap = userMap.remove(id);
    //console.log(userMap.size());

    i = userMap.entrySet().iterator();  // Get an iterator
    while (i.hasNext()) {
        Map.Entry me = (Map.Entry)i.next();
        if (me.getKey() == id) {
           i.remove();
        }
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
