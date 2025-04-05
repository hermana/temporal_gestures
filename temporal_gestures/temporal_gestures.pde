float TEMPORAL_GRAPH_SIZE=300;

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
  currentGesture.printResampledPoints();
  gestures.add(currentGesture);
  state = State.DISPLAY;
}


void drawTemplates(){
  float x_offset = 0;
  float y_offset = 0;
  for(Template t: templates){
    t.drawTemporalGraph(x_offset, y_offset);
    x_offset += TEMPORAL_GRAPH_SIZE;
    if((x_offset/TEMPORAL_GRAPH_SIZE)>3){
      x_offset = 0;
      y_offset += TEMPORAL_GRAPH_SIZE;
    }
  }
  
}
