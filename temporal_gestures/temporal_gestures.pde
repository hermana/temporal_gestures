
Gesture currentGesture;
ArrayList<Gesture> gestures;


enum State{
  DRAW,
  DISPLAY
}

State state;

void setup() {
  size(1080, 1080);
  gestures = new ArrayList<Gesture>();
  currentGesture = new Gesture(); //FIXME: this one will always be empty and is just initiated to avoid a NPE 
  state = State.DRAW;
}

void draw() {
  background(0);
  switch(state){
    case DRAW:
      currentGesture.draw();
    break;
    case DISPLAY:
      currentGesture.drawResampled();
      break;
    default:
      break;
  }



}

void mousePressed(){
  state = State.DRAW;
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
  state = State.DISPLAY;
}
