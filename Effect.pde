PImage screenshot1, screenshot2;
float start = 0;
String s1 = "Nowadays game with 3D engine";
String s2 = "Do you still remember ...";
String s3 = "Pokemons and your childhood ?";

void testCollision(Pokeball p) {
  boolean touched = false;
  if (adv) {
    if (dist(p.x+POKE_BALL_SIZE/2, p.y+POKE_BALL_SIZE/2, xp+PIKA_WIDTH/2, yp+PIKA_LEN/2) < 45+POKE_BALL_SIZE/2) 
      touched = true;
  } else {
    if ((xs>=0 && dist(p.x, p.y, xp+87, yp+35)<POKE_BALL_SIZE/2) 
      || (xs<0 && dist(p.x, p.y, xp+12, yp+35)<POKE_BALL_SIZE/2)) touched = true;
  }
  if (touched) {
    p.touched = true;
    p.touchedTime = millis();
    // play sound when touch a pokeball
    pika = minim.loadFile("pika.mp3");
    pika.play();
  }
}

void bounceBack() {
  if (xp<0) {
    xs = -xs;
    xp = -xp;
  }
  if (xp>800-PIKA_WIDTH) {
    xs = -xs;
    xp = 800-PIKA_WIDTH;
  }
  if (yp<0) {
    ys = -ys;
    yp = - yp;
  }
  if (yp>500-PIKA_LEN) {
    ys = -ys;
    yp = 500-PIKA_LEN;
  }
}

// the end scene
void advanced() {
  score += 20;
  pikachu = loadImage("Raichu.png");
  pikachuR = loadImage("RaichuR.png");
  pikachu.resize(100,87);
  pikachuR.resize(100,87);
  PIKA_WIDTH = 100;
  PIKA_LEN = 87;
  pokeballNum = 4;
  adv = true;
}

void end() {
  end = true;
  if (transp2 < 250) {
    rect(0, 0, 800, 600);
    fill(0, 0, 0, transp2);
    transp2++;
  } else {
    PImage endimg;
    over = true;
    endimg = loadImage("End.jpg");
    background(endimg);
    textSize(40); 
    fill(250, 150, 150);
    s = "Score: "+str(score);
    text(s, 320, 80);
  }
}
