class Point{

  float x;
  float y;
  float t;
  
  Point(float X, float Y, float T){
    this.x = X;
    this.y = Y;
    this.t = T;
  }
  
  float dist(Point that){
    PVector thisPoint = new PVector(this.x, this.y);
    PVector thatPoint = new PVector(that.x, that.y);
    return thisPoint.dist(thatPoint);
  }
  
  void setTime(float t){
    this.t = t;
  }
}
