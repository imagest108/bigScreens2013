ArrayList<Ball> blist;
int population;
boolean jump = false, move1 = false; 
int random1, random2, random3;
void setup(){
  //population = 1;
  size(screen.width, screen.height);
  frameRate(30);
  ellipseMode(RADIUS);
  blist = new ArrayList<Ball>();
  
  // for(int i = 0; i<population; i++){
  //   blist.add(new Ball(10 +(i*10*2), height/2));
  // }
  //b = new Ball(width/2, height-4);

}

void draw(){
  background(255,0,0);

  population = userObjs.length();
  for(int i = 0; i<population; i++){
    blist.add(new Ball(userObjs[i].objectX, userObjs[i].objectY));
  }

   for(int i=0; i<blist.size(); i++){
     //blist.get(i).display();
      if(blist.get(i).getY() > height-4){
        blist.get(i).setReverse();
      } else if(blist.get(i).getY() < 4){
        blist.get(i).setStop();
        jump = false;
      }
     blist.get(i).display();
   }
   ///blist.get(random1).update();
   ///blist.get(random2).update();
   ///blist.get(random3).update();
   
   //blist.get(2).display();
   //b.jump();
}

void keyPressed(){
  if(key == 'j'){
    jump = true; 
    random1 = (int)random(1, blist.size()-1);
    random2 = (int)random(0, blist.size()-1);
    random3 = (int)random(0, blist.size()-1);
  } 
   
}

class Ball{
  
  int rad;
  //float xpos, ypos;
  PVector loc;
  PVector vel;
  //float yspeed;
  int ydirection;

  

  Ball(float x, float y){
    rad = 30;
    //xpos = x;
    //ypos = height/2;
    loc = new PVector(x, y);
    //yspeed = 5.0;
    vel = new PVector(0.0, 5.0);
    ydirection = 1;
  }

  void jump(){
   
    update();
    display();
    
  }
  
  void update(){
    //ypos = ypos + ( yspeed * ydirection);
   
    if(jump){
        
      //vel.y = vel.y * ydirection;
      loc.y = loc.y + (vel.y *ydirection);
    }  
  }
  
  void display(){
    //background(0);
    fill(255);
    ellipse(loc.x, loc.y, rad, rad);
  }
  void setReverse(){
    ydirection = -1;
  }
  
  void setStop(){
    loc.y = height-rad;
    ydirection = 0;
    
  }
  float getY(){
    return loc.y;
  }
  
  float getX(){
    return loc.x;
  }
  int getRad(){
    return rad;
  }
  

}
