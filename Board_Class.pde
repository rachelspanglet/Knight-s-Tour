class Board {
  //FIELDS
  int boardLen;  //horizontal dimension of board
  int boardWid;  //vertical dimension of board
  float squareSize;  //size of each square on the board
  Square[][] squares;  //array of all square objects belonging to board
  Knight knight = null;  //null knight until it's created
  color[][] originalColours;
  
  //CONSTRUCTOR
  Board(int l, int w) {
    this.boardLen = l;  //set board
    this.boardWid = w;  //dimensions
    this.squareSize = width/this.boardWid;  //calculate square size based on board's width
    this.addSquares();  //fill this.squares array
  }
  
  //METHODS
  void addSquares() {  //reset squares on board to the right colours and appropriate vistited boolean
    this.squares = new Square[this.boardLen][this.boardWid];  //new array that will contain boardLen x boardWid squares
    this.originalColours = new color[this.boardLen][this.boardWid];
    boolean black = true;  //to keep track of whether currently adding a light or dark square
    boolean even;  //change assignment of colour based on whether width is even
     
    if (this.boardWid % 2 == 1)  //if odd
      even = false;    
    else //if even
      even = true;
    
    //fill squares array
    for (int i = 0; i < this.boardLen; i++) {  //for every column...
      if (even) 
        black = !black;  //flip colour
        
      for (int j = 0; j < this.boardWid; j++) {  //for every row...
        Square sq = new Square(i, j, black, this.squareSize);  //create square at position i, j
        this.squares[i][j] = sq;  //add sq to array
        if (black)
          this.originalColours[i][j] = color(0);
        else
          this.originalColours[i][j] = color(255);
        black = !black;  //flip colour of next square
      }
    }      
  }
  
  void drawBoard() {
    for (int i = 0; i < this.boardLen; i++) {  //for every column...
      for (int j = 0; j < this.boardWid; j++) {  //for every row...
        this.squares[i][j].drawSquare();  //draw square
      }
    }
    
    this.knight.drawKnight();  //draw knight
  }
  
  boolean isCovered() {  //helper function to hamiltonPossible() to determine whether knight's tour is complete yet 
    //check every square on the board...
    for (int i = 0; i < this.boardLen; i++) {
      for (int j = 0; j < this.boardWid; j++) {
        if (!this.squares[i][j].visited)  //if the square hasn't been visited by the knight yet...
          return false;  //return false. board is not covered
      }
    }
    return true;  //return true if made through every square without any being unvisited
  }
  
  boolean hamiltonPossible() {  //determine whether knight's tour is possible
    if (this.isCovered())  //base case: if every square has been visited...
      return true;         //then the knight's tour is complete; return true.
    
    this.knight.availableMoves = this.knight.possibleMoves();  //determine feasible moves for the knight's next move
    ArrayList<PVector> moves = this.knight.possibleMoves();  //
    int[] newOrd = this.knight.optimizePossibleMoves();  //array of the order of priority for all possible moves from this pos

    for (int i : newOrd) {  //for every possible move from this position...
      this.knight.pos.add(moves.get(i));  //update the knight's position as if it makes the current move being checked
      this.knight.pathSequence.add(new PVector(this.knight.pos.x, this.knight.pos.y));  //add the new position to the full sequence of moves made to get here
      this.squares[int(this.knight.pos.x)][int(this.knight.pos.y)].visited = true;  //set the new square the knight is at to visited      
      
      if (hamiltonPossible()) {  //recursive call
        return true;
      }
      
      //if didn't return true, ie hit a dead end:
      this.knight.pathSequence.remove(this.knight.pathSequence.size() - 1);  //remove latest visited square from the path sequence
      this.squares[int(this.knight.pos.x)][int(this.knight.pos.y)].visited = false;  //set the latest visited square as unvisited
      this.knight.pos.sub(moves.get(i));  //move knight's position back to previous square in the path
    }
    
    return false;  //if made it through without ever returning true...
  } 
}
