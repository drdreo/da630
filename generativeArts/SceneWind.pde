
class SceneWind extends Scene {
  SceneManager sm;

  int noiseScale = 500, noiseStrength = 2, amount = 1200;

  Particle[] particles = new Particle[amount];
  Repeller r = new Repeller(dsm.windowWidth / 2, dsm.wallHeight /2);
  HashMap<Long, Repeller> repellers = new HashMap<Long, Repeller>();

  color[] windColors = {color(69, 69, 69), color(100, 200, 250), color(200, 200, 200)};

  SceneWind(SceneManager sm) {  
    println("Scene Wind created!");
    this.sm = sm;

    for (int i = 0; i < amount; i++) {
      float alpha = map(i, 0, amount, 0, 250);
      int colorIndex = i % 3;
      color tempColor = color(red(windColors[colorIndex]), green(windColors[colorIndex]), blue(windColors[colorIndex]), alpha);
      particles[i] = new Particle(i, random(10, dsm.windowWidth), random(10, dsm.wallHeight), tempColor);
    }
  }

  void addRepellers() {
    for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
    {
      Player p = playersEntry.getValue();

      if (repellers.containsKey(p.tuioId)) {
        Repeller r = repellers.get(p.tuioId);
        // update repeller location to player's
        r.location.set(p.x, p.y - dsm.floorHeight);
      } else {
        repellers.put(p.tuioId, new Repeller(p.x, p.y - dsm.floorHeight));
      }
    }
  }

  void doDraw() {
    noStroke();
    smooth();

    addRepellers();

    // background(21, 8, 50);
    for (int i = 0; i < particles.length; i++) {

      // r.display();
      // calculate strongest force of all repellers
      PVector strongestForce = new PVector(0, 0);
      for (Map.Entry rep : repellers.entrySet()) { 
        Repeller r = (Repeller)rep.getValue(); 
        PVector repellForce = r.repel(particles[i]);
        if (strongestForce.mag() <repellForce.mag()) {
          strongestForce = repellForce.copy();
        }
      } 


      if (strongestForce.mag() > 0.5) {
        particles[i].applyForce(strongestForce);
      } else {
        PVector pos = particles[i].pos;
        // apply perlin force
        float angle = noise(pos.x / noiseScale, pos.y / noiseScale) * TWO_PI * noiseStrength;
        PVector dir = new PVector(cos(angle), sin(angle));
        particles[i].applyForce(dir.limit(0.1));

        /* float angle=noise(this.pos.x/noiseScale, this.pos.y/noiseScale, frameCount/noiseScale)*TWO_PI*this.noiseStrength;
         this.dir.x = cos(angle)+sin(angle)-sin(angle);
         this.dir.y = sin(angle)-cos(angle)*sin(angle);
         this.vel = this.dir.copy();
         this.vel.mult(this.speed);
         this.pos.add(this.vel);*/
      }
      particles[i].step();
    }
  }

  void handleMouseDragged() {
    r.location = new PVector(mouseX, mouseY);
  }

  void end() {
  }

  class Particle {

    PVector acc, vel, dir, pos, prev;
    LinkedList<PVector>trail = new LinkedList<PVector>(); 

    float speed = random(0.4, 0.9);
    float mass = 1;

    int id;
    color fillColor;

    Particle(int id, float x, float y, color c) {
      this.id = id;
      this.fillColor = c;
      this.pos = new PVector(x, y);
      this.prev = new PVector(x, y);
      this.vel = new PVector(0, 0);
      this.dir = new PVector(0, 0);
      this.acc = new PVector(0, 0);
    }

    void step() {
      update();
      display();
      checkEdge();
    }

    void update() {

      vel.add(acc);
      pos.add(vel.limit(0.8));
      acc.mult(0);

      // store trail
      /*if (prev.dist(pos)> 1) {
       if (trail.size() > 10) {
       trail.removeLast();
       }
       trail.addFirst(pos.copy());
       prev = pos.copy();
       }*/
    }

    void applyForce(PVector force) {
      force.div(mass);
      acc.add(force);
    }

    void checkEdge() {
      if (this.outOfBoundaries()) {

        //  this.fillColor = color(255, 0, 0);
        //println(this.id + " outbound x:" + this.pos.x + " y:" + this.pos.y);

        this.pos.x = random(50, dsm.windowWidth);
        this.pos.y = random(50, dsm.wallHeight);
        this.checkEdge();
      }
    }

    boolean outOfBoundaries() {
      return this.pos.x > dsm.windowWidth || this.pos.x < 0 || this.pos.y > dsm.wallHeight || this.pos.y < 0;
    }

    void display() {
      fill(this.fillColor);
      ellipse(this.pos.x, this.pos.y, 1, 1);
      /* for (int i = 0; i < trail.size(); i++) {
       PVector tP = trail.get(i);
       ellipse(tP.x, tP.y, 2, 2);
       }*/

      // mirror to bottom
      ellipse(this.pos.x, this.pos.y + dsm.wallHeight, 1, 1);
    }
  }


  class Repeller {
    PVector location;
    float r = 4;
    float strength = 200;

    boolean drawn = false;

    Repeller(float x, float y) {
      location = new PVector(x, y);
    }

    PVector repel(Particle p) {
      PVector dir = PVector.sub(location, p.pos);
      float d = dir.mag();
      dir.normalize();
      d = constrain(d, 5, 100);

      float force = -strength / (d * d);
      dir.mult(force);
      return dir;
    }

    void display() {
      fill(255);
      ellipse(location.x, location.y, r, r);
      drawn = true;
    }
  }
}