class Globe {
  PShape globe;
  ArrayList<City> cities = new ArrayList<City>();

  void init() {
    PImage earth = loadImage("tex.jpg");
    globe = createShape(SPHERE, Constants.EARTH_RADIUS * Constants.SCALE); 
    globe.setStroke(false);
    globe.setTexture(earth);
  }
  ArrayList<City> getCities() {
    return cities;
  }
  City getCity(String searchName) {
    for (City c : cities) {
      if (c.name == searchName) {
        return c;
      }
    }
    return null;
  }

  // Uses path finding to get the path between two cities, returns total distance.
  float connectCities(City start, City end) {

    Queue<QueueItem> queue = new PriorityQueue<QueueItem>(new QueueItemComp());
    Set<Satellite> closedSet = new HashSet<Satellite>();
    for (Satellite s : start.connectedSats) {
      queue.add(new QueueItem(s, start, s.currentLocation.dist(start.currentLocation)));
    }
    //queue.addAll(start.connectedSats);
    QueueItem finalQueue = null;
    boolean found = false;
    while (!queue.isEmpty() && !found) {
      QueueItem s = queue.poll();
      closedSet.add(s.cur);
      for (Satellite n : s.cur.neighbors) {
        if (n.connectedCities.contains(end)) {
          finalQueue = new QueueItem(n, s, s.dist + n.currentLocation.dist(s.cur.currentLocation));
          found = true;
        }
        if (!closedSet.contains(n)) {
          queue.add(new QueueItem(n, s, s.dist + n.currentLocation.dist(s.cur.currentLocation)));
        }
      }
    }
    stroke(0, 255, 0);
    strokeWeight(4);
    float connectionDist = 0;
    if (finalQueue != null) {
      line(end.currentLocation.x, end.currentLocation.y, end.currentLocation.z, finalQueue.cur.currentLocation.x, finalQueue.cur.currentLocation.y, finalQueue.cur.currentLocation.z);
      connectionDist = end.currentLocation.dist(finalQueue.cur.currentLocation);
      while (finalQueue != null) {
        if (finalQueue.prev == null && finalQueue.prevCity != null) {
          line(finalQueue.cur.currentLocation.x, finalQueue.cur.currentLocation.y, finalQueue.cur.currentLocation.z, finalQueue.prevCity.currentLocation.x, finalQueue.prevCity.currentLocation.y, finalQueue.prevCity.currentLocation.z);
          connectionDist += finalQueue.cur.currentLocation.dist(finalQueue.prevCity.currentLocation);
        } else if (finalQueue.prev != null) {
          line(finalQueue.cur.currentLocation.x, finalQueue.cur.currentLocation.y, finalQueue.cur.currentLocation.z, finalQueue.prev.cur.currentLocation.x, finalQueue.prev.cur.currentLocation.y, finalQueue.prev.cur.currentLocation.z);
          connectionDist += finalQueue.cur.currentLocation.dist(finalQueue.prev.cur.currentLocation);
        }
        finalQueue = finalQueue.prev;
      }
    }
    strokeWeight(1);
    return connectionDist;
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
      c.clearConnections();
    }


    popMatrix();
  }

  void addCity(float lng, float lat, color c, String name) {
    cities.add(new City(lng, lat, c, name));
  }
}

class QueueItemComp implements Comparator<QueueItem> {
  public int compare(QueueItem itm1, QueueItem itm2) {
    if (itm1.dist > itm2.dist) {
      return 1;
    } else {
      return -1;
    }
  }
}
