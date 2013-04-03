/**   
Generate a Victory Boogie Woogie (Mondriaan) inspired graphic.
Click on the image to generate a new graphic. This may take some time to complete.
By: Eugene Tjoa
eugene@tjoadesign.nl
**/

import processing.pdf.*;

int     grid = 12;
boolean doGenerate = true;
boolean javascriptRunnning;

void setup() {
  /* If you want to use the Javascript version: 
     - set javascriptRunning = true
     - uncomment the line 'Processing.logger = console;'
  */
  javascriptRunnning = false;
 // Processing.logger = console;
 
  size(700, 700); 
  initColors();
}

void draw() {
  if (doGenerate) {
      doGenerate = false;
      startRecording();
      background(#ffffff);
      stroke(#cccccc, 100);
      strokeWeight(1);
    
      /* Generate horizontal tiles */
      generateTiles();
       
      stopRecording();
  } 
}

/* Generate the start tiles. */
void generateTiles() {
  int rowY = 0;
  boolean isTrack = false;
  int tileHeight = 0;
  
  Inset left = new Inset("left");
  Inset right = new Inset("right");
 
  /* Create rows until we have filled the screen from top to bottom. */
  while (rowY < height) {
    tileHeight = isTrack ? round(random(1, 1.5) * grid) : round(random(4, 10) * grid);
    /* Prevent a track very close to the bottom of the screen. */
    if (rowY + tileHeight + 1.5 * grid > height) {
       tileHeight = max(height - rowY, 5 * grid); 
    }
    if (left.count == 0) {
      left.draw(0, rowY);
      left.init();
    }
    
    if (right.count == 0) {
      right.draw(width-right.w, rowY);
      right.init();
    }
    
    drawTile(left.w, rowY, width-right.w-left.w, tileHeight);

    // Alternate tracks with 'normal' tiles.
    isTrack = !isTrack;
    rowY += tileHeight;
    
    left.count--;
    left.h += tileHeight;
    
    right.count--;
    right.h += tileHeight;
  }
  left.draw(0, rowY);
  right.draw(width-right.w, rowY);
}


void mousePressed() {
  doGenerate = true; 
}


