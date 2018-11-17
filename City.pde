class City {
  float longitude;
  float latitude;
  color c;

  public City(float lng, float lat, color c) {
    this.longitude = lng;
    this.latitude = lat;
    this.c = c;
  }
  void drawCity() {
    pushMatrix();
    rotateY(radians(longitude) + radians(180));
    rotateZ(radians(latitude));
    translate(Constants.EARTH_RADIUS * Constants.SCALE,0);
    fill(c);
    noStroke();
    sphere(3);
    popMatrix();
  }
}
