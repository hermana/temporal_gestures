class Template{
  
  String name;
  ArrayList<Point> points;
  
  Template(ArrayList<Point> pts, String n){
    points = new ArrayList<Point>(); 
    this.name = n;
    for(Point p: pts){
      this.points.add(new Point(p));
    }
  }
  
  void drawTemporalGraph(Gesture g, float x_offset, float y_offset){
    strokeWeight(3);
    stroke(0, 255, 255);
    fill(20,20,20);
    pushMatrix();
      translate(x_offset, y_offset);
      rect(0, 0, TEMPORAL_GRAPH_SIZE, TEMPORAL_GRAPH_SIZE);
      for(int i=0; i<this.points.size(); i++){
        point(i*(TEMPORAL_GRAPH_SIZE/NUM_RESAMPLED_POINTS), this.points.get(i).getTime()*TEMPORAL_GRAPH_SIZE);
      }
      stroke(255, 0, 255);
      for(int i=0; i<g.resampledPoints.size(); i++){
        point(i*(TEMPORAL_GRAPH_SIZE/NUM_RESAMPLED_POINTS), g.resampledPoints.get(i).getTime()*TEMPORAL_GRAPH_SIZE);
      }
    popMatrix();
  }
  
}

  //Generate pre-determined templates
 ArrayList<Template> generateTemplates(){
     StaticTemplateData templateData = new StaticTemplateData();
     ArrayList<Template> static_templates = new ArrayList<Template>();
     
     static_templates.add(new Template(templateData.getStableTemplatePoints(), "stable"));
     static_templates.add(new Template(templateData.getSpeedupTemplatePoints(), "speedup"));
     static_templates.add(new Template(templateData.getSlowdownTemplatePoints(), "slowdown"));
     static_templates.add(new Template(templateData.getSquareTemplatePoints(), "square"));
     
     static_templates.add(new Template(templateData.getSlowFastFastTemplatePoints(), "slow_fast_fast"));    
     static_templates.add(new Template(templateData.getFastFastSlowTemplatePoints(), "fast_fast_slow"));  
     static_templates.add(new Template(templateData.getFastPauseFastFastTemplatePoints(), "fast_pause_fast_fast"));  
     static_templates.add(new Template(templateData.getFastFastPauseFastTemplatePoints(), "fast_fast_pause_fast"));

     
     return static_templates;

 }
