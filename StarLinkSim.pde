import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import java.util.List;
import java.util.Queue;
import java.util.ArrayDeque;
import java.util.PriorityQueue;
import java.util.Arrays;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;

PeasyCam cam;
Globe globe = new Globe();
Orbits orbits = new Orbits();

boolean showSettingsPanel = false;

void setup() {
  size(800, 800, P3D); 
  frameRate(24); // Lock Framerate
  cam = new PeasyCam(this, 0, 0, 0, 1000);
  globe.init();
  globe.addCity(0, 0, color(255, 0, 0), "0,0");
  globe.addCity(40.7, -74, color(0, 128, 128), "NY");
  globe.addCity(20.5, 78.9, color(128, 200, 43), "India");
  globe.addCity(35.6, 139.7, color(255, 120, 30), "Tokyo");
  globe.addCity(-14.2, -51.9, color(255,120,30), "Brazil");
  orbits.initializeSatelliteMap();
}

void draw() {
  background(0);
  globe.drawGlobe();
  orbits.drawSatellites();
  orbits.drawSatelliteLinks();
  orbits.connectCities(globe.getCities());
  // Breadth first search for grabbing whatever
  City start = globe.getCity("Brazil");
  City end = globe.getCity("Tokyo");
  float connectionDist = globe.connectCities(start, end);
  
  
  cam.beginHUD();
  text(frameRate + " fps", 10, 20);
  text("Sats: " + orbits.getSatelliteCount(), 10, 40);
  text("Dist: " + connectionDist / Constants.SCALE + " km", 10, 60);
  float connectionTime = ((connectionDist / Constants.SCALE) / (299792.0)) * 1000;
  text("Time : " + connectionTime + " ms", 10, 80);
  cam.endHUD();
}

class QueueItem {
  City prevCity;
  Satellite cur;
  QueueItem prev;
  QueueItem(Satellite s) {
    cur = s;
  }
  QueueItem(Satellite s, QueueItem p) {
    cur = s;
    prev = p;
  }
  QueueItem(Satellite s, City c) {
    prevCity = c;
    cur = s;
  }
}
