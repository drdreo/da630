SceneManager sm;

void setup() {
  size(2000, 1000);
  background(21, 8, 50);

  sm = new SceneManager();
}

void draw() {
  sm.doDraw();
}


void keyPressed() {
  sm.handleKeyPressed();
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
