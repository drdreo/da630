int duration  = 0;

class SceneOne extends Scene {

  SceneManager sm;
  int nums = 200;

  Particle[] particles_a = new Particle[nums];
  Particle[] particles_b = new Particle[nums];
  Particle[] particles_c = new Particle[nums];

  SceneOne(SceneManager sm) {  
    print("Scene One created!");
    this.sm = sm;

    //background(21, 8, 50);
    print("height: " + height);
    print("width: " + width);

    for (int i = 0; i < nums; i++) {
      particles_a[i] = new Particle(random(0, width), random(0, height));
      particles_b[i] = new Particle(random(0, width), random(0, height));
      particles_c[i] = new Particle(random(0, width), random(0, height));
    }
  }

  void doDraw() {
    noStroke();
    smooth();

    for (int i = 0; i < nums; i++) {
      float radius = map(i, 0, nums, 1, 2);
      float alpha = map(i, 0, nums, 0, 250);

      fill(69, 33, 124, alpha);
      particles_a[i].move();
      particles_a[i].display(radius);
      particles_a[i].checkEdge();

      fill(7, 153, 242, alpha);
      particles_b[i].move();
      particles_b[i].display(radius);
      particles_b[i].checkEdge();

      fill(255, 255, 255, alpha);
      particles_c[i].move();
      particles_c[i].display(radius);
      particles_c[i].checkEdge();
    }


    // our random end declaration
    duration++;

    if (duration >= 500) {
      this.end();
    }
  }

  void end() {  
    this.sm.setScene(new SceneParticleGlobe());
  }
}


class Particle {

  PVector dir, vel, pos;
  float speed;
  int noiseScale = 800;

  Particle(float x, float y) {
    print("X:" + x);
    print("Y:" + y);

    this.dir = new PVector(0, 0);
    this.vel = new PVector(0, 0);
    this.pos = new PVector(x, y);
    this.speed = 0.4;
  }


  void move() {
    float angle = noise(this.pos.x/this.noiseScale, this.pos.y/this.noiseScale)*TWO_PI*this.noiseScale;
    this.dir.x = cos(angle);
    this.dir.y = sin(angle);
    this.vel = this.dir.copy();
    this.vel.mult(this.speed);
    this.pos.add(this.vel);
  }

  void checkEdge() {
    if (this.pos.x > width || this.pos.x < 0 || this.pos.y > height || this.pos.y < 0) {
      this.pos.x = random(50, width);
      this.pos.y = random(50, height);
    }
  }

  void display(float r) {
    ellipse(this.pos.x, this.pos.y, r, r);
  }
}
