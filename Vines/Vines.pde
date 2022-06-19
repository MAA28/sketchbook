int n = 5;
int m = 5;

void setup() {


  size(1024, 1024);
}
void draw() {
  frameRate(5);
  int sW = 15;
  background(0);

  float[][] offsets = new float[n][m + 2];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < offsets[i].length; j++) {
      offsets[i][j] = random(-.5 * width / (float) n, .5 * width / (float) n);
    }
  }


  PGraphics mask = createGraphics(width, height);

  mask.beginDraw();
  mask.background(0);

  mask.strokeWeight(sW);
  mask.stroke(255);
  mask.noFill();
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m + 1; j++) {
      float x1 = (i + .5) / (float) n * width + offsets[i][j];
      float y1 = (j - .5) / (float) m * height;

      float x2 = (i + .5) / (float) n * width + offsets[i][j + 1];
      float y2 = (j + .5) / (float) m * height;

      float smooth = .5 * height / (float) m;

      mask.bezier(x1, y1, x1, y1 + smooth, x2, y2 - smooth, x2, y2);
    }
  }
  mask.endDraw();

  colorMode(HSB);

  PImage grad = createImage(width, height, RGB);
  float h1 = random(255);
  float h2 = h1 - 50;

  for (int i = 0; i < grad.pixels.length; i++) {
    float h = map(i / width, 0, height, h1, h2);
    grad.pixels[i] = color(h, 255, 255);
  }
  grad.mask(mask);

  image(grad, 0, 0);

  colorMode(RGB);
  stroke(255, 125);
  strokeWeight(sW);
  for (int j = 0; j < m; j++) {
    float y = (j + .5) / (float) m * height;

    line(0, y, width, y);
  }
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m + 1; j++) {
      float x = (i + .5) / (float) n * width + offsets[i][j];
      float y = (j - .5) / (float) m * height;
      point(x, y);
    }
  }
  saveFrame("Vines##.png");
}
