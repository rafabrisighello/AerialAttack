class Transform {
  
  private float x, y, size;
  private PVector dir;
  
  Transform(float x, float y, float size, PVector dir) {
    this.x = x;
    this.y = y;
    this.size = size;
    PVector newDir = dir;
    this.dir = newDir.normalize();
  }
  
  public PVector getPos() {
     return new PVector(x,y);
  }
  
  public void setPos(PVector newPos) {
    x = newPos.x;
    y = newPos.y;
  }
  
  public float getSize() {
     return size; 
  }
  
  public void setSize(float size) {
     this.size = size;
  }
  
  public PVector getDir() {
     return dir; 
  }
  
  public void setDir(float x, float y) {
    PVector newDir = new PVector(x,y); 
    dir = newDir.normalize();
  }
}
