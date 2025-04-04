int NUM_RESAMPLED_POINTS = 64;
int MIN_GESTURE_POINTS = 3; //minimum number of points before resampling

class Gesture{

  ArrayList<Point> originalPoints;
  ArrayList<Point> resampledPoints; 
  
  Gesture(){
    this.originalPoints = new ArrayList<Point>();
    this.resampledPoints = new ArrayList<Point>();
  }
  
  void addPoint(float x, float y, float t){
    this.originalPoints.add(new Point(x, y, t));
  }


  void draw(){
    strokeWeight(10);
    stroke(255, 255, 0);
    for(Point p: this.originalPoints){
      point(p.x, p.y);
    }
  }
  
  void drawTemporalGraph(int x_offset){
    strokeWeight(3);
    pushMatrix();
      translate(x_offset, 0);
      for(int i=0; i<this.resampledPoints.size(); i++){
        point(i*(TEMPORAL_GRAPH_SIZE/NUM_RESAMPLED_POINTS), height - this.resampledPoints.get(i).getTime()*TEMPORAL_GRAPH_SIZE);
      }
    popMatrix();
  }
  
  void drawResampled(){
    strokeWeight(10);
    stroke(255, 0, 255);
    for(Point p: resampledPoints){
      point(p.x, p.y);
    }
  }
  
   // PRINT THE RESAMPLED POINTS, FOR CREATING GESTURES 
  void printResampledPoints(){
    PrintWriter output = createWriter("raw_template_data/template.txt");
    for(Point p: resampledPoints){
      output.println("points.add(new Point(" + nf(p.x, 0, 2) + ", " + nf(p.y, 0, 2) + ", "+ nf(p.t, 0, 2)+"));");
    }
    output.flush(); 
    output.close(); 
  }
  
  
  void resample(){
    //only do this if the original points array exists
    if(this.originalPoints.size()>MIN_GESTURE_POINTS){
      float totalTime = this.originalPoints.get(this.originalPoints.size()-1).getTime() - this.originalPoints.get(0).getTime();
      // Compute total path length
      float totalLength = 0;
      float[] segmentLengths = new float[this.originalPoints.size() - 1];
    
      for (int i = 0; i < this.originalPoints.size() - 1; i++) {
        segmentLengths[i] = this.originalPoints.get(i).dist(this.originalPoints.get(i + 1));
        totalLength += segmentLengths[i];
      }
 
    
      // Determine new spacing
      float spacing = totalLength / (float(NUM_RESAMPLED_POINTS)- 1.0);

      // Add the first point 
      this.resampledPoints.add(new Point(this.originalPoints.get(0).x, this.originalPoints.get(0).y, 0)); 
      
      float distanceAccumulated = 0;
      int currentIndex = 0;
    
      for (int i = 1; i < NUM_RESAMPLED_POINTS - 1; i++) {
        float targetDistance = i * spacing;

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
  
        //Interpolate between the times and then normalize 
        float startTime = this.originalPoints.get(0).getTime();//FIXME: somehow my fist element (.get(0)) time is set to 0 always?
        float interpolatedTime = lerp((p1.t-startTime)/totalTime, (p2.t-startTime)/totalTime, segmentFraction);

        this.resampledPoints.add(new Point(interpolated.x, interpolated.y, interpolatedTime));
      }
      // Add the last point
      this.resampledPoints.add(this.originalPoints.get(this.originalPoints.size() - 1)); 
      this.resampledPoints.get(this.resampledPoints.size() -1).setTime(1);
    }
  }
 }
