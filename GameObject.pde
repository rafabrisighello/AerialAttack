class GameObject implements IGameObject {
    
   protected Transform transform;
   protected int colliderType;
   protected float aspectRatio;
   
   GameObject(Transform transform) {
     this.transform = transform;
   }
   
   void render() {
     pushMatrix();
       translate(transform.getPos().x, transform.getPos().y);
       drawObject();
     popMatrix();
   };
   
   void update(float elapsedTime) {
     this.render();
     this.checkBoundaries();
   }
   
   float[] getColliderCoords() {
    float [] coords = new float[4];
    coords[0] = transform.getPos().x;
    coords[1] = transform.getPos().y;
    coords[2] = transform.getSize();
    coords[3] = transform.getSize() * aspectRatio;
    return coords;
  }
  
  void checkBoundaries() {
   PVector objPos = transform.getPos();
   if(objPos.x < 0 || objPos.x > wid || objPos.y < 0 || objPos.y > hei) {
     lvl.objects.remove(this);
     print(lvl.objects);
   } 
  }  
  
  void drawObject(){};
}
