class Projectile extends GameObject implements IDeltaSpeed, IEffect {
  
  protected float d;
  protected float speed;
  protected PVector dir;
  protected float hSpeed, vSpeed;
  protected PVector v;
  protected PVector dX, dY, dVx, dVy, dS;
  protected float gravity;
  protected float targetSpeed;
  protected float referenceSpeed;
  
  Projectile(Transform transform, float speed) {
     super(transform);
     this.speed = speed;
     dir = transform.dir;
     aspectRatio = 1;
     d = transform.getSize();
     v = PVector.mult(dir, speed);
     referenceSpeed = PVector.dot(xVersor, v);
     vSpeed = PVector.dot(yVersor, v);
     targetSpeed = referenceSpeed;
     hSpeed = referenceSpeed;
     gravity = 0;
  }
  
  void update(float elapsedTime) { 
    super.update(elapsedTime);
    
    hSpeed = lerp(hSpeed, targetSpeed, 0.05);
    
    // X
    dX = PVector.mult(xVersor, hSpeed * elapsedTime);
    
    // Y
    vSpeed += gravity * elapsedTime;
    dY = PVector.mult(yVersor, vSpeed * elapsedTime);
    
    // S - combinado
    dS = PVector.add(dX,dY);
    
    transform.setPos(transform.getPos().add(dS));
  }
  
  void render() {
    super.render();
  }
  
  void drawObject() {
    drawProjectile(d);
  }
  
  public void addSpeed(float speedFactor) {
    targetSpeed = referenceSpeed + speedFactor;
  }
  
  void playerEffect(GameObject obj) {
    lvl.objects.remove(this);
  }
  
}
