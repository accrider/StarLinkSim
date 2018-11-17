class City {
  float longitude;
  float latitude;
  color c;
  String name;

  public City(float lng, float lat, color c, String name) {
    this.longitude = lng;
    this.latitude = lat;
    this.c = c;
    this.name = name;
  }
  void drawCity() {
    pushMatrix();
    rotateY(radians(latitude) + radians(180));
    rotateZ(-radians(longitude));
    translate(Constants.EARTH_RADIUS * Constants.SCALE,0);
    fill(c);
    noStroke();
    sphere(3);
    translate(5,0);
    pushMatrix();
    rotateY(radians(90));
    fill(255);
    text(name, 0,0);
    popMatrix();
    popMatrix();
  }
}
