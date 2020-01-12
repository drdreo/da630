class SceneParticleGlobe extends Scene { //<>//
  
  int time;
  int playerDelay;
  int globeRadius;

  ArrayList<Float> mass = new ArrayList<Float>();
  ArrayList<Float> positionX = new ArrayList<Float>();
  ArrayList<Float> positionY = new ArrayList<Float>();
  ArrayList<Float> velocityX = new ArrayList<Float>();
  ArrayList<Float> velocityY = new ArrayList<Float>();
  ArrayList<Integer> colors = new ArrayList<Integer>();
  ArrayList<String> types = new ArrayList<String>();
  ArrayList<Integer> polygons = new ArrayList<Integer>();
  
  SceneParticleGlobe() {
    time = 0;
    playerDelay = 0;
    globeRadius = dsm.windowHeight/4 - 20;
  }

  void doDraw() {
    if (millis() > time) {
      time += (int) random(50, 300);
      addRandomParticle();
      randomizePolygons();
    }
    
    if (millis() > playerDelay) {
      playerDelay += (int) random(500, 1500);
      checkPlayerLocation();
    }
    
    background(15);
    
    for (int particleA = 0; particleA < mass.size(); particleA++) {
      float accelerationX = 0, accelerationY = 0;

      for (int particleB = 0; particleB < mass.size(); particleB++) {
        if (particleA != particleB) {
          float distanceX = positionX.get(particleB) - positionX.get(particleA);
          float distanceY = positionY.get(particleB) - positionY.get(particleA);

          float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
          if (distance < 1) distance = 1;

          float force = (distance - globeRadius) * mass.get(particleB) / distance;
          accelerationX += force * distanceX;
          accelerationY += force * distanceY;
        }
      }

      velocityX.set(particleA, velocityX.get(particleA) * 0.75 + accelerationX * mass.get(particleA));
      velocityY.set(particleA, velocityY.get(particleA) * 0.50 + accelerationY * mass.get(particleA));
    }
    
    //loadPixels();

    int n = 0;
    
    for (int particle = 0; particle < mass.size(); particle++) {
      positionX.set(particle,   positionX.get(particle) + velocityX.get(particle));
      positionY.set(particle,  positionY.get(particle) + velocityY.get(particle));
    
      fill(colors.get(particle));
      float x = positionX.get(particle); //<>//
      float y = positionY.get(particle);
      float width = mass.get(particle) * 1000;
      
      if (types.get(particle) == "circle") {
        ellipse(x, y, width, width);
      } else if (types.get(particle) == "polygon") {
        polygon(x, y, width/2, polygons.get(n));
        n++;
      }
    }
    
    //updatePixels();
  }
  
  void addRandomParticle() {
    if (random(0,1) < 0.4) {
      colors.add(color(15, 200, 12, 144));
    } else {
      colors.add(color(0, 25, 200, 144));
    }
    mass.add(random(0.003, 0.03));
    positionX.add((float)random(10, dsm.windowWidth-10));
    positionY.add((float)random(10, dsm.windowHeight/2));
    velocityX.add(0.0);
    velocityY.add(0.0);
    types.add("circle");
  }
  
  void randomizePolygons() {
    for (int i = 0; i<polygons.size(); i++) {
      polygons.set(i, (int)random(4, 8));
    }
  }

  void addNewParticle(int x, int y) {
    if (y > dsm.windowHeight / 2) {
      if (x <= dsm.windowWidth / 2) {
        colors.add(color(15, 200, 12, 87));
        types.add("circle");
      } else {
        colors.add(color(164, 34, 98, 114));
        types.add("polygon");
        polygons.add((int)random(4, 8));
      }

      mass.add(random(0.003, 0.03));
      positionX.add((float)x);
      positionY.add((float)y);
      velocityX.add(0.0);
      velocityY.add(0.0);
    }
  }
  
  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  void checkPlayerLocation() {
    for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
    {
      Player p = playersEntry.getValue();
      println(p.x, p.y);
      this.addNewParticle((int)p.x, (int)p.y);
    }
  }

  void handleMouseClicked() {
    addNewParticle(mouseX, mouseY);
  }

  void handleMouseDragged() {
    //addNewParticle();
  }
}
