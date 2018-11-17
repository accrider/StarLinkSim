class Orbits {
  float orbit_inclination = 53;

  // Orbital planes (0-?) and corresponding orbits
  HashMap<Integer, ArrayList<Satellite>> satellites = new HashMap<Integer, ArrayList<Satellite>>();

  void initializeSatelliteMap() {
    println("Initializing satellite map");
    for (int i = 0; i < Constants.SAT_PLANES; i++) {
      ArrayList<Satellite> curPlaneSats = new ArrayList<Satellite>();
      for (int j = 0; j < Constants.SATS_PER_PLANE; j++) {
        Satellite curSat = new Satellite();
        curSat.satelliteSequence = j;
        curPlaneSats.add(curSat);
      }
      satellites.put(i, curPlaneSats);
    }
    println("Done initializing satellite map");
    associateNeighborSats();
  }
  void associateNeighborSats() {
    println("Associating neighboring sats");
    for (Map.Entry<Integer, ArrayList<Satellite>> orbitalPlane : satellites.entrySet()) {
      int plane = orbitalPlane.getKey();
      ArrayList<Satellite> sats = orbitalPlane.getValue();
      for (Satellite sat : sats) {
        sat.neighbors.add(findSat(satellites.get(((plane + Constants.SAT_PLANES) - 1) % Constants.SAT_PLANES), ((sat.satelliteSequence + Constants.SATS_PER_PLANE + 1) % Constants.SATS_PER_PLANE)));
        sat.neighbors.add(findSat(satellites.get(((plane + Constants.SAT_PLANES) + 1) % Constants.SAT_PLANES), ((sat.satelliteSequence + Constants.SATS_PER_PLANE + 1) % Constants.SATS_PER_PLANE)));
        sat.neighbors.add(findSat(satellites.get(((plane + Constants.SAT_PLANES)) % Constants.SAT_PLANES), ((sat.satelliteSequence + Constants.SATS_PER_PLANE - 1) % Constants.SATS_PER_PLANE)));
        sat.neighbors.add(findSat(satellites.get(((plane + Constants.SAT_PLANES)) % Constants.SAT_PLANES), ((sat.satelliteSequence + Constants.SATS_PER_PLANE - 1) % Constants.SATS_PER_PLANE)));
      }
    }
    println("Done associating neighboring sats");
  }

  Satellite findSat(ArrayList<Satellite> sats, int seqNum) {
    for (Satellite s : sats) {
      if (s.satelliteSequence == seqNum) {
        return s;
      }
    }
    return null;
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
        //point(0,0);
        sat.currentLocation = new PVector(modelX(0, 0, 0), modelY(0, 0, 0), modelZ(0, 0, 0));

        popMatrix();
      }

      popMatrix();
    }
    popMatrix();
  }
  void drawSatelliteLinks() {
    for (Map.Entry<Integer, ArrayList<Satellite>> orbitalPlane : satellites.entrySet()) {
      ArrayList<Satellite> sats = orbitalPlane.getValue();
      for (Satellite sat : sats) {
        for (Satellite n : sat.neighbors) {
          line(sat.currentLocation.x, sat.currentLocation.y, sat.currentLocation.z, n.currentLocation.x, n.currentLocation.y, n.currentLocation.z);
        }
      }
    }
    
  }
}

class Satellite {
  int satelliteSequence;
  ArrayList<Satellite> neighbors = new ArrayList<Satellite>();
  PVector currentLocation;
}
