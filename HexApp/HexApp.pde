
int hexSize;
int numCols;
int numRows;
HexCoord center;
boolean activeHexes[][];

void setup() {
  size(800, 800);

  hexSize = 20;
  numCols = 25;
  numRows = 25;

  center = new HexCoord(floor(numCols/2), floor(numRows/2));
  println(center.col, center.row);
  
  activeHexes = new boolean[numCols][numRows];
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      activeHexes[col][row] = false;
    }
  }
  
  redraw();
}

void draw() {
}

void clear() {
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      activeHexes[col][row] = false;
    }
  }
}

void redraw() {
  background(255);
  for (int col = 0; col < numCols; col++) {
    for (int row = 0; row < numRows; row++) {
      drawHexagon(col, row);
    }
  }
}

void drawHexagon(int col, int row) {
  float x = indexToWorldX(col, row);
  float y = indexToWorldY(col, row);

  if (activeHexes[col][row]) {
    fill(0, 128);
  } else {
    fill(255);
  }

  stroke(0);
  strokeWeight(1);
  hex(x, y, hexSize);

  fill(0);
  hexLabel(x, y, hexSize, col, row);
}

void hex(float x, float y, float side) {
  float half = side / 2;
  float h = half * tan(PI/3);

  pushMatrix();
  translate(x, y);
  beginShape();
  vertex(half, 0);
  vertex(half + side, 0);
  vertex(2 * side, h);
  vertex(half + side, 2 * h);
  vertex(half, 2 * h);
  vertex(0, h);
  vertex(half, 0);
  endShape();
  popMatrix();
}

void hexLabel(float x, float y, float side, int col, int row) {
  float half = side / 2;
  float h = half * tan(PI/3);
  textAlign(CENTER, CENTER);
  text(col + "," + row, x + side, y + h);
}

void toggleHex(int col, int row) {
  activeHexes[col][row] = !activeHexes[col][row];
}

boolean isValidHex(int col, int row) {
  return col >= 0 && col < numCols && row >= 0 && row < numRows;
}

float indexToWorldX(int c, int r) {
  return c * hexSize * 1.5;
}

float indexToWorldY(int c, int r) {
  float half = hexSize / 2;
  float h = half * tan(PI/3);
  if (c % 2 == 0) {
    return 2 * r * h;
  }
  return (2 * r + 1) * h;
}

int worldToIndexX(float x, float y) {
  return floor(x / hexSize / 1.5);
}

int worldToIndexY(float x, float y) {
  float half = hexSize / 2;
  float h = half * tan(PI/3);
  int col = worldToIndexX(x, y);
  if (col % 2 == 0) {
    return floor(y / h / 2);
  }
  return floor(y / h / 2 - 0.5);
}

void mouseReleased() {
  float centerX = indexToWorldX(center.col, center.row) - 0.5 * hexSize;
  float centerY = indexToWorldY(center.col, center.row);
  float dx = mouseX - centerX;
  float dy = mouseY - centerY;
  
  int numSides = 6;
  for (int i = 0; i < numSides; i++) {
    float a = (float) i * 2 * PI / numSides;
    float x = centerX + dx * cos(a) - dy * sin(a);
    float y = centerY + dx * sin(a) + dy * cos(a);
    
    int col = worldToIndexX(x, y);
    int row = worldToIndexY(x, y);
    if (isValidHex(col, row)) {
      toggleHex(col, row);
    }
  }
  
  redraw();
  
  stroke(255, 0, 0);
  strokeWeight(2);
  for (int i = 0; i < numSides; i++) {
    float a = (float) i * 2 * PI / numSides;
    float x = centerX + dx * cos(a) - dy * sin(a);
    float y = centerY + dx * sin(a) + dy * cos(a);
    line(centerX, centerY, x, y);
  }
}

void keyReleased() {
  switch (key) {
    case ' ':
      redraw();
      break;
    case 'r':
      clear();
      redraw();
      break;
  }
}