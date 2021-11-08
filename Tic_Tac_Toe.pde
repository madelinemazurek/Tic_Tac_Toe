//this program is an interactive player vs player tic tac toe game

//collecting user input
import javax.swing.JOptionPane;
String player1 = JOptionPane.showInputDialog("Please enter player 1 name:");
String player2 = JOptionPane.showInputDialog("Please enter player 2 name:");

int [][] grid = new int [3][3];  //memory array (X = 1), (O = 2)
boolean turn = true;             //true for player 1's turn, false for player 2's turn
boolean switchTurns = true;      //only true if a valid move has been played last
boolean gameOver = false;        //checks to see if game has finished
int shape = 1;                   //cooresponds to the shape that is drawn, (X = 1), (O = 2)
int x = 0, y = 0;                //coordinates of click location
int winner = 0;                  //stores the winner of the game, (tie = 0), (player1 = 1), (player2 = 2)

void setup () {
  size (1200, 1300);
  background (0);
  strokeWeight(6);
  stroke (255);
  textSize(40);
  drawHeader(turn);   //starts header with player 1
  drawGrid();         //grid setup
}

void draw () {
} //neccessary to run mouseClicked

void mouseClicked() 
{ //only runs if click is within bounds
  if ((mouseX>0)&&(mouseX<width)&&(mouseY>100)&&(mouseY<height))
  { 
    //records location of click in global variables
    x = mouseX;
    y = mouseY;

    //draws the shape
    drawShape();

    //checks for game over and ends if true
    checkGameOver();
    if (gameOver) 
      displayWinner(winner);

    //continues program if game hasnt ended
    if (gameOver == false) {
      if (switchTurns)          
        changePlayers();         //switches player
      drawHeader(turn);          //updates new header 
      shape = nextShape(turn);   //updates next shape to be used
    }
  }
}

// updates header
void drawHeader(boolean p1turn)
{
  if (p1turn == true) {
    fill(#B694CB);
    rect(0, 0, width, 100);
    fill(255);
    text(player1 + "'s turn", 30, 60);
  } else {
    fill(#A8E2ED);
    rect(0, 0, width, 100);
    fill (255);
    text(player2 + "'s turn", 30, 60);
  }
}

//draws grid
void drawGrid()
{
  line (width/3, 100, width/3, height);
  line (2*width/3, 100, 2*width/3, height);
  line (0, (height+200)/3, width, (height+200)/3);
  line (0, (2*height+100)/3, width, (2*height+100)/3);
}

//draws shape and updates memory
//only runs if clicked area is valid
//if no shape drawn will ensure that turn does not change
void drawShape()
{
  boolean shapeDrawn = false;
  for (int i = 100, row = 0; i < height; i+=((height-100)/3), row++) {
    if (y>i && y<(i+((height-100)/3))) {
      for (int j = 0, col = 0; j < width; j+=(width/3), col++) {
        if (x>j && x<(j+(height/3))&&(grid[row][col]==0)) {
          grid[row][col] = shape;
          if (shape == 1) {
            drawX(row, col);
            shapeDrawn = true;
          } else if (shape == 2) {
            drawO(row, col);
            shapeDrawn = true;
          }
        }
      }
    }
  }
  if (shapeDrawn)
    switchTurns = true;
  else
    switchTurns = false;
}

//draws an X in designated location
void drawX (int row, int col)
{
  int xSh = (width/3)*col;
  int ySh = ((height-100)/3)*row;
  line(xSh+20, ySh+((height-100)/3)+80, xSh+(width/3)-20, ySh+120);
  line(xSh+20, ySh+120, xSh+(width/3)-20, ySh+((height-100)/3)+80);
}

//draws an O in designated location
void drawO (int row, int col)
{
  noFill();
  int xSh = (width/3)*col;
  int ySh = ((height-100)/3)*row;
  ellipse(xSh+(width/6), ySh+((height-100)/6+100), (width/4), (width/4));
}

//checks all possible winning combinations, draws connecting line if game is won
void checkGameOver()
{
  int sWeight = 15;

  for (int i = 0; i < 3; i++) { //rows
    if ((grid[i][0]==grid[i][1])&&(grid[i][0]==grid[i][2])&&(grid[i][0]!=0)) {
      gameOver = true;
      winner = grid[i][0];
      strokeWeight(sWeight);
      stroke(#F75A20);
      line (30, i*((height-100)/3)+100+((height-100)/6), width-30, i*((height-100)/3)+100+((height-100)/6));
    }
  }
  for (int j = 0; j < 3; j++) { //columns
    if ((grid[0][j]==grid[1][j])&&(grid[0][j]==grid[2][j])&&(grid[0][j]!=0)) {
      gameOver = true;
      winner = grid[0][j];
      strokeWeight(sWeight);
      stroke(#F75A20);
      line (j*(width/3)+(width/6), 130, j*(width/3)+(width/6), height-30);
    }
  }
  //diagonals
  if ((grid[0][0]==grid[1][1])&&(grid[0][0]==grid[2][2])&&(grid[0][0]!=0)) {
    gameOver = true;
    winner = grid[0][0];
    strokeWeight(sWeight);
    stroke(#F75A20);
    line(30, 130, width-30, height-30);
  }
  if ((grid[2][0]==grid[1][1])&&(grid[2][0]==grid[0][2])&&(grid[2][0]!=0)) {
    gameOver = true;
    winner = grid[2][0];
    strokeWeight(sWeight);
    stroke(#F75A20);
    line(30, height-30, width-30, 130);
  }
  //tie
  boolean cont = false;
  for (int i=0; i < 3; i++) {
    for (int j=0; j < 3; j++) {
      if (grid[i][j] == 0)
        cont = true;
    }
  }
  if (cont == false)
    gameOver = true;
}

//changes banner to congratulate winner
void displayWinner (int winner)
{
  strokeWeight(6);
  stroke(255);

  if (winner == 1) {
    fill (#982B0C);
    rect (0, 0, width, 100);
    fill (255);
    text ("The winner is "+ player1+ "! Congratulations!", 30, 60);
  } else if (winner == 2) {
    fill (#982B0C);
    rect (0, 0, width, 100);
    fill (255);
    text ("The winner is "+ player2+ "! Congratulations!", 30, 60);
  } else {
    fill (#2924DE);
    rect (0, 0, width, 100);
    fill (255);
    text ("This game is a tie!", 30, 60);
  }
}

//changes the active player
void changePlayers()
{
  if (turn)
    turn = false;
  else
    turn = true;
}

//sets next shape to be drawn
int nextShape (boolean turn)
{
  int shape;
  if (turn == true)
    shape = 1;//next will be X
  else
    shape = 2;//next will be O
  return shape;
}
