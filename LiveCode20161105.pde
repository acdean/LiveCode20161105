import peasy.*;

PeasyCam cam;

float MAJ_RAD = 400;
float MIN_RAD = 50;
float SZ = 30;
int COUNT = 120; // divisible by 5
PShape shape;
float rx, ry, rz, dx, dy, dz;
boolean video;

void setup() {
  size(640, 360, P3D);
  cam = new PeasyCam(this, MAJ_RAD * 2.5);
  rx = random(TWO_PI);
  ry = random(TWO_PI);
  rz = random(TWO_PI);
  dx = random(-.05, .05);
  dy = random(-.05, .05);
  dz = random(-.05, .05);
}

void draw() {
  colorMode(RGB);
  background(0);
  lights();
  pushStyle();
  rotateX(radians(frameCount * 1.25));
  rotateY(radians(frameCount * 2.53));
  stroke(255, 0, 0);
  noFill();
  sphere(1000);
  popStyle();
  if (shape == null) {
    colorMode(HSB, COUNT, 100, 100);
    shape = createShape(GROUP);
    for (int i = 0 ; i < COUNT ; i++) {
      float angle1 = TWO_PI * i / (COUNT / 7.0); // major circle
      float angle2 = TWO_PI * i / COUNT; // twisting
      PVector p = new PVector(MAJ_RAD + MIN_RAD * cos(angle2), MIN_RAD * sin(angle2));
      rotateY(p, angle1);
      PShape child = createShape(SPHERE, SZ);
      child.translate(p.x, p.y, p.z);
      child.setFill(color(map((angle1 % TWO_PI), 0, TWO_PI, 0, COUNT), 100, 100));
      child.setStroke(Boolean.FALSE);
      shape.addChild(child);
    }
  }
  rx += dx;
  ry += dy;
  rz += dz;
  rotateX(rx);
  rotateY(ry);
  rotateZ(rz);
  shape(shape);
  
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount > 500) {
      exit();
    }
  }
}

void rotateY(PVector p, float angle) {
  float x = p.x * cos(angle) - p.z * sin(angle);
  float y = p.y;
  float z = p.x * sin(angle) + p.z * cos(angle);
  p.set(x, y, z);
}

void keyPressed() {
  if (key == 's') {
    saveFrame("snapshot####.png");
  }
}