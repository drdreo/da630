class DeepSpaceManager {
  float cursor_size = 25;
  PFont font;

  int shrink = 5;
  int windowWidth = 3030/shrink; // for real Deep Space this should be 3030
  int windowHeight = 3712/shrink; // for real Deep Space this should be 3712
  int wallHeight = 1914/shrink; // for real Deep Space this should be 1914 (Floor is 1798)
  int frameRate = 30;

  boolean ShowTrack = true;
  boolean ShowPath = true;
  boolean ShowFeet = true;
  boolean helpersDrawn = false;

  void doSetup() {
    noStroke();
    fill(0);

    font = createFont("Arial", 18);
    textFont(font, 18);
    textAlign(CENTER, CENTER);

    initPlayerTracking();
  }

  void drawDSMHelpers() {
    if(!helpersDrawn){
      // clear background with white
      background(255);

      // set upper half of window (=wall projection) bluish
      noStroke();
      fill(70, 100, 150);
      rect(0, 0, windowWidth, wallHeight);
      helpersDrawn = true;
    }

    fill(150);
    text((int)frameRate + " FPS", width / 2, 10);
    drawPlayerTracking();
  }

  void handleKeyPressed()
  {
    switch(key){
    case 'p':
      ShowPath = !ShowPath;
      break;
    case 't':
      ShowTrack = !ShowTrack;
      break;
    case 'f':
      ShowFeet = !ShowFeet;
      break;
    }
  }
}
