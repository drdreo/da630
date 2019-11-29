int globeRadius = 350; //<>//

class SceneParticleGlobe extends Scene {

  ArrayList<Float> mass = new ArrayList<Float>();
  ArrayList<Float> positionX = new ArrayList<Float>();
  ArrayList<Float> positionY = new ArrayList<Float>();
  ArrayList<Float> velocityX = new ArrayList<Float>();
  ArrayList<Float> velocityY = new ArrayList<Float>();

  void doDraw() {
    fill(64, 255, 255, 192);

    background(32);

    for (int particleA = 0; particleA < mass.size(); particleA++) {
      float accelerationX = 0, accelerationY = 0;

      for (int particleB = 0; particleB < mass.size(); particleB++) {
        if (particleA != particleB) {
          float distanceX = positionX.get(particleB) - positionX.get(particleA);
          float distanceY = positionY.get(particleB) - positionY.get(particleA);

          float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
          if (distance < 1) distance = 1;

          float force = (distance - globeRadius) * mass.get(particleB) / distance;
          accelerationX += force * distanceX;
          accelerationY += force * distanceY;
        }
      }

      velocityX.set(particleA, velocityX.get(particleA) * 0.75 + accelerationX * mass.get(particleA));
      velocityY.set(particleA, velocityY.get(particleA) * 0.50 + accelerationY * mass.get(particleA));
    }

    for (int particle = 0; particle < mass.size(); particle++) {
      positionX.set(particle,   positionX.get(particle) + velocityX.get(particle));
      positionY.set(particle,  positionY.get(particle) + velocityY.get(particle));
    
      float x = positionX.get(particle); //<>//
      float y = positionY.get(particle);
      float width = mass.get(particle) * 1000;
      ellipse(x, y, width, width);
    }
  }

  void addNewParticle() {
    print("mouseX:" + mouseX);
    print("\n");
    print("mouseY:" + mouseY);

    mass.add(random(0.003, 0.03));
    positionX.add((float)mouseX);
    positionY.add((float)mouseY);
    velocityX.add(0.0);
    velocityY.add(0.0);
  }

  void handleMouseClicked() {
    addNewParticle();
  }

  void handleMouseDragged() {
    addNewParticle();
  }
}
