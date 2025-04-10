int x = 200;
int y = 200;
int size = 20;
int dx = size;
int dy = 0;

int appleX, appleY;
boolean appleEaten = true;

void setup() {
  size(400, 400);
  frameRate(10);
}

void draw() {
  background(0);

  // Flyt slangen
  x += dx;
  y += dy;

  // Hvis slangen går udenfor skærmen
  if (x < 0 || x >= width || y < 0 || y >= height) {
    noLoop(); // Stop spillet
    fill(255, 0, 0);
    textSize(32);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2);
    return;
  }

  // Tegn slangen
  fill(0, 255, 0);
  rect(x, y, size, size);

  // Tegn æblet
  if (appleEaten) {
    appleX = int(random(width / size)) * size;
    appleY = int(random(height / size)) * size;
    appleEaten = false;
  }
  fill(255, 0, 0);
  rect(appleX, appleY, size, size);

  // Tjek om slangen spiser æblet
  if (x == appleX && y == appleY) {
    appleEaten = true;
  }
}

void keyPressed() {
  if (keyCode == UP && dy == 0) {
    dx = 0;
    dy = -size;
  } else if (keyCode == DOWN && dy == 0) {
    dx = 0;
    dy = size;
  } else if (keyCode == LEFT && dx == 0) {
    dx = -size;
    dy = 0;
  } else if (keyCode == RIGHT && dx == 0) {
    dx = size;
    dy = 0;
  }
}
