class SceneEnd extends Scene {

  SceneManager sm;

  float amp = 100;
  PFont font;
  int fontSize = 32;

  String[] sentences = {
    "",
    "Act now!"
  };

  int duration, sentence = 0;
  int alphaLerp = 0, alphaDirection = 4;
  boolean done = false;

  SceneEnd(SceneManager sm) {
    this.sm = sm;
    this.fontSize = 120 / dsm.shrink;

    font = createFont("Kanit-Light.ttf", fontSize);
    textFont(font, fontSize);
    textAlign(CENTER, CENTER);
  }

  void doDraw() {
    background(12);

    if (!done) {
      noStroke();

      alphaLerp += alphaDirection;
      fill(255, 255, 255, alphaLerp);
      text(sentences[sentence], dsm.windowWidth/2, dsm.wallHeight / 2);

      if (alphaLerp >= 255 || alphaLerp <= 0) {
        alphaDirection *= -1;
      } 

      if (alphaLerp <=0) {
        sentence++;
        if (sentence == sentences.length) {
          done = true;
        }
      }
    }

    // fade music
    if (amp-- >= 0) {
      sm.s.volume(amp/100);
    }
  }

  void end() {
    println("FINISHED");
  }
}
