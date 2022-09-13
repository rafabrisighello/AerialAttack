class HUD extends GameObject {
  
  private int score, armor, ammo, bombs;
  private float gas, time;
  
  private String gasDisplay;
  private String timeDisplay;
  private String scoreDisplay;
  private String armorDisplay;
  private String ammoDisplay;
  private String bombsDisplay;
  private String welcomeText = "Welcome to Aerial attack!!!";
  private String commandsText = "Press W to CLIMB, S to DIVE, A to ACCEL, D to DECEL, Space for GUN, Ctrl for releasing BOMB, Left Mouse for CANNON (backside)";
  private String gasText = "Beware, don't let your gas run out! Collect gas tanks along the way!";
  private String startText = "Press P to play!";
  private String gameOverText = "Game Over!!! To try again press P";
  private String congratText = "Congratulations!!! You survived the aerial attack! To try again press P!";
  
  HUD(Transform transform) {
    super(transform);
  }
  
  void update(float elapsedTime) {
    time = lvl.gameTime;
    gas = lvl.player.gas;
    score = lvl.score;
    armor = lvl.player.armor;
    ammo = lvl.player.ammo;
    bombs = lvl.player.bombs;
    timeDisplay = String.format("Time: %s", df.format(time));
    gasDisplay = String.format("Gas: %s", df.format(gas));
    scoreDisplay = String.format("Score: %s", score);
    armorDisplay = String.format("Armor: %s", armor);
    ammoDisplay = String.format("Ammo: %s", ammo);
    bombsDisplay = String.format("Bombs: %s", bombs);
    super.update(elapsedTime);
  }
  
  void render() {
    switch(lvl.playState) {
      case 0:
        printWelcome();
        break;
      case 1:
        textFont(f, 24);
        fill(0, 0, 0);
        text(timeDisplay, 40, 50);
        text(armorDisplay, 220, 50);
        if(gas < 100) {
          fill(255,0,0);
        }
        text(gasDisplay, 360, 50);
        fill(0, 0, 0);
        text(ammoDisplay, 560, 50);
        text(bombsDisplay, 720, 50);
        text(scoreDisplay, 900, 50);
        break;
      case 2:
        printGameOver();
        break;
      case 3:
        printCongrats();
        break;
    }
  }
  
  void printWelcome() {
    textFont(f, 32);
    fill(0,0,0);
    text(welcomeText, 10, 50);
    textFont(f, 17);
    text(commandsText, 10, 100);
    text(gasText, 10, 150);
    textFont(f, 32);
    text(startText, 450, 300);
  }
  
  void printGameOver() {
    textFont(f, 32);
    fill(255,0,0);
    text(gameOverText, 350, 300);
  }
  
  void printCongrats() {
     textFont(f, 32);
     fill(0, 0, 0);
     text(congratText, 20, 300);
     text(scoreDisplay, 400, 400);
  }
  
}
