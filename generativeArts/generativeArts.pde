SceneManager sm;
DeepSpaceManager dsm;

void settings() {
  dsm = new DeepSpaceManager();
  // size has to be inited in settings when using OOP
  size(dsm.windowWidth, dsm.windowHeight, FX2D ); 
  smooth();
}

void setup() {
  frameRate(dsm.frameRate);
  dsm.doSetup();

  sm = new SceneManager();
}

void draw() {
  // draw upper / lower area of deep space and tracking helpers
  dsm.drawDSMHelpers();
  sm.doDraw();
}


void keyPressed() {
  sm.handleKeyPressed();
  dsm.handleKeyPressed();
}

void mouseClicked() {
  sm.handleMouseClicked();
}

void mouseDragged() {
  sm.handleMouseDragged();
}

void mousePressed() {
  sm.handleMousePressed();
}

void mouseReleased() {
  sm.handleMouseReleased();
}
