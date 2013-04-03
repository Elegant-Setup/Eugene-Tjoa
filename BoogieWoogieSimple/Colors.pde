/* This class generates random colors according
   to a simple configurable distribution.
*/
class ColorRandomizer {
  Integer previousColor;
  ArrayList<Integer> colors;
  
  ColorRandomizer() {
     this.colors = new ArrayList<Integer>();
     this.previousColor = 0;
  }
  
  ColorRandomizer addColor(Integer code, String frequency) {
    for (int i=0; i < frequency.length(); i++) {
       this.colors.add(code);
    }  
    return this;
  }
  
  color getRandomColor() {
    int i = floor(random(colors.size()));
    Integer newColor = colors.get(i);
    /* Don't return the same color in two subsequent calls. 
       This doesn't prevent that adjacent tiles have the same color, but
       it reduces the number of occurences. */
    while (newColor == this.previousColor) {
      i = floor(random(colors.size()));
      newColor = colors.get(i);
    }
    previousColor = newColor;
    return newColor;
  }
}

/* Create a dedicated color randomizer for large, medium and small tiles. */
ColorRandomizer c_large, c_medium, c_small;

/* Map tile dimensions to a color palette. */
color getRandomColor(float w, float h) {
   float area = w * h;
   
   ColorRandomizer bwg;
   
   if (area > grid * 7 * grid * 7) {
     bwg = c_large;
   } else if (area > grid * 2 * grid * 2) {
      bwg = c_medium;
   } else { 
      bwg = c_small;
   }
 
   return(bwg.getRandomColor()); 
}

void initColors() {
  /* Define the color palette and distribution for large tiles. */
  c_large = new ColorRandomizer();
  c_large.addColor(#F4ECE1, "**")         // light grey
         .addColor(#D5DABD, "**")         // grey
         .addColor(#AEB49D, "*")          // dark grey
         .addColor(#E0CB00, "*")          // yellow
         .addColor(#C6A400, "*")          // light brown
         .addColor(#B71603, "*")          // red
         .addColor(#1F0CBA, "*");         // blue
 
  /* Define the color palette and distribution for medium sized tiles. */  
  c_medium = new ColorRandomizer();
  c_medium.addColor(#F4ECE1, "********")  // light grey
          .addColor(#D5DABD, "**")        // grey
          .addColor(#AEB49D, "******")    // dark grey
          .addColor(#E0CB00, "****")      // yellow
          .addColor(#C6A400, "**")        // light brown
          .addColor(#B71603, "**")        // red
          .addColor(#1F0CBA, "**");       // blue
  
  /* Define the color palette and distribution for small tiles. */  
  c_small = new ColorRandomizer();
  c_small.addColor(#AEB49D, "*")          // dark grey
         .addColor(#E0CB00, "*")          // yellow
         .addColor(#C6A400, "**")         // light brown
         .addColor(#A00707, "**")         // dark red
         .addColor(#1F0CBA, "*")          // blue
         .addColor(#090918, "****");      // black
}


                  
            

