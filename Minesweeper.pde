

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[20][20];
    for(int i = 0; i < buttons.length; i++){
      for(int j = 0; j < buttons[i].length; j++){
        buttons[i][j] = new MSButton(i,j);
      }
    }
    
    setMines();
}
public void setMines()
{
  for(int i = 0; i < 20; i++){
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
    }else{i--;}
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r=0;r<NUM_ROWS;r++)
        for(int c=0;c<NUM_COLS;c++)
        {
            if(mines.contains(buttons[r][c])&&buttons[r][c].isFlagged()==false)
                return false;
            if(mines.contains(buttons[r][c])==false&&buttons[r][c].isFlagged())
                return false;
        }
    return true;
}
public void displayLosingMessage()
{
  noLoop();
  
  for(int i = 0; i < buttons.length; i++){
    for(int j = 0; j < buttons[i].length; j++){
      if(mines.contains(buttons[i][j])){
        buttons[i][j].setClicked(true);
      }
    }
  }
        buttons[10][6].setLabel("y");
        buttons[10][7].setLabel("o");
        buttons[10][8].setLabel("u");
        buttons[10][9].setLabel("");
        buttons[10][10].setLabel("l");
        buttons[10][11].setLabel("o");
        buttons[10][12].setLabel("s");
        buttons[10][13].setLabel("e");
}
public void displayWinningMessage()
{
    if(isWon()==true)
    {
        buttons[10][9].setLabel("y");
        buttons[10][10].setLabel("o");
        buttons[10][11].setLabel("u");
        buttons[11][9].setLabel("w");
        buttons[11][10].setLabel("i");
        buttons[11][11].setLabel("n");
    }
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && c < NUM_COLS && r >= 0 && c >= 0)
    return true;
  return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row - 1, col) == true && mines.contains(buttons[row - 1][col]))
      numMines++;
    if(isValid(row - 1,col - 1) == true && mines.contains(buttons[row - 1][col - 1]))
      numMines++;
    if(isValid(row - 1,col + 1) == true && mines.contains(buttons[row - 1][col + 1]))
      numMines++;
    if(isValid(row,col + 1) == true && mines.contains(buttons[row][col + 1]))
      numMines++;
    if(isValid(row, col- 1) == true && mines.contains(buttons[row][col - 1]))
      numMines++;
    if(isValid(row + 1,col) == true && mines.contains(buttons[row + 1][col]))
      numMines++;
    if(isValid(row + 1,col - 1) == true && mines.contains(buttons[row + 1][col - 1]))
      numMines++;
    if(isValid(row + 1,col + 1) == true && mines.contains(buttons[row + 1][col + 1]))
      numMines++;
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    public void setClicked(boolean n){clicked = n;}
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        if(mouseButton == RIGHT){
          if(flagged == true){
            clicked = false;
            flagged = false; 
          }else if(flagged == false){
            flagged = true;
          }
      }
      if(mouseButton == LEFT){
        clicked = true;
        if(mines.contains(this)){
            displayLosingMessage();
          }else if(countMines(myRow,myCol) > 0){
            buttons[myRow][myCol].setLabel(countMines(myRow,myCol));
          }else{
            if(isValid(myRow - 1, myCol))
              if(!buttons[myRow - 1][myCol].isClicked())
                buttons[myRow - 1][myCol].mousePressed();
            if(isValid(myRow - 1, myCol + 1))
              if(!buttons[myRow - 1][myCol + 1].isClicked())
                buttons[myRow - 1][myCol + 1].mousePressed();
            if(isValid(myRow - 1, myCol - 1))
              if(!buttons[myRow - 1][myCol - 1].isClicked())
                buttons[myRow - 1][myCol - 1].mousePressed();
            if(isValid(myRow, myCol + 1))
              if(!buttons[myRow][myCol + 1].isClicked())
                buttons[myRow][myCol + 1].mousePressed();
            if(isValid(myRow, myCol - 1))
              if(!buttons[myRow][myCol - 1].isClicked())
                buttons[myRow][myCol - 1].mousePressed();
            if(isValid(myRow + 1, myCol))
              if(!buttons[myRow + 1][myCol].isClicked())
                buttons[myRow + 1][myCol].mousePressed();
            if(isValid(myRow + 1, myCol + 1))
              if(!buttons[myRow + 1][myCol + 1].isClicked())
                buttons[myRow + 1][myCol + 1].mousePressed();
            if(isValid(myRow + 1, myCol - 1))
              if(!buttons[myRow + 1][myCol - 1].isClicked())
                buttons[myRow + 1][myCol - 1].mousePressed();
          }
      }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked(){
      return clicked;
    }
}
