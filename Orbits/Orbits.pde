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
