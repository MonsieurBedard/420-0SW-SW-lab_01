int nbMovers = 50;

Fluid fluid;

Mover[] movers;
Mover heliumMover;

void setup () {
  size (800, 600);
  init();
}

void init() {
  fluid = new Fluid();
  
  heliumMover = new Mover(4, random(0, width), 600);
  
  movers = new Mover[nbMovers];
  for (int i = 0; i < movers.length; i++) {
    float rand = randomGaussian() * 2;
    if (rand < 0) {
      rand *= -1;
    }
    
    rand += 1;
    
    movers[i] = new Mover(rand, random(0, width), 0);
  }
}

void draw () {
  update();
  
  background (255);
  fluid.display();

  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
  
  heliumMover.display();
}

void update() {
  // Wind
  PVector wind = new PVector(0, 0);
  if (mousePressed && (mouseButton == LEFT)) {
    wind = new PVector(0.005, 0);
  } else if (mousePressed && (mouseButton == RIGHT)) {
    wind = new PVector(-0.005, 0);
  }
  
  // Normal movers
  for (int i = 0; i < movers.length; i++) {    
    float m = movers[i].mass;
    
    PVector gravity = new PVector (0, 0.1 * m);
    
    fluid.applyResistance(movers[i]);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].checkEdges();
  }
  
  // Helium mover
  float m = heliumMover.mass;
    
  PVector gravity = new PVector (0, -0.1 * m);
  
  fluid.applyResistance(heliumMover);
  heliumMover.applyForce(wind);
  heliumMover.applyForce(gravity);
    
  heliumMover.update();
  heliumMover.checkEdges();
}

// Activate liquid
void keyPressed() {
  if (key == 32) {
    fluid.changeState(); 
  }
  
  if (key == 114) {
    init();
  }
}
