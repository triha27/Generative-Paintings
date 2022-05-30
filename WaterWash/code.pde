import processing.pdf.*;

PImage img;
int cellSize = 15;
int cols, rows;
void setup() {
  frameRate(15);
  // enter the dimensions of the image
  size(676,507);
  // put in the name of the image 
  img = loadImage("selfie71.jpg");
   cols = width / cellSize;
  rows = height / cellSize;
   beginRecord(PDF,"Sneha-####.pdf");
  
}

void draw() {
  img.loadPixels();
  System.out.println("cols"+cols);
  System.out.println("rows"+rows);
  int temp = 150;
  noLoop();
  int[][] opacities = new int[cols][rows];
  for(int i  = 0; i < cols; i++)
  {
   //temp = temp+10;
    for(int j = 0; j < rows; j++)
    {
      opacities[i][j] = temp;
    }
  }
  //image(img, 0, 0);
   for (int i = 0; i < cols;i++) {
      // Begin loop for rows
      for (int j = 0; j < rows;j++) {
      // loop for columns
        int x = i * cellSize;
        int y = j * cellSize;
        int loc = (img.width - x - 1) + y*img.width; // Reversing x to mirror the image
         float r = red(img.pixels[loc]);
        float g = green(img.pixels[loc]);
        float b = blue(img.pixels[loc]);
        // Make a new color with an alpha component
        color c = color(r, g, b, opacities[i][j]);
        // Each rect is colored white with a size determined by brightness
        //color c = img.pixels[loc];
         pushMatrix();
        translate(x+cellSize/2, y+cellSize/2);
        // Rotation formula based on brightness
        rotate(random(2 * PI * brightness(c) / 255.0));
        rectMode(CENTER);
        fill(c);
        //noStroke();
       
        strokeWeight(3);
        stroke(c);
     ArrayList<PVector> base, variation;

  base = create_base_poly(0, 0, cellSize, 5);
  variation = deform(base, 4, random(10), 2);
    beginShape();
        for (int k = 0; k < variation.size(); k++)
    vertex(variation.get(k).x, variation.get(k).y);
        endShape(CLOSE);
       
        popMatrix();
       
   }
}
 endRecord();

}
ArrayList<PVector> rpoly(float x, float y, float r, int nsides) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  float sx, sy;
  float angle = TWO_PI / nsides;

  /* Iterate over edges in a pairwise fashion. */
  for (float a = 0; a < TWO_PI; a += angle) {
    sx = x + cos(a) * r;
    sy = y + sin(a) * r;
    points.add(new PVector(sx, sy));
  }
  return points;
}
ArrayList<PVector> deform(ArrayList<PVector> points, int depth,
                            float variance, float vdiv) {

  float sx1, sy1, sx2 = 0, sy2 = 0;
  ArrayList<PVector> new_points = new ArrayList<PVector>();

  if (points.size() == 0)
    return new_points;

  /* Iterate over existing edges in a pairwise fashion. */
  for (int i = 0; i < points.size(); i++) {
    sx1 = points.get(i).x;
    sy1 = points.get(i).y;
    sx2 = points.get((i + 1) % points.size()).x;
    sy2 = points.get((i + 1) % points.size()).y;

    new_points.add(new PVector(sx1, sy1));
    subdivide(new_points, sx1, sy1, sx2, sy2,
                depth, variance, vdiv);
  }

  return new_points;
}
void subdivide(ArrayList<PVector> new_points,
                 float x1, float y1, float x2, float y2,
                 int depth, float variance, float vdiv) {
  float midx, midy;
  float nx, ny;

  if (depth >= 0) {
    /* Find the midpoint of the two points comprising the edge */
    midx = (x1 + x2) / 2;
    midy = (y1 + y2) / 2;

    /* Move the midpoint by a Gaussian variance */
    nx = midx + randomGaussian() * variance;
    ny = midy + randomGaussian() * variance;

    /* Add two new edges which are recursively subdivided */
    subdivide(new_points, x1, y1, nx, ny,
                depth - 1, variance/vdiv, vdiv);
    new_points.add(new PVector(nx, ny));
    subdivide(new_points, nx, ny, x2, y2,
                depth - 1, variance/vdiv, vdiv);
  }
}
ArrayList<PVector> create_base_poly(float x, float y,
                                      float r, int nsides) {
  ArrayList<PVector> bp;
  bp = rpoly(x, y, r, nsides);
  bp = deform(bp, 5, r/10, 2);
  return bp;
}
