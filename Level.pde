class Level implements IGameObject {
  
  private int level, score, gameStage;
  
  private Player player;
  
  private HUD hud;
  
  public CopyOnWriteArrayList<GameObject> objects;
  
  public CopyOnWriteArrayList<IDeltaSpeed> speedShifters;
  
  private float tInstanceEnemy, cicleTime, gameTime, PuPTime, tInstancePuP;
  
  public float masterSpeed = 200;
  
  private int playState = 0;
  
  private int pupType;
  
  Level(int level){
    this.level = level;
    objects = new CopyOnWriteArrayList<GameObject>();
    speedShifters = new CopyOnWriteArrayList<IDeltaSpeed> ();
    initializeGame();
    hud = createHUD();
  }
  
  void update(float elapsedTime) {
    
    for(Iterator<GameObject> iter = objects.iterator(); iter.hasNext();) {
      GameObject object = iter.next();
      object.update(elapsedTime); 
      checkCollisions();
      render();
    }
    
    gameTick(playState, elapsedTime);
    
    if(gameTime > 80) {
       gameStage = 0;
    }
    else if ( gameTime > 40 && gameTime <= 80) {
       gameStage = 1;
    }
    else if ( gameTime > 0){
       gameStage = 2; 
    }
    else {
      gameStage = 3;  
    }
    
    if(player.armor == 0 || player.gas <= 0) {
      objects.remove(player);
      playState = 2;
    }
    
  }
  
  void render() {
    fill(200, 255, 0);
    rect(0, hei - 30, wid, 30);
  }
  
  Player createPlayer() {
    PVector playerDir = new PVector(-1,0);
    Transform playerT = new Transform(540, 360, 60, playerDir);
    player = new Player(playerT);
    objects.add(player);
    return player;
  }
  
  HUD createHUD() {
    Transform hudT = new Transform(0, 0, 0, new PVector(0,0));
    hud = new HUD(hudT);
    objects.add(hud);
    return hud;
  }
  
  void createEnemy() {
     int enemyChoice = random.nextInt(3);
     PVector enemyDir;
     Transform enemyT;
     Enemy enemy;
     switch(enemyChoice) {
       case 0:
        enemyDir = new PVector(1,0);
        enemyT = new Transform(0, random(200, 500), random(60,80), enemyDir);
        enemy = new AirEnemy(enemyT, random(masterSpeed + 50, masterSpeed + 150));
        break;
       case 1:
        enemyDir = new PVector(-1,0);
        enemyT = new Transform(1024, random(200, 500), random(60,80), enemyDir);
        enemy = new ChaseEnemy(enemyT, random(masterSpeed - 50, masterSpeed + 50));
        break;
       case 2:
        enemyDir = new PVector(1,0);
        enemyT = new Transform(0, 650, 30, enemyDir);
        enemy = new GndEnemy(enemyT, masterSpeed);
        break;
       default:
        enemy = null;
     } //<>//
     objects.add(enemy);
     speedShifters.add(enemy);
  }
  
  void createPuP(int pupType) {
    
    PuP powerUp = null;
    Transform PuPT;
    PVector dir = new PVector(1,0);
    
    switch(pupType) {
      case 0:
        PuPT = new Transform(0, random(200, 600), 20, dir);
        powerUp = new PuP(PuPT);
        break;
      case 1:
        PuPT = new Transform(0, random(200, 600), 10, dir);
        powerUp = new GunPuP(PuPT);
        break;
      case 2:
        PuPT = new Transform(0, random(200, 600), 20, dir);
        powerUp = new BombPuP(PuPT);
        break;
      default:
        PuPT = new Transform(0, random(200, 600), 20, dir);
        powerUp = new PuP(PuPT);
        break;
    }
    
    objects.add(powerUp);
    speedShifters.add(powerUp);
  }
  
  void mouseEvent() {
    player.mouseEvent();
  }
  
  void keyPressed() {
    if(key == 'p') {
      if(playState == 0) playState = 1;
      if(playState == 2 || playState == 3) {
        playState = 1;
        initializeGame();
      }
    }
    if(key == 'd') {
        playerAccel(-50);
        player.deltaBurn(-3);
    }
    if(key == 'a') {
        playerAccel(140); 
        player.deltaBurn(3);
    } 
    player.keyPressed();
  }

  void keyReleased() {
    if(key == 'd') {
       playerAccel(0); 
       player.deltaBurn(0);
    }
    if(key == 'a') {
       playerAccel(0); 
       player.deltaBurn(0);
    }
    player.keyReleased();
  }
  
  private void playerAccel(float deltaSpeed) {
    for (IDeltaSpeed shifter : speedShifters) {
      shifter.addSpeed(deltaSpeed);  
    }
  }

  
  boolean collisionDetection(float[] coordsA, float[] coordsB) {
    boolean interval1 = ( coordsA[0] + coordsA[2] ) > ( coordsB[0] );
    boolean interval2 = ( coordsA[1] + coordsA[3] ) > ( coordsB[1] );
    boolean interval3 = ( coordsA[0] ) < (coordsB[0] + coordsB[2] );
    boolean interval4 = ( coordsA[1] ) < (coordsB[1] + coordsB[3] );
    
    if(interval1 && interval2 && interval3 && interval4) {
      print("collision");
      return true;
    }
    return false;
  }
  
  void checkCollisions() {
    for(int i = 0; i < objects.size(); i++) {
       for(int j = i + 1; j < objects.size(); j++) {
         GameObject objA = objects.get(i);
         GameObject objB = objects.get(j);
         float[] coordsA = objA.getColliderCoords();
         float[] coordsB = objB.getColliderCoords();
         if(collisionDetection(coordsA, coordsB)) {
           if(playState == 1) {
              collisionAction(objA, objB);
           }
         }
       }
    }
  }
  
  void collisionAction(GameObject objA, GameObject objB) {
    setEffect(objA, objB);
    setEffect(objB, objA);
  }
  
  void setEffect(GameObject obj, GameObject objOther) {
    if(obj instanceof IEffect) {
      IEffect efObj = (IEffect) obj;
      efObj.playerEffect(objOther);  
    }
  }
  
  void enemyDeploy(int gameStage) {
    switch(gameStage) {
      case 0:
        cicleTime = random(4, 6);
        break;
      case 1:
        cicleTime = random(2, 4);
        break;
      case 2:
        cicleTime = random(2, 3);
        createEnemy();
        break;
      case 3:
        playState = 3;
        break;
    } 
  }
  
  void gameTick(int playState, float elapsedTime) {
    if(playState == 1) {
      
      gameTime -= elapsedTime;  
      tInstanceEnemy += elapsedTime;
      tInstancePuP += elapsedTime;
      
      if(tInstanceEnemy > cicleTime) { //<>//
        tInstanceEnemy = 0;
        enemyDeploy(gameStage);
        createEnemy();
      }
      
      if(tInstancePuP > PuPTime) {
        tInstancePuP = 0;
        PuPTime = random(6, 12);
        pupType = (int)(random(1,7));
        createPuP(pupType);
      }
    }
  }
  
  void initializeGame() {
    objects.remove(player);
    player = createPlayer();
    tInstanceEnemy = 0;
    cicleTime = random(4,6);
    tInstancePuP = 0;
    PuPTime = random(8, 12);
    gameTime = 120;
    score = 0;
    gameStage = 0;
  }
  
}
