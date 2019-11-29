abstract class Scene {

  abstract void doDraw();
  void end() {
  };
  void handleMouseClicked() {
  };
  void handleMouseDragged() {
  };
  void handleMousePressed() {
  };
  void handleMouseReleased() {
  };
  
  void handleKeyPressed(){}
}
 

class SceneManager {

  Scene scene;

  SceneManager() {
    this.scene = new SceneWind(this);
  }

  void setScene(Scene scene) {
    this.scene = scene;
  }

  void doDraw() {
    this.scene.doDraw();
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
