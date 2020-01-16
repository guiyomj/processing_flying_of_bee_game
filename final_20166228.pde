import ddf.minim.*; 
Minim minim = new Minim(this);
ArrayList walls = new ArrayList();
ArrayList coins = new ArrayList();
AudioPlayer bgm, jjump, sscore;
PImage bee, back, gameover, gamestart;
float wallspeed=-2, addwall;  // addwall: space of walls
float jumpspeed=0;
int score, bottom=300;  // bottom: bee's y value
boolean start=false, end=false, jump=false;

void setup() {
  size(600, 400);  
  bee = loadImage("bee.png");
  back = loadImage("background.jpg");
  gameover = loadImage("over.png");
  gamestart = loadImage("start.png");
  jjump = minim.loadFile("jump.mp3",1000);
  sscore = minim.loadFile("score.mp3",1000);
  bgm = minim.loadFile("henesys.mp3",1000);
  bgm.play();
}

void draw() {
  gamestart();
  if (start==true&&end==false) {
    image(back,0,0);
    addwall+=1;
    if (addwall>100) {  // create wall and coin
      float x = random(-450,-300);
      walls.add(new wall(x));
      coins.add(new coin(x));
      addwall=0;
    }
    for (int i=0;i<walls.size();i++) {  // float walls on screen
      wall f1=(wall)walls.get(i);
      f1.update();
      if (f1.collide) {
        end = true;
      }
    }
    for (int j=0;j<coins.size();j++) {  // float coins on screen
      coin f2=(coin)coins.get(j);
      f2.update();
    }
    bottom+=jumpspeed;  // go up after jump
    if ((jump=true)&&(bottom>300)) {  // go down to the ground after jump
      jumpspeed=0;
      jump=false;
      bottom=300;
    }
    translate(200,bottom+30);
    rotate(jumpspeed/-30);
    image(bee,-50,-30);
  }
  else if (end==true) {
    gameover();
  }
}

void gamestart() {
  background(back);
  textSize(30);
  image(gamestart,0,0);
  text("Tab Spacebar to Start!",130,350);
  if (keyPressed==true&&key==' ') {
    start=true;
  }
}

void gameover() {
  background(back);
  textSize(30);
  image(gameover,0,0);
  text("Score : "+score,220,240);
  text("Tab Spacebar to Restart!",120,350);
}

void keyPressed() {  // replay
  if (end==true&&key==' ') {
    jumpspeed=0;
    bottom=300;
    walls.clear();
    coins.clear();
    end=false;
    score=0;
  }
  if (end==false&&key==' ') {  // jump
     jjump.play(0);
     jumpspeed=-8;
     jump=true;
   }
 }

void keyReleased() {  // go down after jump
  if (key==' ') {
    jumpspeed+=10;
    jump=false;
  }
}
