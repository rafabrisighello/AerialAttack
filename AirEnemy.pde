class AirEnemy extends Enemy implements IEffect {
     
  AirEnemy(Transform transform, float speed) {
      super(transform, speed);
      aspectRatio = 0.2;
      w = transform.getSize();
      h = w * aspectRatio;
      deltaAngle = PI/12;
      projType = 1;
      orient = dir;
      cicleTime = 0.8;
   }
   
   void update(float elapsedTime) {
     super.update(elapsedTime);  
   }
   
   void render () {
    super.render();
   }
   
   void drawObject() {
     drawEnemyPlane(w,h);  
   }
  
  void shotPlayer() {
     PVector shotDir = calcShotDir(relPos); 
     Transform shotTransf = new Transform(transform.getPos().x + w + 20, transform.getPos().y, 10, shotDir);
     Projectile proj = new Projectile(shotTransf, hSpeed + 200);
     lvl.objects.add(proj);
     lvl.speedShifters.add(proj);
  }  //<>// //<>//
  
  void playerEffect(GameObject objOther) {
    if(objOther instanceof Projectile || objOther instanceof Enemy) {
      lvl.score += 100;  
      lvl.objects.remove(this);
    }
    else if (objOther instanceof Player) {
      lvl.objects.remove(this);
    }
  }
  
}
