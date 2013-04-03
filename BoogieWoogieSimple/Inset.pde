class Inset {
   public int count;
   public int w;
   public int h; 
   public String type;
   
   Inset(String type) {
     this.type = type;
     this.count = 0;
     this.w = 0;
     this.h = 0;
   }
   
   void init() {
      this.h = 0;
      this.count = round(random(3,4));
      this.w = round(random(4, 15) * grid); 
   }
   
   void draw(int x, int bottomY) {
     /* A wide inset has a chance to have a vertical track on the border facing the center. */   
     if ((this.h > 12 * grid) && random(100) < 50) {

       int trackWidth = round(random(1, 1.3) * grid);
       int trackX;
       int tileX;
       
       if (this.type == "left") {
         // Place the track on the right side of the tile.
          trackX = x + this.w - trackWidth;
       } else {
         // Place the track on the left side of the tile.
          trackX = x;
          x = x + trackWidth;         
       }
       
       // Track
       drawTile(trackX, bottomY-this.h, trackWidth, this.h);
       this.w -= trackWidth;
     }  
     
     // A wide inset is split into two vertical tiles.
     if (this.w > 7 * grid) {       
         int subWidth = round(random(3 * grid, this.w - 3 * grid));
         drawTile(x, bottomY-this.h, subWidth, this.h);
         drawTile(x + subWidth, bottomY-this.h, this.w-subWidth, this.h);
     } else {
         drawTile(x, bottomY-this.h, this.w, this.h);
     }
   }
}
