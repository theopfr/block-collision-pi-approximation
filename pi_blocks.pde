
// small block
int rect1_dim = 100;
float rect1_x = 200.0;
float rect1_y = 500.0;
float rect1_v = 0.0;
float rect1_m = 1.0;

// big block
int rect2_dim = 150;
float rect2_x = 500.0;
float rect2_y = 450.0;
float rect2_v = 1.0;
float rect2_m = 100000000.0;

int collisions = 0;

void setup() {
  frameRate(120);
  size(1000, 600);
  background(0);
}

void draw() {
  clear();

  if (rect2_x <= rect1_x + rect1_dim) {  // rect2 - rect1 collision
    block_collision();
    
  } else if (rect1_x <= 0) {             // rect1 - wall collision
    wall_collision();
  }

  rect1_x -= rect1_v;
  rect2_x -= rect2_v;

  rect(rect1_x, rect1_y, rect1_dim, rect1_dim);
  rect(rect2_x, rect2_y, rect2_dim, rect2_dim);
  
  println(collisions);
}

void block_collision() {
    
  float zw_rect1_v = rect1_v;
  float zw_rect2_v = rect2_v;
  
  rect1_v = 2 * ((rect1_m * rect1_v + rect2_m * rect2_v) / (rect1_m + rect2_m)) - rect1_v;
  rect2_v = 2 * ((rect1_m * zw_rect1_v + rect2_m * rect2_v) / (rect1_m + rect2_m)) - rect2_v;
  
  collisions += 1;
}

void wall_collision() {
  rect1_v *= -1;
  
  collisions += 1;
}
