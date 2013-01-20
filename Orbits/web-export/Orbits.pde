/*  Assignment 1 - Part A, and B, and C.
    Jake Cataford
    
    Creates some random circles and nested orbits, then swarms the mouse on click.
*/
import javax.media.opengl.GL2;

int LERP = 5;


boolean mouseIsDown = false;
Chain chain;


void setup() {

  size(1000,600, OPENGL);
  chain = new Chain(50);
  
  
}

void mousePressed() {
  mouseIsDown = true;
}

void mouseReleased(){
  mouseIsDown = false; 
}

void draw() {
 
 if(mouseIsDown) {
   fill(255,0,255,100);
 }else{
   fill(255,0,255,200);
 }
 
 
 
 directionalLight(255, 0, 255, -1, 0, 0);
 directionalLight(255, 0, 255, -1, 0, -1);
 directionalLight(255, 0, 255, -1, 0, 1);
 
 pushMatrix();
   translate(-1000,-1000,-1000);
   rotate(0,PI/5,0,1);
   rect(0,0,10000,6000);
 popMatrix();
 
 
 
 chain.update();
 
 
 
  
 
  
}
class Chain {
 
 ArrayList <Drawable> displayList = new ArrayList<Drawable>(); 
  
 Chain(int number){
   for(int i = 0; i < 30; i++)
   {
    float r = random(0,1);
    if(r > 0.5f) {
      displayList.add(new OrbitCircle(random(5,50),random(10,20),random(5,10),random(0,1000),random(0,600)));
    }else{
      displayList.add(new DoubleCircle(random(5,50),random(10,100),random(5,10),random(0,1000),random(0,600)));
    }
  } 
 }
 
 void update() {
    
   colorMode(HSB, 255);
   for(int i = 0; i < 30; i ++)
   {
     fill(150,i*255/displayList.size(),100);
     displayList.get(i).update(i);
   }
   
 }
 
 ArrayList <Drawable> getMembers() {
  
    return displayList; 
 }
 
 void addNew() {
    
    float r = random(0,1);
    if(r > 0.5f) {
      displayList.add(new OrbitCircle(random(5,50),random(10,20),random(5,10),random(0,1000),random(0,600)));
    }else{
      displayList.add(new DoubleCircle(random(5,50),random(10,100),random(5,10),random(0,1000),random(0,600)));
    }
   
 }
 
 void remove() {
    displayList.remove(displayList.size()-1); 
 }
  
}
class DoubleCircle implements Drawable {
 
 private float orbitRadius = 100;
 private float orbitSpeed = 10;
 private float orbitCenterX = 400;
 private float orbitCenterY = 400;
 private float originalPositionX = 400;
 private float originalPositionY = 400;
 private float _size = 50;
 private ArrayList<Point3D> history_nested = new ArrayList();
 private ArrayList<Point3D> history = new ArrayList();
 
 
 DoubleCircle(float size, float radius, float speed, float x, float y) {
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
  translate(sin(frameCount/orbitSpeed)*orbitRadius + orbitCenterX, cos(frameCount/orbitSpeed)*orbitRadius + orbitCenterY,cos(frameCount/orbitSpeed-2)*orbitRadius/10);
  
  pushMatrix();
     sphere(_size);
      history.add(new Point3D(orbitCenterX, orbitCenterY,0));
    pushMatrix();
      translate(cos(frameCount/orbitSpeed+2)*orbitRadius, sin(frameCount/orbitSpeed+2)*orbitRadius,cos(frameCount/orbitSpeed-2)*orbitRadius*2);
      sphere(_size-1);
    popMatrix();
    stroke(255,0,0);
    line(0,0,0,cos(frameCount/orbitSpeed+2)*orbitRadius, sin(frameCount/orbitSpeed+2)*orbitRadius,cos(frameCount/orbitSpeed-2)*orbitRadius*2);
    noStroke();
  popMatrix();
  popMatrix();
  
  //shift history matrix and add new value
  stroke(246,150,255);
  noFill();
  beginShape();
  for(int j = history.size()-1; j >= 0 ; j--) {
     
     vertex(sin(frameCount+(j*2)/orbitSpeed)*orbitRadius + history.get(j).getX(), cos(frameCount+(j*2)/orbitSpeed)*orbitRadius + history.get(j).getY(),cos(frameCount+(j*2)/orbitSpeed-2)*orbitRadius/10);

  }
  if(history.size() > 20) {
    history.remove(0);
  }
  endShape();
  beginShape();
  for(int j = history.size()-1; j >= 0 ; j--) {
     
     vertex(sin(frameCount+(j*2)/orbitSpeed)*orbitRadius + history.get(j).getX() + cos(frameCount+(j*2)/orbitSpeed+2)*orbitRadius, cos(frameCount+(j*2)/orbitSpeed)*orbitRadius + history.get(j).getY() + sin(frameCount+(j*2)/orbitSpeed+2)*orbitRadius,cos(frameCount+(j*2)/orbitSpeed-2)*orbitRadius/10 + cos(frameCount+(j*2)/orbitSpeed-2)*orbitRadius*2);
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
interface Drawable {
  
  void update(int i);
  float getX();
  float getY();
  
}
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
class Point3D {
 
  private float  coords [] = {0,0,0};
  
  Point3D(float x,float y,float z)
  {
    coords[0] = x;
    coords[1] = y;
    coords[2] = z;
  } 
  
  float getX() {
    return coords[0]; 
  }
  
  float getY() {
    return coords[1];
  }
  
  float getZ() {
    return coords[2];
  }
}

