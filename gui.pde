/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:202852:
  appc.background(230);
} //_CODE_:window1:202852:

public void pauseButtonClicked(GButton source, GEvent event) { //_CODE_:pauseButton:807397:
  if (pauseButton.getText().equals("Pause")) {  //if user had clicked pause...
    noLoop(); 
    pauseButton.setText("Resume");
  }
  else {  //if user has clicked resume...
    loop();
    pauseButton.setText("Pause");
  }
} //_CODE_:pauseButton:807397:

public void resetButtonClicked(GButton source, GEvent event) { //_CODE_:restartButton:283213:
  //reset all knight and board fields back to starting values
  knight.pos = new PVector(startingX, startingY);
  knight.animPlace = 0;
  knight.pathSequence.clear();
  knight.pathSequence.add(new PVector(knight.pos.x, knight.pos.y));
  board.addSquares();
  board.squares[startingX][startingY].visited = true;
  setupHelper();  //call helper setup function
  
  if (!playerMode)
    loop();
  else {  //if in player mode, redraw to show reset
    redraw();
  }
    
  
} //_CODE_:restartButton:283213:

public void animationSpeedDragged(GSlider source, GEvent event) { //_CODE_:animationSpeed:258118:
  frameRate(animationSpeed.getValueF());  //change frame rate
} //_CODE_:animationSpeed:258118:

public void programModeClicked(GButton source, GEvent event) { //_CODE_:programMode:688490:
  playerMode = !playerMode;  //swap mode
  
  if (playerMode) {  //if user has switched to player mode...
    noLoop();  //stop looping
      
    try {  //in case user has switched modes with only 2 items in pathSequence
      knight.pos = knight.pathSequence.get(knight.animPlace - 2);
    }
    
    catch (IndexOutOfBoundsException e) {
    }
    
    board.addSquares();  //reset all board squares to unvisited
    
    //but then add back already visited squares since path sequence is automatically filled to the end in !playerMode
    for (int i = knight.pathSequence.size()-1; i >= 0; i--) {
      if (i > knight.animPlace-2)  //remove all squares from path sequence except those already animated on the path
        knight.pathSequence.remove(i);
      else {  //otherwise set the corresponding square's colour and visited
        board.squares[int(knight.pathSequence.get(i).x)][int(knight.pathSequence.get(i).y)].visited = true;
        board.squares[int(knight.pathSequence.get(i).x)][int(knight.pathSequence.get(i).y)].col = color(255, 0, 0);
      }
    }
    programMode.setText("Automatic Mode");    
  }
  
  else {  //user has switched to automatic mode... 
    knight.animPlace = knight.pathSequence.size();  //make animation place wherever user has ended off
    PVector spot = new PVector(knight.pos.x, knight.pos.y);  //keep to add to pathSequence later (gets deleted in hamiltonPossible)
    int s = knight.animPlace - 1;  //same as above
    
    programMode.setText("Make Moves Mode");
    tourPossible = board.hamiltonPossible();  //check if tour possible on current board
    
    if (!tourPossible) {  //if tour is not possible on this board
      redraw();
    }
    
    else  {  //if possible
      knight.pos = spot; 
      knight.pathSequence.remove(s);
      knight.pathSequence.add(s, spot);
      loop();
    }
    
  }
    
} //_CODE_:programMode:688490:

public void startXChanged(GTextField source, GEvent event) { //_CODE_:startX:860684:
  //do nothing
} //_CODE_:startX:860684:

public void startYChanged(GTextField source, GEvent event) { //_CODE_:startY:686614:
  //do nothing  
} //_CODE_:startY:686614:

public void submitStartClicked(GButton source, GEvent event) { //_CODE_:submitStart:759433:
  noLoop();  //can't explain why but putting this in avoids a bug lolz
  
  //reset starting position and all knight and board features
  startingX = int(startX.getText()); 
  startingY = int(startY.getText());
  knight = new Knight(board, startingX, startingY);
  board.addSquares();
  board.squares[startingX][startingY].visited = true;
  setupHelper(); 
  loop();
} //_CODE_:submitStart:759433:

public void boardLengthChanged(GTextField source, GEvent event) { //_CODE_:boardLength:236472:
  //do nothing
} //_CODE_:boardLength:236472:

public void boardWidthChanged(GTextField source, GEvent event) { //_CODE_:boardWidth:216812:
  //do nothing
} //_CODE_:boardWidth:216812:

