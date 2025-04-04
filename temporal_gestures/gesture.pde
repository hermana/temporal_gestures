int NUM_RESAMPLED_POINTS = 64;
int MIN_GESTURE_POINTS = 3; //minimum number of points before resampling

class Gesture{

  ArrayList<Point> originalPoints;
  ArrayList<Point> resampledPoints; 
  float _gestureStartTime;
  
  Gesture(){
    this.originalPoints = new ArrayList<Point>();
    this.resampledPoints = new ArrayList<Point>();
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
  
  void drawResampled(){
    strokeWeight(10);
    stroke(255, 0, 255);
    for(Point p: resampledPoints){
      point(p.x, p.y);
    }
  }
  
  void resample(){
    //only do this if the original points array exists
    if(this.originalPoints.size()>MIN_GESTURE_POINTS){
      // Compute total path length
      float totalLength = 0;
      float[] segmentLengths = new float[this.originalPoints.size() - 1];
    
      for (int i = 0; i < this.originalPoints.size() - 1; i++) {
        segmentLengths[i] = this.originalPoints.get(i).dist(this.originalPoints.get(i + 1));
        totalLength += segmentLengths[i];
      }
 
    
      // Determine new spacing
      float spacing = totalLength / (float(NUM_RESAMPLED_POINTS)- 1.0);
      float temporalSpacing = 1.0 / (float(NUM_RESAMPLED_POINTS));
      
      // Add the first point 
      this.resampledPoints.add(this.originalPoints.get(0)); 
      this.resampledPoints.get(0).setTime(0);
      
      float distanceAccumulated = 0;
      int currentIndex = 0;
    
      for (int i = 1; i < NUM_RESAMPLED_POINTS - 1; i++) {
        float targetDistance = i * spacing;
        float time = i * temporalSpacing;

        // Move along the original points until reaching the target distance
        while (currentIndex < segmentLengths.length && 
               distanceAccumulated + segmentLengths[currentIndex] < targetDistance) {
          distanceAccumulated += segmentLengths[currentIndex];
          currentIndex++;
        }
      
        if (currentIndex >= segmentLengths.length) break;
      
      // Interpolate between currentIndex and currentIndex + 1
        float segmentFraction = (targetDistance - distanceAccumulated) / segmentLengths[currentIndex];
        Point p1 = this.originalPoints.get(currentIndex);
        Point p2 = this.originalPoints.get(currentIndex + 1);
        PVector interpolated = PVector.lerp(new PVector(p1.x, p1.y), new PVector(p2.x, p2.y), segmentFraction);
  
        this.resampledPoints.add(new Point(interpolated.x, interpolated.y, time));
      }
      // Add the last point
      this.resampledPoints.add(this.originalPoints.get(this.originalPoints.size() - 1)); 
      this.resampledPoints.get(this.resampledPoints.size() -1).setTime(1);
    }
  }
 }
