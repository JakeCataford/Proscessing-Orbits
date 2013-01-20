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
