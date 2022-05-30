import processing.pdf.*;

import processing.video.*;
PImage img;
int cellSize = 15;
int cols, rows;
void setup() {
  frameRate(15);
  size(825,1100);
  img = loadImage("selfie4.jpeg");
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
        fill(c);
        //noStroke();
       
        strokeWeight(3);
        stroke(c);
        //triangle(random(cellSize+30),cellSize+30,cellSize+30,random(cellSize),random(cellSize),random(cellSize+30));
        // Rects are larger than the cell for some overlap
         noFill();
          ellipse(0,0,cellSize,50);
        line(0,0,cellSize,cellSize+50);
         ellipse(5,5,cellSize,50);
        line(5,5,cellSize,cellSize+50);
         ellipse(10,10,cellSize,50);
        line(10,10,cellSize,cellSize+50);
          ellipse(-5,-5,cellSize,50);
        line(-5,-5,cellSize,cellSize+50);
       ellipse(10,-10,cellSize,50);
         line(10,-10,cellSize,cellSize+50);
        
        //rect(0, 0, cellSize+6, cellSize+6);
       // bezier(0,0,cellSize*2,cellSize*3,-cellSize*2,-cellSize*3,100,100);
       
        popMatrix();
   }
}
endRecord();
}
