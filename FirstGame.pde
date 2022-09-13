import java.util.Iterator;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.Random;
import java.text.DecimalFormat;

float startTime;
float elapsedTime;
Level lvl;
int wid = 1080;
int hei = 720;
PVector xVersor = new PVector(1,0);
PVector yVersor = new PVector(0,1);
Random random = new Random(System.currentTimeMillis());
PFont f;
static final DecimalFormat df = new DecimalFormat("0.0");

void setup() {
   size(1080, 720);
   startTime = millis();
   lvl = new Level(1);
   f = createFont("Arial", 16, true);
}

void draw() {
  elapsedTime = (millis() - startTime) / 1000.0f;
  startTime = millis();
  clear(); 
  background(0, 200, 255);
  lvl.update(elapsedTime);
}

void mousePressed() {
  lvl.mouseEvent();
}

void keyPressed() {
  lvl.keyPressed();
}

void keyReleased() {
  lvl.keyReleased();
}

PVector getRelPos(PVector posA, PVector posB) {
   return PVector.sub(posA, posB);
}

boolean detectAngle(PVector relPos, PVector orient, float deltaAngle) {
   
   float prodScalar = orient.dot(relPos);
   float cos = prodScalar / (orient.mag() * relPos.mag());
   float angle = acos(cos);  
   
   boolean angleCond = angle <= deltaAngle; 
   
   return angleCond;
}

void drawPlane(float w, float h) {
  fill(0, 128, 128);
  circle(w/4, - h / 10, w/4);
  fill(255, 220, 0);
  rect(0, 0, w, h);
  rect(4 * w / 5, - h, w / 5, h);
  fill(127, 0, 127);
  rect(w / 2, h/4, w / 4, h / 3);    
}

void drawEnemyPlane(float w, float h) {
   fill(128, 128, 128);
   circle(3*w/4, - h / 8, w/4);
   fill(255, 0, 0);
   rect(0, 0, w, h); 
   rect(0, - h, w / 5, h);
   fill(127,0,127);
   rect(w/3, h/4, w / 4, h / 2);  
}

void drawGndEnemy(float w, float h) {
   fill(127, 127, 127);
   rect(0, 0, w, h); 
   circle(w / 2, - h/6, w); 
}

void drawProjectile(float d) {
  fill(127, 127, 127);
  circle(0, 0, d);   
}

void drawProjPuP(float d) {
  fill(128, 0, 255);
  circle(0, 0, d);   
}

void drawGasPuP(float w, float h) {
  fill(127, 0, 255);
  rect(0,0, w, h);
  rect(0, - h/4, w / 4, h/4);
}
