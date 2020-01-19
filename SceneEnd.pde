class SceneEnd extends Scene {

  float amp = 100;
  
  SceneEnd(SceneManager sm) {
  }

  void doDraw() {
    // fade music
    sm.s.volume(amp--/100);
    if (millis() - startTime > 3000) {
      exit();
    }
  }

  void end() {
    println("FINISHED");
  }
}