public void boardDimClicked(GButton source, GEvent event) { //_CODE_:boardDim:316270:
  noLoop(); 
  //reset new board dimensions
  int newX = int(boardLength.getText());
  int newY = int(boardWidth.getText());
  
  //always make larger dimension vertical
  if (newX < newY)
    board = new Board(newX, newY);
  else
    board = new Board(newY, newX);
  
  if (startingX <= board.boardLen-1 && startingY <= board.boardWid-1)  //set knight position accordingly
    knight = new Knight(board, startingX, startingY);
    
  else if (startingX <= board.boardLen-1) {  //if starting y position is now too large for board
    knight = new Knight(board, startingX, 0);
    startingY = 0;
    startY.setText("0");  
  }
  
  else if (startingY <= board.boardWid-1) {  //starting x position too large for board
    knight = new Knight(board, 0, startingY);
    startingX = 0;
    startX.setText("0");
  }
  
  else {  //both starting x and y too large for board
    knight = new Knight(board, 0, 0);
    startingX = 0;
    startingY = 0;
    startX.setText("0");
    startY.setText("0");
  }
    
  setupHelper();  //call setup helper to reset
  loop();
} //_CODE_:boardDim:316270:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 350, 280, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  pauseButton = new GButton(window1, 27, 16, 80, 30);
  pauseButton.setText("Pause");
  pauseButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  pauseButton.addEventHandler(this, "pauseButtonClicked");
  restartButton = new GButton(window1, 135, 16, 80, 30);
  restartButton.setText("Restart");
  restartButton.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  restartButton.addEventHandler(this, "resetButtonClicked");
  animationSpeed = new GSlider(window1, 126, 226, 100, 40, 10.0);
  animationSpeed.setLimits(2.0, 0.5, 5.0);
  animationSpeed.setNumberFormat(G4P.DECIMAL, 2);
  animationSpeed.setOpaque(false);
  animationSpeed.addEventHandler(this, "animationSpeedDragged");
  programMode = new GButton(window1, 247, 16, 80, 30);
  programMode.setText("Make Moves Mode");
  programMode.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  programMode.addEventHandler(this, "programModeClicked");
  startX = new GTextField(window1, 200, 120, 50, 30, G4P.SCROLLBARS_NONE);
  startX.setText("0");
  startX.setOpaque(true);
  startX.addEventHandler(this, "startXChanged");
  startY = new GTextField(window1, 265, 120, 50, 30, G4P.SCROLLBARS_NONE);
  startY.setText("0");
  startY.setOpaque(true);
  startY.addEventHandler(this, "startYChanged");
  submitStart = new GButton(window1, 207, 165, 98, 30);
  submitStart.setText("Submit Start Square");
  submitStart.addEventHandler(this, "submitStartClicked");
  boardLength = new GTextField(window1, 25, 120, 50, 30, G4P.SCROLLBARS_NONE);
  boardLength.setText("8");
  boardLength.setOpaque(true);
  boardLength.addEventHandler(this, "boardLengthChanged");
  boardWidth = new GTextField(window1, 110, 120, 50, 30, G4P.SCROLLBARS_NONE);
  boardWidth.setText("8");
  boardWidth.setOpaque(true);
  boardWidth.addEventHandler(this, "boardWidthChanged");
  boardDim = new GButton(window1, 46, 165, 95, 30);
  boardDim.setText("Update Board Dimensions");
  boardDim.addEventHandler(this, "boardDimClicked");
  boardDimensionsLabel = new GLabel(window1, 32, 78, 126, 20);
  boardDimensionsLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  boardDimensionsLabel.setText("Board Dimensions");
  boardDimensionsLabel.setOpaque(false);
  byLabel = new GLabel(window1, 80, 125, 25, 20);
  byLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  byLabel.setText("X");
  byLabel.setOpaque(false);
  startingPosLabel = new GLabel(window1, 207, 78, 99, 20);
  startingPosLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  startingPosLabel.setText("Starting Square");
  startingPosLabel.setOpaque(false);
  animSpeedLabel = new GLabel(window1, 111, 211, 120, 20);
  animSpeedLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  animSpeedLabel.setText("Animation Speed");
  animSpeedLabel.setOpaque(false);
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GButton pauseButton; 
GButton restartButton; 
GSlider animationSpeed; 
GButton programMode; 
GTextField startX; 
GTextField startY; 
GButton submitStart; 
GTextField boardLength; 
GTextField boardWidth; 
GButton boardDim; 
GLabel boardDimensionsLabel; 
GLabel byLabel; 
GLabel startingPosLabel; 
GLabel animSpeedLabel; 
