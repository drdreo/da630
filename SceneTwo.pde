class SceneTwo extends Scene {
  int time = millis();


  void doDraw() {

    background(100);

    fill(255); // sets fill color to white

    int passedMillis = millis() - time; // calculates passed milliseconds
    if (passedMillis >= 215) {
      time = millis();
      fill(255, 0, 0);  // if more than 215 milliseconds passed set fill color to red
    }
    ellipse(50, 50, 50, 50); // draw first circle


    fill(255); // fill white
    ellipse(150, 150, 50, 50); // draw second circle

    fill(255, 0, 0);  // fill red
    arc(150, 150, 50, 50, 0, TWO_PI / 215.0 * passedMillis, PIE); // draw red
  }

}
