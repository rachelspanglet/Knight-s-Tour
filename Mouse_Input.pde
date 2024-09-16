void mousePressed() {
  if (playerMode) {  //only accept mouse input if in player mode 
     //get position of mouse click
     int x = int((mouseX - padding)/board.squareSize);
     int y = int((mouseY/board.squareSize));
     //get difference between knight's current position and click; knight wil only move if one of the differences is 1, the other, 2
     int diffX = abs(int(knight.pos.x) - x);
     int diffY = abs(int(knight.pos.y) - y);
     
     if (diffX == 1 && diffY == 2 && x >= 0 && !(board.squares[x][y].col == color(255, 0, 0))) {  //if move is of (1, 2) form and square not yet visited:
       board.squares[x][y].visited = true;  //set to visited
       board.squares[x][y].col = color(255, 0, 0);
       knight.pos = new PVector(x, y);  //update knight position
       knight.pathSequence.add(new PVector(x, y));
       redraw();
     }
     
     else if (diffX == 2 && diffY == 1 && x >= 0 && !(board.squares[x][y].col == color(255, 0, 0))) {  //move is of form (2, 1)
       board.squares[x][y].visited = true;
       board.squares[x][y].col = color(255, 0, 0);
       knight.pos = new PVector(x, y);
       knight.pathSequence.add(knight.pos);
       redraw();
     }
  }
}
