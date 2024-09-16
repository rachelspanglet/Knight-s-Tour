class Square {
  //FIELDS
  boolean visited = false;  //not visited by default
  color col;  //colour
  float size;  //size
  PVector pos = new PVector();  //place on board
  
  //CONSTRUCTOR
  Square(int l, int w, boolean b, float s) {
    //set position
    this.pos.x = l;
    this.pos.y = w;
    
    //boolean b: true for black, false for white
    if (b) 
      this.col = color(0);
    else
      this.col = color(255);
    this.size = s;  //dimensions
  }
  
  //METHODS
  void drawSquare() {
    fill(this.col);
    square(this.pos.x*this.size + padding, this.pos.y*this.size, this.size); 
  }
}
