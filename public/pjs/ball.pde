ArrayList<Ball> blist;
Ball b; 
int population;
boolean isjumping = false, move1 = false; 
int random1, random2, random3;
void setup(){

  size(screen.width, screen.height);
  frameRate(30);
  ellipseMode(RADIUS);
  blist = new ArrayList<Ball>();
  
  population = userObjs.length();

}

void draw(){
  background(255,0,0);

   for(int i=0; i<blist.size(); i++){
     //blist.get(i).display();
      if(blist.get(i).getY() > height-4){
        blist.get(i).setReverse();
      } else if(blist.get(i).getY() < 4){
        blist.get(i).setStop();
        isjumping = false;
      }
     blist.get(i).display();
   }
   ///blist.get(random1).update();
   ///blist.get(random2).update();
   ///blist.get(random3).update();
   
   //blist.get(2).display();
   //b.jump();
}

void makeJump(String id){

  for(int i=0; i<blist.size(); i++){
  
    if(blist.get(i).getId() == id){
        blist.get(i).isjumping = true;   
      }

    blist.get(i).update();  
    blist.get(i).display(); 
   }
}


void keyPressed(){
  if(key == 'j'){
    isjumping = true; 
    random1 = (int)random(1, blist.size()-1);
    random2 = (int)random(0, blist.size()-1);
    random3 = (int)random(0, blist.size()-1);
  } 
   
}

void addBall(int x, int y, String id){

  b = new Ball(x,y,id);
  blist.add(b);

}

void removeBall(String id){
  for(int i=0; i<blist.size(); i++){
  
    if(blist.get(i).getId() == id){
        blist.remove(i);
    }

  blist.get(i).update();  
  blist.get(i).display(); 
  
  }
}



class Ball{

  String id;
  
  int rad;
  //float xpos, ypos;
  PVector loc;
  PVector vel;
  //float yspeed;
  int ydirection;
  boolean isJumping;
  

  Ball(float x, float y, String bid){
    rad = 30;
    //xpos = x;
    //ypos = height/2;
    loc = new PVector(x, y);
    //yspeed = 5.0;
    vel = new PVector(0.0, 5.0);
    ydirection = 1;

    id = bid;
    isJumping = false;
  }

  void jump(){
   
    update();
    display();
    
  }
  
  void update(){
    //ypos = ypos + ( yspeed * ydirection);
   
    if(isJumping){
        
      //vel.y = vel.y * ydirection;
      loc.y = loc.y + (vel.y *ydirection);
    }  
  }
  
  void display(){
    //background(0);
    noStroke();
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
  String getId(){
    return id;
  }
  

} 

