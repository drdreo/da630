class SceneParticleGlobe extends Scene { //<>// //<>// //<>// //<>//
  SceneManager sm;

  int time;
  int playerDelay;
  int globeRadius;

  ArrayList<PVector> position = new ArrayList<PVector>();
  ArrayList<PVector> velocity = new ArrayList<PVector>();

  ArrayList<Float> mass = new ArrayList<Float>();
  ArrayList<Integer> colors = new ArrayList<Integer>();
  ArrayList<String> types = new ArrayList<String>();
  ArrayList<Integer> polygons = new ArrayList<Integer>();

  SceneParticleGlobe(SceneManager SM) {
    sm = SM;
    time = 0;
    playerDelay = 0;
    globeRadius = (int) (dsm.windowHeight/2.5);
     
    
    /*mass.add(mass.size(), 30.0);
    position.add(position.size(), new PVector(dsm.windowWidth/2, dsm.windowHeight/2));
    velocity.add(velocity.size(), new PVector(0, 0));
    colors.add(mass.size(), 0);*/
  }

  void doDraw() {
    noStroke();
    background(15);
    //translate(100,0);

    if (millis() > time) {
      time += (int) random(25, 100);
      addRandomParticle();
      randomizePolygons();
    }

    if (millis() > playerDelay) {
      playerDelay += (int) random(500, 1500);
      checkPlayerLocation();
    }

    for (int particle = 0; particle < mass.size(); particle++) {
      position.get(particle).lerp(new PVector(dsm.windowWidth+dsm.windowWidth/2.17,dsm.windowHeight/2-500),0.001);
   }

    //rotate the globe
    
    for (int particle = 0; particle < mass.size(); particle++) {
      position.get(particle).rotate(radians(.1));
    }
    //translate(dsm.windowWidth/2, dsm.windowHeight/2);

    for (int particleA = 0; particleA < mass.size(); particleA++) {
      float accelerationX = 0, accelerationY = 0;

      for (int particleB = 0; particleB < mass.size(); particleB++) {
        if (particleA != particleB) {
          //float distanceX = positionX.get(particleB) - positionX.get(particleA);
          //float distanceY = positionY.get(particleB) - positionY.get(particleA);

          float distance;
          float distanceX = position.get(particleB).x - position.get(particleA).x;
          float distanceY = position.get(particleB).y - position.get(particleA).y;

          distance = sqrt(distanceX * distanceX + distanceY * distanceY);
          if (distance < 1) distance = 1;

          float force = (distance - globeRadius) * mass.get(particleB) / distance;
          accelerationX += force * distanceX;
          accelerationY += force * distanceY;
        }
      }

      velocity.set(particleA, new PVector(velocity.get(particleA).x * 0.75 + accelerationX * mass.get(particleA), velocity.get(particleA).y * 0.50 + accelerationY * mass.get(particleA)));
      velocity.get(particleA).rotate(radians(10));
    }

    int n = 0;
    //push();
    for (int particle = 0; particle < mass.size(); particle++) {
      //positionX.set(particle, positionX.get(particle) + velocityX.get(particle));
      //positionY.set(particle, positionY.get(particle) + velocityY.get(particle));
      float w = mass.get(particle) * 1000;
      float x = position.get(particle).x;
      float y = position.get(particle).y;

      position.set(particle, new PVector(position.get(particle).x + velocity.get(particle).x, position.get(particle).y + velocity.get(particle).y));
      fill(colors.get(particle));
      x = position.get(particle).x;
      y = position.get(particle).y;

      if (types.get(particle) == "circle") {
        ellipse(x, y, w, w);
        //translate(-100, -100);
        //rotate(radians(1));
      } else if (types.get(particle) == "polygon") {
        polygon(x, y, w/2, polygons.get(n));
        n++;
        //translate(-100, -100);
        //rotate(radians(1));
      }
    }
    //pop();

    // start end fade after 30s
    if (millis() - startTime > 60000) {
      this.startEnd();
    }
  }

  void addRandomParticle() {
    if (random(0, 1) < 0.4) {
      colors.add(color(15, 200, 12, 144));
    } else {
      colors.add(color(0, 25, 200, 144));
    }
    mass.add(random(0.003, 0.03));
    //positionX.add((float)random(10, dsm.windowWidth-10));
    //positionY.add((float)random(10, dsm.windowHeight/2));

    position.add(new PVector((float)random(10, dsm.windowWidth-10), (float)random(10, dsm.windowHeight/2)));

    //velocityX.add(0.0);
    //velocityY.add(0.0);

    velocity.add(new PVector(0.0, 0.0));
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
        colors.add(color(115, 115, 115, 87));
        types.add("circle");
      } else {
        colors.add(color(164, 34, 98, 114));
        types.add("polygon");
        polygons.add((int)random(4, 8));
      }

      mass.add(random(0.003, 0.03));
      //positionX.add((float)x);
      //positionY.add((float)y);

      position.add(new PVector((float)x, (float)y));

      //velocityX.add(0.0);
      //velocityY.add(0.0);

      velocity.add(new PVector(0.0, 0.0));
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
