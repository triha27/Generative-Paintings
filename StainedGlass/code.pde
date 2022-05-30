import processing.pdf.*;

//import processing.video.*;
PImage img;
int cellSize = 15;
int cols, rows;
void setup() {
  frameRate(15);
  //change filesize
  size(750,563);
  // change to your file name
  img = loadImage("selfie7.jpg");
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

        // Where are we, pixel-wise?
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
        fill(c,2555);
        stroke(0,0,0,200);
       
    
 beginShape();
 vertex(0,0);
bezierVertex( random(cellSize+50),random(cellSize+50), random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50));
bezierVertex( random(cellSize+50),random(cellSize+50), random(cellSize+50),random(cellSize+50), random(cellSize+50), random(cellSize+50));
bezierVertex( random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50));  
bezierVertex( random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50),random(cellSize+50) );  
endShape();
rotate(PI/10);
         popMatrix();

 
   }
}
endRecord();

}
