void setupHelper() {  //assist with setup and with restart procedure
  background(0, 0, 255);
  padding = (width-(board.squareSize * board.boardLen))/2;  //calculate necessary padding if board not square
  tourPossible = board.hamiltonPossible();  //redetermine if knight's tour is possible

  if (tourPossible) {  //if tour is possible for the current new board:
    board.addSquares();  //add squares again (set all to unvisited in case user wants to switch to player mode)
    board.squares[startingX][startingY].visited = true;  //but set starting square to visited
    board.squares[startingX][startingY].col = color(255, 0, 0);
    knight.pos = new PVector(startingX, startingY);  //put knight at starting position
  }
  
  else  //if tour isn't possible, go to procedure for no tour possible
    loserMessage();
}

void loserMessage() {  //procedure for when user hits dead end in interactive mode
  fill(0, 255, 0);
  rect(100, 200, 400, 200);
  textSize(20);
  fill(0);
  text("Impossible to complete tour!", 150, 250);
  text("Restart to try again.", 150, 300);
}
