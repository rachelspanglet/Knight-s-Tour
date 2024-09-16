import g4p_controls.*;  //import gui

Board board;        //create board object
Knight knight;      //create knight object
int startingX = 0;  //set starting position in top left corner of
int startingY = 0;    //board by default
float padding;      //if not square, pad one side with empty space
boolean playerMode = false;
boolean tourPossible;

void setup() {
  size(600, 600);
  createGUI();
  board = new Board(8, 8);  //default board 8x8
  knight = new Knight(board, startingX, startingY);  //create knight at starting position
  frameRate(2); //default, user can change
  
  setupHelper();  //extra setup procedure
}

void draw() {
  //remake background if starting again
  if (knight.animPlace == 0) {
    fill(0, 0, 255);
    rect(0, 0, 600, 600);
  }
  
  if (!playerMode) {  //if in automatic mode...
    board.drawBoard();  //draw everything 
    knight.move();  //update knight position
    
    if (!tourPossible)  //if board is impossible to solve:
      loserMessage();  //procedure for no possible tour
  }
    
  else {  //if in player mode...
    board.drawBoard();  //draw everything
    
    if (knight.possibleMoves().size() == 0)  //show message if player has hit dead end (ie 0 possible moves)
      loserMessage();  //procedure for no possible tour

  }
}
