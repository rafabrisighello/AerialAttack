class Enemy extends GameObject implements IDeltaSpeed {
    
  protected float hSpeed;
  protected float targetSpeed;
  protected float referenceSpeed;
  protected PVector dir, v, dX;
  protected float w, h;
  
  // Target Seek
  protected PVector relPos;
  protected boolean playerDetected;
  protected PVector orient;
  protected float deltaAngle;
  protected float elapsedCicleTime;
  protected float cicleTime;
  protected boolean shot;
  protected int projType;
  
  Enemy(Transform transform, float speed) {
    super(transform);
    dir = transform.dir;
    referenceSpeed = PVector.dot(dir, xVersor) * speed;
    targetSpeed = referenceSpeed;
    hSpeed = referenceSpeed;
  }
  
  void update (float elapsedTime) {
    super.update(elapsedTime); 
    
    hSpeed = lerp(hSpeed, targetSpeed, 0.05);
    
    dX = PVector.mult(xVersor, hSpeed * elapsedTime);
    
    transform.setPos(transform.getPos().add(dX));
    
    relPos = getRelPos(lvl.player.transform.getPos(), transform.getPos());
    
    playerDetected = detectAngle(relPos, orient, deltaAngle);  
    
    elapsedCicleTime += elapsedTime;
     
   if (playerDetected) {
    if(elapsedCicleTime > cicleTime) {
       shotPlayer();
      elapsedCicleTime = 0;
    }
   }
  }
  
  public float getSpeed() {
    return hSpeed;
  }
  
  
  public void addSpeed(float speedFactor) {
    targetSpeed = referenceSpeed + speedFactor;
  }
  
  
  protected PVector calcShotDir(PVector relPos) {
    if(lvl.player != null) {
      return relPos.normalize();
    }
    return null;
  }
  
  protected void shotPlayer() {}
  
}
