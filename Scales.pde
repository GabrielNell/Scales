// Global Variables
int winWidth = 1259; // set the window width and height
int winHeight = 623;

float minSize = 54.3; // set the minimum and maximum breathing sizes
float maxSize = 71.6;
float wid = minSize; // initial width & height set to the minimum size
float hgt = minSize;
float inc = 0.5; // affects rate of breathing
float shadeScale; // initializing variable for color scale
float xOff = 0; // initialize variable for color ripple offset (speed of ripples)
int rows = (int)(winHeight/minSize) + 1; // number of rows set to the window height divided by the initial size of the scale so there is one scale per row
int cols = (int)(winWidth/minSize) + 1; // see above

float r, g, b, a; // initialize color
boolean grow = true; // initial breathing (grow first)

void mouseClicked() {
  r = 256*(float)Math.random(); // randomize color on mouse click 
  g = 256*(float)Math.random();
  b = 256*(float)Math.random();
}

void setup() {
  surface.setSize(winWidth, winHeight); // window size
  r = 120; // initial color of scales
  g = 120;
  b = 120;
  a = 255;
}

void draw() {
  for (int x = 0; x < cols; x++) { 
    for (int y = 0; y < rows; y++) {
      shadeScale = (float)(Math.sin((x+xOff))); // the color of the scale is darkened or lightened smoothly depending on its x position
      oneScale(x, y); // one scale for each (x, y) coordinate
    }
  }
  xOff += inc/5; // so that ripples move
  incColor(5); // see incColor(int spd) function
  breathe(); // see breathe() function
}

void oneScale(float x, float y) { // create scales
  fill(r + x*shadeScale, g + x*shadeScale, b + x*shadeScale, a); // fill colors of scales based on x position of scale and the sin wave, so colors dissipate as they move left
  if ((x % 2) == 0) {
    y -= 0.5; // offset every other column of scales
  }
  stroke(0); // give stroke
  ellipse((int)(x * minSize), (int)(y * minSize)+hgt/2, wid, hgt); // create the scale properly centered
  rect((int)(x * minSize), (int)(y * minSize), wid + x, hgt);
  
  noStroke();
  ellipse((int)(x * minSize), (int)(y * minSize)+hgt/2, wid, hgt); // redraw ellipse to cover internal borders in the scale
}

void breathe() {
  if (grow) {     // grow phase
      wid += inc;
    } else {        // shrink phase
      wid -= inc;
    }
    
  if (wid >= maxSize||wid <= minSize) {   // toggle phases
    grow = !grow;
  }
}

void incColor(int spd) { // function to change the color by random amount positive or negative
  r += spd*(Math.random()-0.5);
  g += spd*(Math.random()-0.5);
  b += spd*(Math.random()-0.5);
}
