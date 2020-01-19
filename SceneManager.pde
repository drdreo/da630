import processing.sound.*;

abstract class Scene {

  int startTime = millis();
  int endTime = 0;
  int fadingTime = 3000; // how long the fade should take

  abstract void doDraw();
  void end() {
  };

  void startEnd() {

    // if we trigger this the first time, store current time
    if (!this.ended()) {
      this.endTime = millis();
    }

    // as long as fading time is not over, fill the whole screen with a transparent color
    if (millis() - this.endTime < this.fadingTime) {
      fill(12, 12, 12, 12);
      rect(0, 0, dsm.windowWidth, dsm.windowHeight);
    } else {
      // switch to next scene, if we are done fading
      this.end();
    }
  };

  // returns true if scene has already ended
  boolean ended() {
    return this.endTime != 0;
  }

  void handleMouseClicked() {
  };
  void handleMouseDragged() {
  };
  void handleMousePressed() {
  };
  void handleMouseReleased() {
  };
  void handleKeyPressed() {
  };
}


class SceneManager {

  Scene scene;
  SoundFile file;
  Sound s;

  SceneManager(PApplet p) {
    this.scene = new SceneIntro(this);
    this.s = new Sound(p);

    // Load a soundfile from the /data folder of the sketch and play it back
    this.file = new SoundFile(p, "music.mp3");
    this.file.play();
  }

  void setScene(Scene scene) {
    this.scene = scene;
  }

  void doDraw() {
    if (!this.scene.ended()) {
      this.scene.doDraw();
    } else {
      // if scene ended, continue fading
      this.scene.startEnd();
    }
  }

  void handleMouseClicked() {
    this.scene.handleMouseClicked();
  }

  void handleMouseDragged() {
    this.scene.handleMouseDragged();
  }

  void handleMousePressed() {
    this.scene.handleMousePressed();
  }

  void handleMouseReleased() {
    this.scene.handleMouseReleased();
  }

  void handleKeyPressed() {
    this.scene.handleKeyPressed();
  }
}
