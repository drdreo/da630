class SceneSeaLevelRise extends Scene {

  SceneManager sm;

  float yoff = 0.0;   
  float g = 240;
  float b = 240;
  float transY = 0;
  boolean bgCleared = false;

  SceneSeaLevelRise(SceneManager sm) {
    println("SceneSeaLevelRise started");
    this.sm = sm;
  }

  void doDraw() {
    //blue-bluegreen-green  
    g += random(-150, 10);
    b += random(-100, 10);
    //restrictions
    if (g < 210 || b < 220 || g > 255 || b > 255)
    {
      g = random(100, 255);
      b = random(220, 255);
    }

    //fill(255);
    beginShape();

    float xoff = 0;
    for (float x = 0; x <= dsm.windowWidth; x += 10) {
      float y = map(noise(xoff, yoff), 0, 1, 200, dsm.wallHeight); 
      vertex(x, y); 
      xoff += 0.04; // modify for steeper waves
      stroke(72, g, b);
      strokeWeight(1);
      fill(0, 20, 46);
    }

    yoff += 0.01; // smooths the wave speed
    vertex(dsm.windowWidth, height-600);
    vertex(0, transY);
    transY += 1000;
    endShape(CLOSE);

    // start end fade after 10000ms
    if (millis() - startTime > 13000) {
      this.startEnd();
    }

    if (!bgCleared) {
      bgCleared = true;
      fill(12, 12, 12);
      rect(0, 0, dsm.windowWidth, dsm.windowHeight);
    }
  }

  void end() {
    println("ended SceneSeaLevelRise");
    this.sm.setScene(new SceneHeat(this.sm));
  }
}
