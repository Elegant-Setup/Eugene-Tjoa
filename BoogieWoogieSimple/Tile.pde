/* Recursive function. A tile can either: 
  - be chopped into smaller tiles
  - get punched with a smaller tile in the middle
  - be displayed as a colored tile without any further modification. */
void drawTile(float x, float y, float w, float h) {
   if (x < 0 || y < 0 || w <= 0 || h <= 0) return;

     if (doChop(x, y, w, h)) {
       chop(x, y, w, h);
     } else {
        color tileColor = getRandomColor(w, h); 
        fill(tileColor);
        rect(x, y, w, h);
        // Define minimal size and chance for punching. 
        if ((min(w, h) > grid *3) && random(100) < 12) {
          punch(x, y, w, h);
        } 
     }
} 
  
/* Determine when a tile has to be chopped into smaller pieces. */
boolean doChop(float x, float y, float w, float h) {
  float   ratio = w/h;
  
  // Is the tile large enough to be chopped?
  boolean isLargeEnough = (max(w, h) > grid * 5);
   // Is the tile too large to be displayed unchopped?
  boolean isTooLarge = max(w, h) > (10 * grid);     
  // If the tile is not 'square enough', it has to be chopped.
  boolean isNotSquare = (ratio < 0.6 || ratio > 1.7) && (min(w, h) >= 1.6 * grid);
  // A track is a long and narrow tile 
  boolean isTrack = (ratio < 0.3 || ratio > 3) && (min(w, h) <= round(1.3 * grid));         

  return (isLargeEnough && (random(100) < 8)) || isTooLarge || isNotSquare || isTrack;
}

/* Chop the tile into more tiles. */
void chop(float x, float y, float w, float h) {
  
  /* Differentiate between tiles with width > height and vice versa. But the algorithm is the same. */
  if (w > h) {
    /* Define the minimal width of the slice. */
    float minWidth = min(h, w/4);
    float chopX = x;
    float maxX = x + w;
    /* Chop until we reach the right border of the tile. */
    while (chopX < maxX) { 

      /* Tracks have a different width:height ratio from the other tiles.    */
       int chopSize = h < (1.6 * grid) && w > width / 2 ?  round(random(0.8, 1.3) * grid) : round(random(1, 2) * minWidth);
    
       /* Make sure that we:
         - don't cross the bounding box
         - are not left with a small slice at the tail
       */
       if ((chopX + chopSize + minWidth) > maxX) {
         /* Eat up all remaining space. */
          chopSize = round(maxX - chopX); 
       }
       drawTile(chopX, y, chopSize, h);
       chopX += chopSize;
    }

  } else {
    /* Define the minimal height of the slice. */
    float minHeight = min(w, h/4);
    /* Chop a vertical tile */
    float chopY = y;
    float maxY = y + h;
    /* Chop until we reach the bottom border of the tile. */
    while (chopY < maxY) { 
     
       /* Tracks have a different width:height ratio from the other tiles. */
       int chopSize = w < (2 * grid) ?  round(random(0.8, 1) * minHeight) : round(random(1, 2) * minHeight);
      
      /* Make sure that we:
         - don't cross the bounding box
         - are not left with a small slice at the tail
       */
       if ((chopY + chopSize + minHeight) > maxY) {
          chopSize = round(maxY - chopY); 
       }
       drawTile(x, chopY, w, chopSize);
       chopY += chopSize;
    }
  }
}
  
 /* Punch a hole */
 void punch(float x, float y, float w, float h) {
   float holeWidth = w / random(1.5, 4);
   float holeHeight = h / random(1.5, 4);
   float holeX = x + (w - holeWidth) / 2;
   float holeY = y + (h - holeHeight) / 2;
   drawTile(round(holeX), round(holeY), round(holeWidth), round(holeHeight));
 }
