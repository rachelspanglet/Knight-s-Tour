class Knight {
  //FIELDS
  PVector pos = new PVector(0, 0);  //current position of knight (initially (0,0))
  PVector startingPos = new PVector(0, 0);  //starting position to help with reset
  PImage img;  //knight image
  Board board;  //board that knight belongs to
  ArrayList<PVector> availableMoves = new ArrayList<PVector>();  //moves available from current position
  ArrayList<PVector> pathSequence = new ArrayList<PVector>();    //list of moves taken to get to current position
  int animPlace = 0;  //what index in the path sequence is being animated
  
  //CONSTRUCTOR
  Knight(Board b, int l, int w) {
    this.board = b; 
    this.pos.x = l;    //set position
    this.pos.y = w;
    this.startingPos.x = l;  //set starting point to current position
    this.startingPos.y = w;
    this.pathSequence.add(this.startingPos);  //add first square to path sequence
    this.board.squares[l][w].visited = true;  //and set it to visited
    b.knight = this;
    this.img = loadImage("Chess-Knight.png");
    this.img.resize(int(this.board.squareSize), 0);
  }
  
  //METHODS
  void drawKnight() {
    image(this.img, this.pos.x*this.board.squareSize + padding, this.pos.y*this.board.squareSize);
  }
  
  void move() {  //procedure to move the knight to the next square
    try {  //try/catch for when animPlace gets to be the number of squares on the board
      this.pos = this.pathSequence.get(this.animPlace);  //current position is now the next point in path sequence
      this.board.squares[int(this.pathSequence.get(this.animPlace).x)][int(this.pathSequence.get(this.animPlace).y)].col = color(255, 0, 0);  //update colour of square
      this.animPlace++;
    }
    
    catch (IndexOutOfBoundsException e) {
      noLoop();  //stop looping once animPlace reaches number of squares on board
    }
  }
  
  ArrayList<PVector> possibleMoves() {  //function that generates possible moves from current position
    ArrayList<PVector> movesList = new ArrayList<PVector>();
    
    //knight moves consist of (1, 2); (1, -2); (-1, 2), (-1, -2); (2, 1); (2, -1); (-2, 1); (-2, -1)
    for (int i = -2; i <= 2; i++) {
      for (int j = -2; j <= 2; j++) {
        if (abs(i) != abs(j) && i != 0 && j != 0) {
          try {
            if (!this.board.squares[int(this.pos.x) + i][int(this.pos.y) + j].visited)
              movesList.add(new PVector(i, j));
          }
          catch (IndexOutOfBoundsException e) {}  //move would take the knight off the board
        }
      }
    }
    
    return movesList;
  }
  
  int[] optimizePossibleMoves() {  //Warnsdorff's heuristic rule for Hamiltonian graphs
    int[] newOrder = new int[this.availableMoves.size()];  //array that will contain the optimized order of moves to "prioritize"
    int[] allNumMoves = new int[this.availableMoves.size()];  //how many moves possible from each legal move
    
    for (int i = 0; i < this.availableMoves.size(); i++) {  //add starting indices to newOrder (later to be swapped)
      newOrder[i] = i; 
    }
      
    for (int k = 0; k < this.availableMoves.size(); k++) {  //for every move possible from current position...
      int numMoves = 0;
      
      //check how many moves are possible from the next square if that move is taken
      for (int i = -2; i <= 2; i++) {
        for (int j = -2; j <= 2; j++) {
          if (abs(i) != abs(j) && i != 0 && j != 0) {
            try {
              if (!this.board.squares[int(this.pos.x) + int(this.availableMoves.get(k).x) + i][int(this.pos.y) + int(this.availableMoves.get(k).y) + j].visited)
                numMoves++;  //increment num possible moves from htis square
            }
            catch (IndexOutOfBoundsException e) {}  //move would take knight off the board
          }
        }
      }
      
      allNumMoves[k] = numMoves;  //add the number of moves to the array  
    } 
    
    //insertion sort (with update, since newOrder also being swapped) to apply Warnsdorff
    int arrayLen = allNumMoves.length;
    
    for (int i = 1; i <= arrayLen-1; i++) {  //for every number in the array except the first...
      int c = i;  //set current index checked to i
      
      while (c > 0 && allNumMoves[c] < allNumMoves[c-1]) {  //while haven't reached beginning of list and swap still necessary...
        //swap values in allNumMoves and newOrder
        int temp = allNumMoves[c];
        allNumMoves[c] = allNumMoves[c-1];
        allNumMoves[c-1] = temp;
        
        temp = newOrder[c];
        newOrder[c] = newOrder[c-1];
        newOrder[c-1] = temp;
        
        c--;
      }
    }

    return newOrder;
  }
}
