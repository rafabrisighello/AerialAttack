class Player extends GameObject implements IEffect {

  private float w, h;
  private PVector dir;
  private float vSpeed = 200;
  private boolean up = false; 
  private boolean down = false;
  private int x, y;
  private float burnRate, refBurnRate; 
  public float gas;
  public int armor, ammo, bombs;
  
  Player(Transform transform) {
    super(transform);
    this.dir = new PVector(0,0);
    aspectRatio = 0.2;
    w = transform.getSize();
    h = w * aspectRatio;
    gas = 500;
    refBurnRate = 8;
    burnRate = refBurnRate;
    armor = 3;
    ammo = 10;
    bombs = 5;
  }
  
  void update(float elapsedTime) {
    
    super.update(elapsedTime);
        
    if(up) {
       y = -1;
    }
    if(down) {
       y = 1; 
    }
    if(!up && !down) {
       y = 0; 
    }
    
    if((transform.getPos().y < 100 && y == -1) || (transform.getPos().y > 600 && y == 1)) {
      vSpeed = 0; 
    }
    else vSpeed = 100;
    
    dir.set(x,y);
    PVector m = PVector.mult(dir, vSpeed * elapsedTime);
    transform.setPos(transform.getPos().add(m));
    
    if(lvl.playState == 1) {
      gas -= burnRate * elapsedTime;
    }
        
  }
  
  void render() {
    super.render();
  }

  void drawObject() {
    drawPlane(w,h);
  }
  
  void mouseEvent() {
    shotBack();  
  }
   
  void keyPressed() {
    if(key == ' ') {
       shotFront();
    }
    if(key == 'w') {
       up = true;
    }
    if(key == 's') {
       down = true;
    }
    if(key == CODED ) {
      if(keyCode == CONTROL) {
        dropBomb();
      }
    }
  }
  
  void keyReleased() {
    if(key == 'w') {
       up = false;
    }
    if(key == 's') {
       down = false;
    }
  }
  
  PVector mousePos() {
    return new PVector(mouseX, mouseY); 
  }
  
  void shotBack() {
     if(mouseX > wid / 2 && ammo > 0) {
      PVector mousePoint = mousePos();
      PVector projDir = getRelPos(mousePoint, transform.getPos()).normalize();
      Transform projT = new Transform(transform.getPos().x + transform.getSize() + 10, transform.getPos().y, 10, projDir);
      Projectile proj =  new Projectile(projT, 300);
      lvl.objects.add(proj);
      lvl.speedShifters.add(proj);
      if(lvl.playState == 1) ammo -= 1;
    }
  }
  
  void shotFront() {
    if(ammo > 0) {
      PVector projDir = new PVector(-1,0);
      Transform projT = new Transform(transform.getPos().x - 30, transform.getPos().y, 10, projDir);
      Projectile proj =  new Projectile(projT, 400);
      lvl.objects.add(proj);
      lvl.speedShifters.add(proj);
      if(lvl.playState == 1) ammo -= 1;
    }
  }
  
  void dropBomb() {
    if(bombs > 0) {
      PVector projDir = new PVector(0,1);
      Transform projT = new Transform(transform.getPos().x + 30, transform.getPos().y + 20, 15, projDir);
      float initSpeed;
      if(y > 0) {
        initSpeed = 100;
      }
      else initSpeed = 0;
      Bomb bomb = new Bomb(projT, initSpeed);
      lvl.objects.add(bomb);
      lvl.speedShifters.add(bomb);
      if(lvl.playState == 1) bombs -= 1;
    }
  }
  
  public void deltaBurn(float delta) {
    burnRate =  refBurnRate + delta; 
  }
  
  void setGas() {
    gas += 100;
    if(gas > 500) {
      gas = 500;  
    }
  }
  
  void setAmmo() {
    ammo += 10;
    if(ammo > 20) {
      ammo = 20;  
    }
  }
  
  void setBombs() {
    bombs += 5;
    if(bombs > 10) {
      bombs = 10;  
    }
  }
  
  void playerEffect(GameObject objOther) {
    if(objOther instanceof Enemy) { 
      armor = 0;
    }
    else if (objOther instanceof Projectile) {
      armor -= 1;  
    }
    else if (objOther instanceof GunPuP) {
      setAmmo(); 
    }
    else if (objOther instanceof BombPuP) {
      setBombs(); 
    }
    else if (objOther instanceof PuP) {
      setGas(); 
    }
  }
  
}
