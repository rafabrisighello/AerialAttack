class GndEnemy extends Enemy implements IEffect {
    
   GndEnemy(Transform transform, float speed) {
      super(transform, speed);
      dir = new PVector(1,0);
      aspectRatio = 3;
      w = transform.getSize();
      h = w * aspectRatio;
      orient = new PVector(2,-1);
      deltaAngle = PI/10;
      projType = 3;
      cicleTime = 0.7;
   }
   
  void update(float elapsedTime) {
     super.update(elapsedTime);  
   }
   
  void render () {
    super.render();
  }
  
  void drawObject() {
    drawGndEnemy(w, h);  
  }
  
  void shotPlayer() {
    PVector shotDir = calcShotDir(relPos); 
    Transform shotTransf = new Transform(transform.getPos().x + w / 2, transform.getPos().y - h / 4, 10, shotDir);
    Projectile proj = new Projectile(shotTransf, hSpeed + 100);
    lvl.objects.add(proj);
    lvl.speedShifters.add(proj);
  }
  
  void playerEffect(GameObject objOther) {
    if(objOther instanceof Projectile || objOther instanceof Enemy)
      lvl.score += 250;  
      lvl.objects.remove(this);
  }
  
}
