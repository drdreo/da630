class DeepSpaceManager {
  float cursor_size = 25;
  PFont font;

  int shrink = 4;
  int windowWidth = 3030 / shrink; // for real Deep Space this should be 3030
  int windowHeight = 3712 / shrink; // for real Deep Space this should be 3712
  int wallHeight = 1914 / shrink; // for real Deep Space this should be 1914 
  int floorHeight = 1798 / shrink; // for real Deep Space this should be 1798 
  int FrameRate = 30;

  boolean showTrack = true;
  boolean showPath = false;
  boolean showFeet = false;
  boolean helpersDrawn = false;

  void doSetup() {
    noStroke();
    fill(255);

    font = createFont("Arial", 18);
    textFont(font, 12);
    textAlign(CENTER, CENTER);

    initPlayerTracking();
  }

  void drawDSMHelpers() {
    if (!helpersDrawn) {
      // clear background with black
      background(0);

      // set upper half of window (=wall projection) bluish
      noStroke();
      fill(21, 8, 50);
      rect(0, 0, windowWidth, wallHeight);
      helpersDrawn = true;
    }

    fill(255);
    text((int)FrameRate + " FPS", width / 2, 10);
    text("Width: " + this.windowWidth, width / 2, 30);
    text("Wall height: " + this.wallHeight, width / 2, 50);

    drawPlayerTracking();
  }

  void handleKeyPressed()
  {
    println("handle key:" + key);
    switch(Character.toLowerCase(key)) {
    case 'p':
      showPath = !showPath;
      break;
    case 't':
      showTrack = !showTrack;
      break;
    case 'f':
      showFeet = !showFeet;
      break;
    }
  }
}
