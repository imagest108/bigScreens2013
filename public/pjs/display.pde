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
  Iterator i; 
  Vec2D core;  
  int margin = 100;
  Boolean kill1 = false;
  void setup() {
    size(11520, 1080);
    // setup physics with 10% drag
    physics = new VerletPhysics2D();
    physics.setDrag(0.05);
    physics.setWorldBounds(new Rect(margin, margin, width-margin, height-margin));
    userMap = new HashMap();

  }

  void addParticle(String id) {

   Vec2D randLoc = Vec2D.randomVector().scale(5).addSelf(width / 2, height/2);
   VerletParticle2D p = new VerletParticle2D(randLoc, 30);
   physics.addParticle(p);
   //console.log("Paricle number = "+physics.particles.length+","+id);
   
   userMap.put(id, (physics.particles.length));
   //console.log("HashMap: " +userMap.size());

    core = randLoc;
    natureF = new AttractionBehavior(core, 5, -1.2, 0.01);
    physics.addBehavior(natureF);
  
  }

  void setSection(String id, int sectionID) {
 

    Vec2D sec1loc = Vec2D.randomVector().scale(5).addSelf(width / 6, height/2);
    Vec2D sec2loc = Vec2D.randomVector().scale(5).addSelf(width / 2, height/2);
    Vec2D sec3loc = Vec2D.randomVector().scale(5).addSelf(width*5 / 6, height/2);
    
    attractorSec1 = new AttractionBehavior(sec1loc, -1.2, 0.01);
    attractorSec2 = new AttractionBehavior(sec2loc, -1.2, 0.01);
    attractorSec3 = new AttractionBehavior(sec3loc, -1.2, 0.01);
   


    i = userMap.entrySet().iterator();  // Get an iterator
    
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
        if (me.getKey() == id) {
           int tempIndex = me.getValue();
           //console.log(tempIndex-1);
        }
     }   
      if(sectionID == 1){

          core = sec1loc;
          natureF = new AttractionBehavior(core, 5, -1.2, 0.01);
          
          //physics.behaviors.clear();
          physics.addBehavior(natureF);
          
          //physics.addBehavior(attractorSec1);
          //physics.particles[tempIndex-1].setWorldBounds(new Rect(margin, margin, width / 3-margin, height-margin));
          physics.particles[tempIndex-1] = new VerletParticle2D(sec1loc, 30);
            

      }else if(sectionID == 2){

          core = sec2loc;
          natureF = new AttractionBehavior(core, 5, -1.2, 0.01);

          //physics.behaviors.clear();
          physics.addBehavior(natureF);
          //physics.addBehavior(attractorSec2);
          //physics.particles[tempIndex-1].setWorldBounds(new Rect(margin+ width /3, margin, width*2 / 3-margin, height-margin));
          physics.particles[tempIndex-1] = new VerletParticle2D(sec2loc, 30);
          

      }else if(sectionID == 3){

         core = sec3loc;
          natureF = new AttractionBehavior(core, 5, -1.2, 0.01);
          
          //physics.behaviors.clear();
          physics.addBehavior(natureF);
          //physics.addBehavior(attractorSec3); 
         //physics.particles[tempIndex-1].setWorldBounds(new Rect(width*2 /3+margin, margin, width-margin, height-margin));
         physics.particles[tempIndex-1] = new VerletParticle2D(sec3loc, 30);
         
      }
      
      //console.log("Processing = User id: " + id +" , section: "+sectionID);

  }

  void draw() {

    background(255);
    noStroke();
    fill(255);

    fill(140,21,15);
    rect(0, 0, width / 3, height);
    fill(255, 204, 0);
    rect(width /3, 0, width*2 / 3, height);
    fill(102, 0, 102);
    rect(width*2 /3, 0, width, height);
    
    physics.update();

    i = userMap.entrySet().iterator();  // Get an iterator
    
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
        
          if(kill1){
              
             /* if (me.getKey() == id) {
              i.remove();
              }*/
              killSec1(me.getKey(), me.getValue());

          }
              
          drawUsers(me.getValue()); 
          
       }

       //kill1 = false;
  }

  void setKill(int sectionID){
    
    if(sectionID == 1) {
      kill1 = true;  
      console.log(kill1);
    }      
    // if(sectionID == 2)
  }
  void killSec1(int index, string id){
    VerletParticle2D tempP = physics.particles[index-1];
    if(tempP.x > 0 && tempP.x < width/6){
      userMap.remove(id);
    } 
      kill1 = false;
    
    
  }

  void drawUsers(int index){

      VerletParticle2D tempP = physics.particles[index-1];

      fill(255);
      ellipse(tempP.x, tempP.y, 150, 150);
      fill(255,120,120);
      textSize(20);
      text(index, tempP.x, tempP.y); 

  }

  void removeUsers(String id){

    console.log(id + "is removed.");

    i = userMap.entrySet().iterator();  // Get an iterator
    while (i.hasNext()) {
        Map.Entry me = (Map.Entry)i.next();
        if (me.getKey() == id) {
           i.remove();
        }
    }
  }