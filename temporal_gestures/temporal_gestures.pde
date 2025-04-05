float TEMPORAL_GRAPH_SIZE=300;
float GESTURE_MATCH_ERROR_THRESHOLD=5; //some will be as different as 8 but there should be at least one under 5

Gesture currentGesture;
ArrayList<Gesture> gestures;
ArrayList<Template> templates;

enum State{
  DRAW,
  DISPLAY
}

State state;

void setup() {
  size(1200, 1080);
  gestures = new ArrayList<Gesture>();
  currentGesture = new Gesture(); //FIXME: this one will always be empty and is just initiated to avoid a NPE 
  state = State.DRAW;
  templates = generateTemplates();
}

void draw() {
  background(0);
  switch(state){
    case DRAW:
      currentGesture.draw();
    break;
    case DISPLAY:
      currentGesture.drawResampled();
      currentGesture.drawTemporalGraph(0);
      drawTemplates();
      //int offset =0;
      //for(Gesture g: gestures){
      //  g.drawTemporalGraph(offset);
      //  offset+=TEMPORAL_GRAPH_SIZE;
      //}
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
  //currentGesture.printResampledPoints();
  gestures.add(currentGesture);
  state = State.DISPLAY;
  match();
}


void drawTemplates(){
  float x_offset = 0;
  float y_offset = 0;
  for(Template t: templates){
    t.drawTemporalGraph(currentGesture, x_offset, y_offset);
    x_offset += TEMPORAL_GRAPH_SIZE;
    if((x_offset/TEMPORAL_GRAPH_SIZE)>3){
      x_offset = 0;
      y_offset += TEMPORAL_GRAPH_SIZE;
    }
  }
}

void match(){
  String bestMatch = "";
  float leastDiff = 1000000;
  for(Template t: templates){
    float diff = currentGesture.compare(t);
    println(t.name + ": "+ nf(diff, 0, 3));
    if(diff < leastDiff){
      leastDiff = diff;
      bestMatch = t.name;
    }
  }
  if(leastDiff > GESTURE_MATCH_ERROR_THRESHOLD){
    println("The gesture was not matched to any template, with an error above the threshold for all templates.");
  }else{
    println("The best match is " + bestMatch + " with an error of " + nf(leastDiff, 0, 3));
  }
}
