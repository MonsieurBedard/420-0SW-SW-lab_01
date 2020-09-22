class Fluid {
  float h;
  float w;
  float density;
  boolean active;
  
  Fluid() {
    h = height * random(0.1, 0.4);
    w = width;
    density = random(1.5, 3);
    active = false;
  }
  
  void display() {
    if (active) {
      stroke (0);
      fill (12, 127, 127, 127);
      rect(0, height - h, w, h);
      // ---
      stroke (0);
      fill (0, 0, 0, 255);
      text("Density = " + density + "\nAlexandre Bédard", 10, height - h / 2 , 255, 255);
    } 
  }
  
  void changeState() {
    if (!active) {
      active = true; 
      h = height * random(0.1, 0.4);
      density = random(1.5, 3);   
  } else {
      active = false;
    }
  }
  
  void applyResistance(Mover mover) {
    if (active == true && mover.location.y >= height - h) {      
      float speed = mover.velocity.mag();
      // Part 1 of our formula (magnitude): Cd * v2
      float dragMagnitude = 0.1 * density * speed * speed * 0.5;
      PVector drag = mover.velocity.copy();
      // Part 2 of our formula (direction):
      // -1 * velocity
      drag.mult(-1);
      drag.normalize();
      
      drag.mult(dragMagnitude);
      
      mover.applyForce(drag);
    }
  }
}
