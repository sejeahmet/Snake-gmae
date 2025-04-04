int gridSize = 20;
int cols, rows;
ArrayList<PVector> snake;
PVector direction;
PVector apple;
int score = 0;
boolean gameOver = false;
boolean winMessage = false;

void setup() {
  size(400, 400);
  cols = width / gridSize;
  rows = height / gridSize;
  frameRate(10);
  snake = new ArrayList<PVector>();
  snake.add(new PVector(cols / 2, rows / 2)); 
  direction = new PVector(1, 0);
  spawnApple();
}

void draw() {
  if (!gameOver) {
    background(20, 20, 30);

    // Opdater slangen
    updateSnake();
    
    // Tegn slangen
    fill(0, 255, 0);
    for (PVector segment : snake) {
      rect(segment.x * gridSize, segment.y * gridSize, gridSize, gridSize);
    }
    
    // Tegn æblet
    fill(255, 0, 0);
    rect(apple.x * gridSize, apple.y * gridSize, gridSize, gridSize);
    
    // Vis score
    fill(255);
    textSize(20);
    text("Score: " + score, 10, 20);
    
    // Hvis score er 100+, vis en besked
    if (winMessage) {
      fill(255, 255, 0);
      textSize(30);
      textAlign(CENTER);
      text("SÅDAN! Godt gået!", width / 2, height / 2);
    }
    
  } else {
    // Game over skærm
    background(200, 50, 50);
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("GAME OVER", width / 2, height / 2);
    textSize(20);
    text("Score: " + score, width / 2, height / 2 + 40);
    text("Tryk R for at starte igen", width / 2, height / 2 + 80);
  }
}

void updateSnake() {
  // Flyt hovedet i retning
  PVector newHead = new PVector(snake.get(0).x + direction.x, snake.get(0).y + direction.y);
  
  // Tjek for kollision med egen krop
  for (PVector segment : snake) {
    if (segment.equals(newHead)) {
      gameOver = true;
      return;
    }
  }
  
  // Tjek for kollision med æble
  if (newHead.equals(apple)) {
    score += 20;
    spawnApple();
  } else {
    snake.remove(snake.size() - 1); // Fjern sidste del, hvis ikke vi spiser
  }
  
  snake.add(0, newHead); // Tilføj nyt hoved
  
  // Hvis score er 100, vis "Godt gået!"
  if (score >= 100) {
    winMessage = true;
  }
}

void spawnApple() {
  apple = new PVector(int(random(cols)), int(random(rows)));
}

void keyPressed() {
  if (keyCode == UP && direction.y == 0) direction.set(0, -1);
  else if (keyCode == DOWN && direction.y == 0) direction.set(0, 1);
  else if (keyCode == LEFT && direction.x == 0) direction.set(-1, 0);
  else if (keyCode == RIGHT && direction.x == 0) direction.set(1, 0);
  else if (key == 'r' && gameOver) {
    gameOver = false;
    score = 0;
    winMessage = false;
    snake.clear();
    snake.add(new PVector(cols / 2, rows / 2));
    direction.set(1, 0);
    spawnApple();
  }
}
