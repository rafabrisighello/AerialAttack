class ChaseEnemy extends AirEnemy implements IEffect{
 
  ChaseEnemy(Transform transform, float speed) {
     super(transform, speed);
     aspectRatio = 0.2;
     w = transform.getSize();
     h = w * aspectRatio;
     deltaAngle = PI/6;
     projType = 2;
     orient = dir;
     cicleTime = 0.8;
  }
  
  void render () {
    float drawX = transform.getPos().x;
    float drawY = transform.getPos().y; 
    fill(0, 128, 128);
    circle(drawX + w/4, drawY - h / 10, w/4);
    fill(255, 0, 0);
    rect(drawX, drawY, w, h);
    rect(drawX + 4 * w / 5, drawY - h, w / 5, h);
    fill(127, 0, 127);
    rect(drawX + w / 2, drawY + h/4, w / 4, h / 3);
  }
  
  void shotPlayer() {
     PVector shotDir = calcShotDir(relPos); 
     Transform shotTransf = new Transform(transform.getPos().x - 20, transform.getPos().y, 10, shotDir);
     Projectile proj = new Projectile(shotTransf, 400);
     lvl.objects.add(proj);
     lvl.speedShifters.add(proj);
  }
  
  void playerEffect(GameObject objOther) {
     if(objOther instanceof Projectile || objOther instanceof Enemy) {
      lvl.score += 150;  
      lvl.objects.remove(this);
    }
     else if (objOther instanceof Player) {
      lvl.objects.remove(this);
    }
  }
}
