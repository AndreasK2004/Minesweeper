class Cell {
  boolean isbomb;
  boolean revealed = false;
  boolean flaged = false;
  PVector pos;
  float w = 20;
  int nearbombs;

  Cell(int x, int y, boolean bomb) {
    pos = new PVector(x*20, y*20);
    isbomb = bomb;
  }

  void show() {
    if (revealed) {
      if (isbomb) {
        stroke(0);
        fill(255, 0, 0);
        rect(pos.x, pos.y, w, w);
        gameover = true;
      } else {

        stroke(0);
        fill(248, 248, 248);
        rect(pos.x, pos.y, w, w);
        textSize(14);

        switch (nearbombs) {
        case 1:
          fill(0);
          break;
        case 2:
          fill(88, 199, 80);
          break;
        case 3:
          fill(199, 88, 80);
          break;
        case 4:
          fill(88, 80, 199);
          break;
        case 5:
          fill(255, 94, 0);
          break;
        case 6:
          fill(64, 0, 255);
          break;
        case 7:
          fill(255, 0, 0);
          break;
        case 8:
          fill(255, 0, 0);
          break;
        }

        noStroke();
        text(nearbombs, pos.x + w/2, pos.y + w/2);
      }
    } else if (flaged) {
      stroke(0);
      fill(255, 153, 0);
      rect(pos.x, pos.y, w, w);
    } else {
      stroke(0);
      fill(148, 148, 148);
      rect(pos.x, pos.y, w, w);
    }
  }

  void reveal() {
    revealed = true;
  }

  void setNearBombs(int n) {
    nearbombs = n;
  }

  void flag() {
    flaged = !flaged;
  }



  boolean collide(float x, float y) {
    if (x > pos.x && x < pos.x+w && y > pos.y && y < pos.y+w) {
      return true;
    }
    return false;
  }
}
