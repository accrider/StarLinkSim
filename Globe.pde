class Globe {
  PShape globe;
  ArrayList<City> cities = new ArrayList<City>();

  void init() {
    PImage earth = loadImage("tex.jpg");
    globe = createShape(SPHERE, Constants.EARTH_RADIUS * Constants.SCALE); 
    globe.setStroke(false);
    globe.setTexture(earth);
  }

  void drawGlobe() {
    pushMatrix();
    /*
    * Rotate the earth and draw
     */
    rotateY(radians(frameCount * Constants.GLOBE_ROTATE_PER_TICK));
    shape(globe);

    // Loop through the cities and place them on the globe with circles
    for (City c : cities) {
      c.drawCity();
    }


    popMatrix();
  }

  void addCity(float lng, float lat, color c, String name) {
    cities.add(new City(lng, lat, c, name));
  }
}
