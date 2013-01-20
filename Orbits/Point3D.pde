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
