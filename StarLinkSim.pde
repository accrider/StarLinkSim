import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import java.util.List;
import java.util.Queue;
import java.util.PriorityQueue;
import java.util.Arrays;
import java.util.Map;

PeasyCam cam;
Globe globe = new Globe();
Orbits orbits = new Orbits();

void setup() {
  size(800, 800, P3D); 
  frameRate(24); // Lock Framerate
  cam = new PeasyCam(this, 0, 0, 0, 1000);
  globe.init();
  globe.addCity(0, 0, color(255, 0, 0), "0,0");
  globe.addCity(40.7, -74, color(0, 128, 128), "NY");
  orbits.initializeSatelliteMap();
}

void draw() {
  background(0);
  globe.drawGlobe();
  orbits.drawSatellites();
}
