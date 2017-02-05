/**
 * Conway's Game of Life
 * https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
 * 
 * Commands:
 * SPACE: pause and change cell's
 * R: reset
 * C: clear
 * G: Gosper Glider Gun
 */

// Number of cells
final int nx = 160;
final int ny = 100;

// Size of cells
final int cellSize = 8;

// Proability for randomInit (in %)
final float p0 = 15;

// Iteration timer (ms)
final int interval = 80;
int lastRecordedTime = 0;

int iterationCounter = 0;

// Colors
final color alive = color(0, 200, 0);
final color dead = color(0);

int[][] cells = new int[nx][ny];
int[][] cellsBuffer = new int[nx][ny]; 

boolean pause = false;
PFont font;

void settings() {
  size (nx*cellSize, ny*cellSize);
}

void setup() {
  stroke(48);
  noSmooth();
  font = createFont("Arial", 16, true);
  textFont(font, 16);
  background(0);
  //randomInit(p0);
  pattern(50, 50, gosper_glider_gun );
}

void draw() {
  // Draw grid
  for (int x=0; x<nx; x++) {
    for (int y=0; y<ny; y++) {
      if (cells[x][y]==1) {
        fill(alive);
      }
      else {
        fill(dead); // If dead
      }
      rect (x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  // Print iteration
  fill(255);
  text("" + iterationCounter,10,20);
  
  // Iterate if timer ticks
  if (millis()-lastRecordedTime > interval) {
    if (!pause) {
      iteration();
      lastRecordedTime = millis();
    }
  }

  if (pause && mousePressed) {
    MousePosition mp = mousePos();
    if (cellsBuffer[mp.x][mp.y] == 1) {
      cells[mp.x][mp.y] = 0;
      fill(dead);
    }
    else {
      cells[mp.x][mp.y]=1;
      fill(alive);
    }
  } 
  else if (pause && !mousePressed) {
    saveToBuffer();
  }
}

void keyPressed() {
  // restart
  if (key=='r' || key == 'R') {
    randomInit(p0);
  }
  // pause
  if (key==' ') {
    pause = !pause;
  }
  // clear
  if (key=='c' || key == 'C') {
    randomInit(0.0);
  }
  // glider_gun at mouse position
  if (key == 'g' || key == 'G') {
    MousePosition mp = mousePos();
    pattern(mp.x, mp.y, gosper_glider_gun);
  }
}

MousePosition mousePos() {
    int mx = int(map(mouseX, 0, width, 0, nx));
    mx = constrain(mx, 0, nx-1);
    int my = int(map(mouseY, 0, height, 0, ny));
    my = constrain(my, 0, ny-1);
    return new MousePosition(mx, my);
}

void saveToBuffer() {
  for (int x=0; x<nx; x++) {
    for (int y=0; y<ny; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }
}

void iteration() {
  iterationCounter++;
  saveToBuffer();
  for (int x=0; x<nx; x++) {
    for (int y=0; y<ny; y++) {
      cells[x][y] = rule_23_3(x,y);
    }
  }
}

int rule_23_3(int x, int y) {
  int state = 0;
  int neighbours = neighbours(x, y);
  if (cellsBuffer[x][y] == 1) { 
    state = (neighbours == 2 || neighbours == 3) ? 1 : 0;
  } 
  else {      
    state = (neighbours == 3) ? 1 : 0;
  }
  return state;
}

int neighbours(int x, int y) {
  int cnt = 0;
  for (int xx=x-1; xx<=x+1; xx++) {
    for (int yy=y-1; yy<=y+1;yy++) {  
      if (!((xx==x)&&(yy==y))) {
        if (cellsBuffer[(nx+xx)%nx][(ny+yy)%ny]==1){
          cnt++;
        }
      }
    }
  }
  return cnt;
}

void randomInit(float p) {
  iterationCounter = 0;
  for (int x=0; x<nx; x++) {
    for (int y=0; y<ny; y++) {
      if (p < random(100)) {
        cells[x][y] = 0;
      }
      else {
        cells[x][y] = 1;
      }
    }
  }
}

void pattern(int x, int y, int[][] p) {
  for (int py=0; py<p.length; py++) {
    for (int px=0; px<p[0].length; px++) {
      cells[(x+px)%nx][(y+py)%ny] = p[py][px];
    }
  }
}

final int[][] gosper_glider_gun = {
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
    {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
    {1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
};


class MousePosition {
  public final int x;
  public final int y;
  MousePosition(int x, int y) {
    this.x = x;
    this.y = y;
  }
}