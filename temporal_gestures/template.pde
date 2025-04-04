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
  
}

  //Generate pre-determined templates
 ArrayList<Template> generateTemplates(){
     StaticTemplateData templateData = new StaticTemplateData();
     ArrayList<Template> static_templates = new ArrayList<Template>();
     
     static_templates.add(new Template(templateData.getSlowFastFastTemplatePoints(), "slow_fast_fast"));    
     static_templates.add(new Template(templateData.getSlowFastFastTemplatePoints(), "fast_fast_slow"));  
     static_templates.add(new Template(templateData.getFastPauseFastFastTemplatePoints(), "fast_pause_fast_fast"));  
     static_templates.add(new Template(templateData.getFastFastPauseFastTemplatePoints(), "fast_fast_pause_fast"));
     static_templates.add(new Template(templateData.getStableTemplatePoints(), "stable"));
     static_templates.add(new Template(templateData.getSpeedupTemplatePoints(), "speedup"));
     static_templates.add(new Template(templateData.getSlowdownTemplatePoints(), "slowdown"));
     static_templates.add(new Template(templateData.getSquareTemplatePoints(), "square"));
     
     return static_templates;

 }
