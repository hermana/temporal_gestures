class Gesture{

  ArrayList<Point> originalPoints;
  ArrayList<Point> resampledPoints; 
  
  Gesture(){
    originalPoints = new ArrayList<Point>();
  }
  
  void addPoint(float x, float y, float t){
    originalPoints.add(new Point(x, y, t));
  }


  void draw(){
    strokeWeight(10);
    stroke(255, 255, 0);
    for(Point p: originalPoints){
      point(p.x, p.y);
    }
  }
}
