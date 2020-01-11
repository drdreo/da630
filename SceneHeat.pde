class SceneHeat extends Scene {
  SceneManager sm;

  Particle[] particles;
  int particlesAmount = 10000;
  float alpha;

  int redValue = 1;
  int movingPlayers = 0;

  float heatTime = 0;

  SceneHeat(SceneManager sm) {
    println("Scene Heat created!");
    this.sm = sm;

    noStroke();
    setParticles();
  }

  void doDraw() {
    this.alpha = 7; //map(this.averagePos, 0, width, 5, 35);
    //println("alpha: " + this.alpha);
    fill(0, alpha);
    rect(0, 0, width, height);

    // if 33% of all players move, increase heat
    int movingLimit = (int)pc.players.size() / 2;
    if (this.movingPlayers > movingLimit && this.redValue < 255) {     
      this.redValue++;
      if (this.heatTime == 0 && this.redValue == 255) {
        this.heatTime = millis();
      }
    } else {
      if (this.redValue > 10 ) {
        this.redValue -= 10;
      }
    }

    loadPixels();

    for (Particle p : this.particles) {
      p.move();
    }
    updatePixels();
    updateAvgPlayers();
    // start end fade after heat was on for 3000ms
    if (millis() - heatTime > 10000){
      this.startEnd();
    }
  }

  void end() {
    println("ended SceneHeat");
    this.sm.setScene(new SceneMigration(this.sm));
  }

  void setParticles() {
    particles = new Particle[particlesAmount];
    for (int i = 0; i < particlesAmount; i++) { 
      float x = random(width);
      float y = random(height);
      float adj = map(y, 0, height, 255, 0);
      int c = color(40, adj, 255);
      this.particles[i] = new Particle(x, y, c);
    }
  }

  void updateAvgPlayers() {
    this.movingPlayers = 0;
    for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
    {
      Player p = playersEntry.getValue();
      if (p.isMoving()) {
        this.movingPlayers++;
      }
    }
  }

  class Particle {
    float posX, posY, incr, theta;
    color c;

    Particle(float x, float y, color c) {
      this.posX = x;
      this.posY = y;
      this.c = c;
    }

    public void move() {
      update();
      wrap();
      display();
    }

    void update() {
      incr +=  0.008;
      theta = noise(posX * 0.006, posY * 0.004, incr) * TWO_PI;
      posX += 2 * cos(theta);
      posY += 2 * sin(theta);
    }

    void updateColor() {
      this.c = color(redValue, green(this.c), 255 - redValue);
    }

    void display() {
      updateColor();
      if (posX > 0 && posX < width && posY > 0  && posY < height) {
        pixels[(int)posX + (int)posY * width] =  c;
      }
    }

    void wrap() {
      if (posX < 0) posX = width;
      if (posX > width ) posX =  0;
      if (posY < 0 ) posY = height;
      if (posY > height) posY =  0;
    }
  }
}
