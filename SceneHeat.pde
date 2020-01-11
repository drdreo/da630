class SceneHeat extends Scene {
  SceneManager sm;

  Particle[] particles;
  float alpha;

  int redValue = 1;
  float averageAge = 0;


  SceneHeat(SceneManager sm) {
    println("Scene Heat created!");
    this.sm = sm;

    noStroke();
    setParticles();
  }

  void doDraw() {
    this.alpha = 15; //map(mouseX, 0, width, 5, 35);
    fill(0, alpha);
    rect(0, 0, width, height);

    if(this.redValue < 255){
      this.redValue++;
    }

    loadPixels();

    for (Particle p : this.particles) {
      p.move();
    }
    updatePixels();
    updatePlayersAge();
    //  // start end fade after 10000ms
    // if(millis() - startTime > 3000){
    //   this.startEnd();
    // }
  }

 void end() {
    println("ended SceneHeat");
    //this.sm.setScene(new SceneHeat());
  }

  void setParticles() {
    particles = new Particle[6000];
    for (int i = 0; i < 6000; i++) { 
      float x = random(width);
      float y = random(height);
      float adj = map(y, 0, height, 255, 0);
      int c = color(40, adj, 255);
      this.particles[i] = new Particle(x, y, c);
    }
  }

  void updatePlayersAge(){
    int playersCount = pc.players.size();
    float avg = 0;
    for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
    {
      Player p = playersEntry.getValue();
      avg += p.age;
    }
    this.averageAge = avg / playersCount;
    println("Avg. Age: " + this.averageAge);
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

    void updateColor(){
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
