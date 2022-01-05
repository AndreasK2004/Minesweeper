
int rows = 20;
int cols = 20;
int revealed = 0;
int nbombs = 0, nflags = 0;
float chance = 0.15;

boolean gameover = false;

PFont font;

Cell[][] grid;

void setup() {
  size(400, 500);

  font = createFont("agencyfb-bold.ttf", 32);
  textFont(font);
  textAlign(CENTER, CENTER);

  reset();
}


void draw() {
  if (!gameover) {
    background(100);

    textSize(34);
    fill(0);
    text("Bombs: " + nbombs, 80, 420);
    text("Flags: " + nflags, 80, 450);

    revealEmptyCells();

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j].show();
      }
    }
    if (gameWon()) {
      textSize(34);
      fill(0);
      text("You Won", width /2, height /2);
    }
  } else {

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j].reveal();
        grid[i][j].show();
      }
    }

    textSize(34);
    fill(0);
    text("Gameover", width /2, height /2);
  }
}

boolean gameWon() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (!grid[i][j].isbomb) {
        if (!grid[i][j].revealed) {
          return false; 
        }
      }
    }
  }
  
  return true;
}

void revealEmptyCells() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (!grid[i][j].isbomb && grid[i][j].revealed && grid[i][j].nearbombs == 0) {
        if (i < rows-1) {
          grid[i+1][j].reveal();
        }
        if (i > 0) {
          grid[i-1][j].reveal();
        }
        if (j < cols-1) {
          grid[i][j+1].reveal();
        }
        if (j > 0) {
          grid[i][j-1].reveal();
        }
        if (i < rows-1 && j < cols-1) {
          grid[i+1][j+1].reveal();
        }
        if (i > 0 && j > 0 ) {
          grid[i-1][j-1].reveal();
        }
        if (i < rows-1 && j > 0) {
          grid[i+1][j-1].reveal();
        }
        if (i > 0 && j < cols-1) {
          grid[i-1][j+1].reveal();
        }
      }
    }
  }
}

void reset() {


  revealed = 0;
  nbombs = 0;

  grid = new Cell[rows][cols];

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (random(1) < chance ) {
        grid[i][j] = new Cell(i, j, true);
        nbombs++;
      } else {
        grid[i][j] = new Cell(i, j, false);
      }
    }
  }

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int bombs = 0;
      if (i < rows-1 && grid[i+1][j].isbomb) {
        bombs++;
      }
      if (i > 0 && grid[i-1][j].isbomb) {
        bombs++;
      }
      if (j < cols-1 && grid[i][j+1].isbomb) {
        bombs++;
      }
      if (j > 0 && grid[i][j-1].isbomb) {
        bombs++;
      }
      if (i < rows-1 && j < cols-1 && grid[i+1][j+1].isbomb) {
        bombs++;
      }
      if (i > 0 && j > 0 && grid[i-1][j-1].isbomb) {
        bombs++;
      }
      if (i < rows-1 && j > 0 && grid[i+1][j-1].isbomb) {
        bombs++;
      }
      if (i > 0 && j < cols-1 && grid[i-1][j+1].isbomb) {
        bombs++;
      }

      grid[i][j].setNearBombs(bombs);
    }
  }

  int temp1 = int(random(rows)), temp2 = int(random(cols));

  while (grid[temp1][temp2].isbomb || grid[temp1][temp2].nearbombs != 0) {
    temp1 = int(random(rows));
    temp2 = int(random(cols));
  }

  grid[temp1][temp2].reveal();
}

void mousePressed() {

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j].collide(mouseX, mouseY)) {

        if (!grid[i][j].revealed) {
          if (mouseButton == LEFT) {
            grid[i][j].reveal();
            if (grid[i][j].flaged) {
               grid[i][j].flag();
               nflags--;
            }
          } else {
            if (grid[i][j].flaged) {
              grid[i][j].flag();
              nflags--;
            } else {
              grid[i][j].flag();
              nflags++;
            }
          }
        }
        break;
      }
    }
  }
}
