class SceneIntro extends Scene {

  SceneManager sm;
  PFont font;
  int fontSize = 32;

  String[] sentences = {
    "",
    "",
    "The climate crisis is the battle of our time", 
    "We are facing the biggest environmental", 
    "challenge our species has ever seen.", 
    "Your choices will have a lasting", 
    "impact on our planet"
  };

  int duration, sentence = 0;
  int alphaLerp = 0, alphaDirection = 4;

  SceneIntro(SceneManager sm) {
    println("SceneIntro started");

    this.sm = sm;
    font = createFont("Kanit-Light.ttf", fontSize);
    textFont(font, fontSize);
    textAlign(CENTER, CENTER);
  }

  void doDraw() {
    background(12);
    //rect(0, 0, dsm.windowWidth, dsm.windowHeight);
    alphaLerp += alphaDirection;


    noStroke();
    fill(255, 255, 255, alphaLerp);
    text(sentences[sentence], dsm.windowWidth/2, dsm.wallHeight / 2);

    if (alphaLerp >= 255 || alphaLerp <= 0) {
      alphaDirection *= -1;
    } 

    if (alphaLerp <=0) {
      sentence++;
      if(sentence == sentences.length){
       this.end(); 
      }
    }
  }

  void end() {
    println("ended SceneIntro");
    this.sm.setScene(new SceneWind(this.sm));
  }
}
