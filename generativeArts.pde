SceneManager sm;
DeepSpaceManager dsm;

// Load a soundfile from the /data folder of the sketch and play it back
SoundFile file ;

void settings() {
  dsm = new DeepSpaceManager();
  // size has to be inited in settings when using OOP
  //size(dsm.windowWidth, dsm.windowHeight, FX2D ); 
  fullScreen(P2D, SPAN);

  smooth();
  file = new SoundFile(this, "music.mp3");
  file.play();
}

void setup() {
  frameRate(dsm.FrameRate);
  dsm.doSetup();
  sm = new SceneManager(this);
}

void draw() {
  sm.doDraw();
  // draw upper / lower area of deep space and tracking helpers
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
