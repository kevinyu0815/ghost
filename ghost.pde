PImage bg,start1,start2,lose,win,restart,ghost;
float SpeedW1=1;
float SpeedW2=2;
float SpeedW3=3;
float ghostX, ghostY;
float ghostSpeed=5;

final int GAME_START = 0, GAME_RUN = 1, GAME_WIN = 2, GAME_LOSE = 3;
int gameState=0;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

float W1X, W2X, W3X; //set by my own -> white line

void setup(){
  size(600,500);
  bg=loadImage("img/bg.jpg");
  start1=loadImage("img/start1.jpg");
  start2=loadImage("img/start2.jpg");
  lose=loadImage("img/lose.jpg");
  win=loadImage("img/win.jpg");
  restart=loadImage("img/restart.jpg");
  ghost=loadImage("img/ghost.jpg");
  //start location for ghost
  //these part is very important everytime you restart the game!!!
  ghostX=width/2-25;
  ghostY=0; 
  W1X = 50;
  W2X = 200;
  W3X = 450;
}

void draw(){
  switch(gameState){
    //GAME_START
    case GAME_START:
      
      image(start1,0,0,600,500);
      if (mouseX > 150 && mouseX < 450 && mouseY>210 && mouseY<285){
        if (mousePressed){
          // click
          gameState = GAME_RUN;
          mousePressed =false;  //think
        }else{
          // hover
          image(start2,0,0,600,500);
        }
      }
      break; //don't forget
      
    //GAME_RUN
    case GAME_RUN:
      //ghost 
      //move
      if (upPressed) {
        ghostY -= ghostSpeed;
      }
      if (downPressed) {
        ghostY += ghostSpeed;
      }
      if (leftPressed) {
        ghostX -= ghostSpeed;
      }
      if (rightPressed) {
        ghostX += ghostSpeed;
      }
      //boundary detection
      if (ghostX> (width-50)){
        ghostX = width-50;
      }
      if (ghostX<0){
        ghostX = 0;
      }
      if (ghostY > (height-50)){
        ghostY = height-50;
      }
      if (ghostY < 0){
        ghostY = 0;
      }
      //draw
      image(bg, 0,0,600,500); //not background(255);
        
    //wall
      fill(135,200,155);
      noStroke();
      
      //wall1
        rect(0,100,600,5);
        fill(255);
        //boundary detection
        if (W1X+300>width || W1X<0){
          SpeedW1 *= -1;
        }
        rect(W1X,100,300,5);
        W1X += SpeedW1;
        
      //wall2
        fill(#87C89B);
        rect(0,200,600,5);
        fill(255);
        if (W2X+200>width || W2X<0){
          SpeedW2 *= -1;
        }
        rect(W2X,200,200,5);
        W2X += SpeedW2;
        
      //wall3
        fill(#87C89B);
        rect(0,300,600,5);
        fill(255);
        if (W3X+100>width || W3X<0){
          SpeedW3 *= -1;
        }
        rect(W3X,300,100,5);
        W3X += SpeedW3;
        
      image(ghost,ghostX,ghostY,50,50);
      
      //when will win
      if(ghostY == 400){
        gameState = GAME_WIN;
      }
      
      //when will lose
      if(ghostX+50>W1X+300 || ghostX<W1X){
        if(ghostY+50 >= 100 && ghostY<=105){ 
          gameState = GAME_LOSE;
        }
      }
     if(ghostX+50>W2X+200 || ghostX<W2X){
        if(ghostY+50 >= 200 && ghostY<=205){
          gameState = GAME_LOSE;
        }
      }
      if(ghostX+50>W3X+100 || ghostX<W3X){
        if(ghostY+50 >= 300 && ghostY<=305){
          gameState = GAME_LOSE;
        }
      }
     
      break; //don't forget
      
      //when will lose
      
      
    //GAME_WIN
    case GAME_WIN:
      image(win,0,0,600,500);
      if (mouseX > 150 && mouseX < 450 && mouseY>210 && mouseY<285){
        if (mousePressed){
          // click
          //important !!!!(or it will lose immediately)
          ghostX=width/2-25;
          ghostY=0; 
          W1X = 50;
          W2X = 200;
          W3X = 450;
          gameState = GAME_RUN;
          mousePressed = false;
        }else{
          // hover
          image(restart,0,0,600,500);
        }
      }
      break;
      
    //GAME_LOSE
    case GAME_LOSE:
      image(lose,0,0,600,500);
      if (mouseX > 150 && mouseX < 450 && mouseY>210 && mouseY<285){
        if (mousePressed){
          // click
          //important !!!!(or it will lose immediately)
          ghostX=width/2-25;
          ghostY=0; 
          W1X = 50;
          W2X = 200;
          W3X = 450;
          gameState = GAME_RUN;
          mousePressed = false;
        }else{
          // hover
          image(restart,0,0,600,500);
        }
      }
      break;
    
  } 
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}

/*part1 : key_move(move), state squre(switch), racing car(start / hover)
          draw() changing state 60 times a second */
//part2 : ponBouncing to make speed *= 1
//part3 : use && || to define when to lose and when to win 