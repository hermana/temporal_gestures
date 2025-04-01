
Gesture currentGesture;
ArrayList<Gesture> gestures;


void setup() {
  size(1080, 1080);
  gestures = new ArrayList<Gesture>();
  currentGesture = new Gesture(); //FIXME: this one will always be empty and is just initiated to avoid a NPE 
}

void draw() {
  background(0);
  stroke(255, 255, 255);
  currentGesture.draw();
}

void mousePressed(){
  currentGesture = new Gesture();
}


void mouseDragged(){
  //gesture continues
  currentGesture.addPoint(mouseX, mouseY, millis());
}


void mouseReleased(){
  //gesture ended, append to list
  currentGesture.resample();
  gestures.add(currentGesture);
}
