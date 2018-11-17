class Orbits {
  float orbit_inclination = 53;

  // Orbital planes (0-?) and corresponding orbits
  HashMap<Integer, ArrayList<Satellite>> satellites = new HashMap<Integer, ArrayList<Satellite>>();

  void initializeSatelliteMap() {
    for (int i = 0; i < Constants.SAT_PLANES; i++) {
      ArrayList<Satellite> curPlaneSats = new ArrayList<Satellite>();
      for (int j = 0; j < Constants.SATS_PER_PLANE; j++) {
        Satellite curSat = new Satellite();
        curSat.satelliteSequence = j;
        curPlaneSats.add(curSat);
      }
      satellites.put(i, curPlaneSats);
    }
  }
  void associateNeighborSats() {
  }

  void drawSatellites() {
    pushMatrix();
    rotateX(radians(90));
    for (Map.Entry<Integer, ArrayList<Satellite>> orbitalPlane : satellites.entrySet()) {
      int plane = orbitalPlane.getKey();
      ArrayList<Satellite> sats = orbitalPlane.getValue();
      pushMatrix();
      rotateZ(radians(plane * (360.0 / Constants.SAT_PLANES)));
      rotateX(radians(-orbit_inclination));  // Satellite Inclination
      stroke(255);
      noFill();
      ellipse(0, 0, Constants.SAT_RADIUS * Constants.SCALE * 2, Constants.SAT_RADIUS * Constants.SCALE * 2);

      for (Satellite sat : sats) {
        pushMatrix();
        rotateZ(radians(sat.satelliteSequence * (360.0 / Constants.SATS_PER_PLANE)) - radians(frameCount * Constants.SAT_ROTATE_PER_TICK) + radians(plane * (Constants.ORBITAL_OFFSET)));
        translate(Constants.SAT_RADIUS * Constants.SCALE, 0);
        noFill();
        stroke(200);
        box(2);

        popMatrix();
      }

      popMatrix();
    }
    popMatrix();
  }
}

class Satellite {
  int satelliteSequence;
}
