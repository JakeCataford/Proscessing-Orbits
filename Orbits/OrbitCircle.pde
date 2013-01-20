class OrbitCircle implements Drawable {
 
 private float orbitRadius = 100;
 private float orbitSpeed = 10;
 private float orbitCenterX = 400;
 private float orbitCenterY = 400;
 private float originalPositionX = 400;
 private float originalPositionY = 400;
 private float _size = 50;
 
 private ArrayList<Point3D> history = new ArrayList();
 
 
 OrbitCircle(float size, float radius, float speed, float x, float y) {
   orbitRadius = radius;
   orbitCenterX = x;
   orbitCenterY = y;
   originalPositionX= x;
   originalPositionY = y;
   orbitSpeed = speed;
   _size = size;
   
 }
 
 void update(int i) {
   
  
   
  if(mouseIsDown)
  {
    if(i == 0){
      orbitCenterX -= (orbitCenterX - mouseX)/LERP;
      orbitCenterY -= (orbitCenterY - mouseY)/LERP;
    }else{
      orbitCenterX -= (orbitCenterX - chain.getMembers().get(i-1).getX())/LERP;
      orbitCenterY -= (orbitCenterY - chain.getMembers().get(i-1).getY())/LERP;
    }
  }else {
     orbitCenterX -= (orbitCenterX - originalPositionX)/10;
    orbitCenterY -= (orbitCenterY - originalPositionY)/10;
  }
  pushMatrix();
  translate(sin(frameCount/orbitSpeed)*orbitRadius + orbitCenterX, cos(frameCount/orbitSpeed)*orbitRadius + orbitCenterY,cos(frameCount/orbitSpeed-2)*orbitRadius*2);
  sphere(_size);
  history.add(new Point3D(orbitCenterX, orbitCenterY,0));
  popMatrix();
  
  //shift history matrix and add new value
  stroke(157,255,255);
  noFill();
  beginShape();
  for(int j = history.size()-1; j >= 0 ; j--) {
    vertex(sin(frameCount+(j*2)/orbitSpeed)*orbitRadius + history.get(j).getX(), cos(frameCount+(j*2)/orbitSpeed)*orbitRadius + history.get(j).getY(), cos(frameCount+(j*2)/orbitSpeed-2)*orbitRadius*2);
  }
  if(history.size() > 20) {
    history.remove(0);
  }
  endShape();
  noStroke();
   
 }
 
 float getX() {
   return this.orbitCenterX; 
 }
 
 float getY() {
   return this.orbitCenterY; 
 }
  
}
