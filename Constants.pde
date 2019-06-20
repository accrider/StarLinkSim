class Constants {
  final static float EARTH_RADIUS = 6371;
  final static float SAT_ALT = 550;
  final static float SAT_ANTENNA_DIST = 1200;
  final static float SAT_RADIUS = EARTH_RADIUS + SAT_ALT;
  final static float SAT_PERIOD = 1.59171; // Hrs
  final static float TIME_SCALE = 0.01; // frameCount * TIME_SCALE = hrs passed.
  final static float GLOBE_ROTATE_PER_TICK = (360.0 / (24 * 60)) * TIME_SCALE;
  final static float SAT_ROTATE_PER_TICK = (360.0 / (SAT_PERIOD * 60)) * TIME_SCALE;
  final static float SCALE = .04f;
  final static int SAT_PLANES = 24;
  final static int SATS_PER_PLANE = 66;
  final static float ORBITAL_OFFSET = (4 / SAT_PLANES);
}
