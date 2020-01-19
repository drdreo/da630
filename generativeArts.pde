SceneManager sm;
DeepSpaceManager dsm;

void settings() {
  dsm = new DeepSpaceManager();
  // size has to be inited in settings when using OOP
  size(dsm.windowWidth, dsm.windowHeight, FX2D ); 
  //fullScreen(P2D, SPAN);

  smooth();
}

void setup() {
  frameRate(dsm.frameRate);
  dsm.doSetup();

  sm = new SceneManager(this);
}

void draw() {
  // draw upper / lower area of deep space and tracking helpers
  sm.doDraw();
 // dsm.drawDSMHelpers();
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
