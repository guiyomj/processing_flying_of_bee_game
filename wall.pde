class coin {
  float coinx=600;
  float offset;
  boolean passed=false;
  PImage coin = loadImage("coin.png");
  coin(float f) {
    offset=f;
  }
  void update() {
    coinx+=wallspeed;
    image(coin,coinx+10,offset+540);
    if (coinx<184&&(bottom<offset+572||bottom>offset+540)&&passed==false) {
      passed=true;
      coins.remove(0);
      score+=1;
      sscore.play(0);
    }
  }
}

class wall {
  float wallx=600;
  float offset;
  boolean collide=false;
  PImage wall = loadImage("wall.png");
  wall(float f) {
    offset=f;
  }

  void update() {
    wallx+=wallspeed;
    image(wall,wallx,offset); 
    image(wall,wallx,offset+650);
    if (wallx<214&&wallx>150&&(bottom<offset+492||bottom+64>offset+650)) {
      collide=true;
    }
  }
}
