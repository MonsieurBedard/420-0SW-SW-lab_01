class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
   
  float topSpeed;
  float mass;
  
  Mover () {
    
    this.location = new PVector (random (width), random (height));    
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    
    this.mass = 1;
  }  
  
  Mover (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    
    this.topSpeed = 100;
  }
  
  Mover (float m, float x, float y) {
    mass = m;
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill (127, 127, 127, 127);
    
    ellipse (location.x, location.y, mass * 16, mass * 16); // Dimension à l'échelle de la masse
  }
  
  void checkEdges() {
    if (location.x > width - (mass * 16 / 2)) {
      location.x = width - (mass * 16 / 2);
      velocity.x *= -1;
    } else if (location.x < 0 + (mass * 16 / 2)) {
      velocity.x *= -1;
      location.x = 0 + (mass * 16 / 2);
    }
    
    if (location.y > height - (mass * 16 / 2)) {
      velocity.y *= -1;
      velocity.mult(.90);
      location.y = height - (mass * 16 / 2);
    } else if (location.y < 0 + (mass * 16 / 2)) {
      velocity.y *= -1;
      velocity.mult(.90);
      location.y = 0 + (mass * 16 / 2);
    }
  }
  
  void applyForce (PVector force) {
    PVector f = PVector.div (force, mass);
   
    this.acceleration.add(f);
  }
}
