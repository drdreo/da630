class SceneSeaLevelRise_jas extends Scene {

  SceneManager sm;
  DeepSpaceManager dsm;

  float yoff = 0.0;   
  float g = 240;
  float b = 240;
  float transY = 0;

  void setup() {
    size(dsm.windowHeight, dsm.windowWidth);
    background(247, 248, 250);
  }

  void doDraw() {
    //translate(400, 0);
    //rotate(PI/2);

    //blue-bluegreen-green  
    g += random(-150, 10);
    b += random(-100, 10);
    //restrictions
    if (g < 210 || b < 220 || g > 255 || b > 255)
    {
      g = random(100, 255);
      b = random(220, 255);
    }

    fill(255);
    translate(0, 100);
    beginShape();

    float xoff = 0;
    for (float x = 0; x <= width; x += 10) {
      // Calculate a y value according to noise, map to 
      float y = map(noise(xoff, yoff), 0, 1, 200, 500)*(1+abs(mouseY-480)/960); 
      // Set the vertex
      vertex(x, y); 
      // Increment x dimension for noise
      xoff += 0.02;
      stroke(72, g, b);
      strokeWeight(1);
      fill(0, 20, 46);
    }
   
    // increment y dimension for noise
    yoff += 0.02;
    vertex(width, height-600);
    vertex(0, transY);
    transY = transY + 1000;
    endShape(CLOSE);
  }
}
