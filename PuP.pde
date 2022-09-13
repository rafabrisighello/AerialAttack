class PuP extends GameObject implements IDeltaSpeed, IEffect {
  
  protected float w, h;
  
  protected float hSpeed, referenceSpeed, targetSpeed;
  
  protected PVector dX;
  
  PuP(Transform transform) {
    super(transform);
    w = transform.getSize();
    aspectRatio = 2;
    h = w * aspectRatio;
    referenceSpeed = PVector.dot(transform.dir, xVersor) * lvl.masterSpeed;
    targetSpeed = referenceSpeed;
    hSpeed = referenceSpeed;
  }
  
  void update(float elapsedTime) {
    
    super.update(elapsedTime);  
    
    hSpeed = lerp(hSpeed, targetSpeed, 0.05);
    
    dX = PVector.mult(xVersor, hSpeed * elapsedTime);
    
    transform.setPos(transform.getPos().add(dX));
  }
  
  void drawObject() {
    drawGasPuP(w, h);  
  }
  
  public void addSpeed(float speedFactor) {
    targetSpeed = referenceSpeed + speedFactor;
  }
  
  void playerEffect(GameObject objOther) {
    if(objOther instanceof Player) {
      lvl.objects.remove(this);
    }
  }
  
}
