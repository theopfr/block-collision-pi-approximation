
// small block
int rect1_dim = 100;
float rect1_x = 200.0;
float rect1_y = 500.0;
float rect1_v = 0.0;
float rect1_m = 1;

// big block
int rect2_dim = 150;
float rect2_x = 500.0;
float rect2_y = 450.0;
float rect2_v = 0.5;
float rect2_m = 100;

String c = "# Collisions: ";
int collisions = 0;

void setup() {
  
  frameRate(1024);
  size(1000, 600);
  background(0);
  
  PFont f = createFont("Georgia", 35);
  textFont(f);
  textSize(32);
}

void draw() {
  
  clear();
  
  // small block
  pushStyle();
  stroke(255, 255, 255);
  strokeWeight(3);
  fill(220, 220, 220);
  rect(rect1_x, rect1_y, rect1_dim, rect1_dim);
  popStyle();
  
  //big block
  pushStyle();
  stroke(255, 255, 255);
  strokeWeight(3);
  fill(170, 170, 170);
  rect(rect2_x, rect2_y, rect2_dim, rect2_dim);
  popStyle();
  
  // check block collision
  if (rect2_x <= rect1_x + rect1_dim) {    
    block_collision();
    collision_animation("block");
  }
  // check wall collision
  else if (rect1_x <= 0) {            
    wall_collision();
    collision_animation("wall");
  }
  // update positions
  rect1_x -= rect1_v;
  rect2_x -= rect2_v;
  
  // print masses to screen
  text(rect1_m + " kg", rect1_x + 15, rect1_y - 15);
  text(10 + "^" + int(log(rect2_m) / log(10)) + " kg", rect2_x + 20, rect2_y - 15);
  
  // print collisions to screen
  text(c + collisions, 700, 100);

}

void block_collision() {
    
  float zw_rect1_v = rect1_v;
  
  rect1_v = 2 * ((rect1_m * rect1_v + rect2_m * rect2_v) / (rect1_m + rect2_m)) - rect1_v;
  rect2_v = 2 * ((rect1_m * zw_rect1_v + rect2_m * rect2_v) / (rect1_m + rect2_m)) - rect2_v;
  
  // update collision counter
  collisions += 1;
}

void wall_collision() {
 
  rect1_v *= -1;
  
  // update collision counter
  collisions += 1;
}

void collision_animation(String s){
  
  // create collsion friction animation
  
  pushStyle();
  stroke(255, 251, 157);
  strokeWeight(3);
  noFill();
  
  float ran = random(-15.0, 15.0);

  if(s == "block"){
    ellipse(rect2_x, ran + rect1_y + rect1_dim / 2, 24, 24);
  }
  else if(s == "wall"){
    ellipse(rect1_x, ran + rect1_y + rect1_dim / 2, 24, 24);
  }
  
  popStyle();
}
