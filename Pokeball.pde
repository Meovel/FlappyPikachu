int pokeballNum = 2;
int POKE_BALL_SIZE = 25;
int POKEBALL_RECOVER_TIME = 2000;
float lastRemove;
ArrayList<Pokeball> pokeballs = new ArrayList<Pokeball>();

void pokeballProcess() {
  // add pokeball when needed
  //if ((t2-lastRemove)/1000 > 5) end = true;
  if (pokeballs.size()<pokeballNum && t2-lastRemove>POKEBALL_RECOVER_TIME) {
    pokeballs.add(new Pokeball(random(400, 650), random(0, 450)));
  }
  if (t2 - t0 > 500) {
    changespeed=true;
    t0 = t2;
  }
  for (int i = pokeballs.size ()-1; i>=0; i--) {
    Pokeball ball = pokeballs.get(i);
    if (changespeed) ball.changeSpeed();
    ball.move();
    if (!ball.touched) testCollision(ball);
    ball.display();
    if (ball.touched) {
      if (t2-ball.touchedTime >5000) {
        float rand = random(-1, 7);
        if (rand>0) {
          pokemons.add(new Pokemon(ball.x, ball.y, (int) random(1, POKEMON_NUM), 0));
          score++;
        }
        else {
          pokemons.add(new Pokemon(ball.x, ball.y, (int) random(50, 50+POKEMON_FLY_NUM), 1));
          score += 5;
        }
        pokeballs.remove(i);
        lastRemove = t2;
      }
      if (t2-ball.touchedTime >4000) {
        ball.pokeball = loadImage("Pokeball_open.png");
        ball.pokeball.resize(POKE_BALL_SIZE, POKE_BALL_SIZE);
        ball.open = true;
      }
    }
  }
  if (changespeed) changespeed=false;
}

class Pokeball {
  PImage pokeball;
  boolean touched = false;
  boolean open = false;
  float touchedTime;
  float x, y, xs, ys;
  float speed = 3;
  int rotateDirection = 1;
  int rotateControl = 0;

  Pokeball(float xp, float yp) {
    pokeball = loadImage("PokeBall.png");
    pokeball.resize(POKE_BALL_SIZE, POKE_BALL_SIZE);
    x = xp;
    y = yp;
    changeSpeed();
  }

  void display() {
    if (open || y<550 || rotateControl%100>25) 
    image(pokeball, x, y);
    else {
      pushMatrix();
      translate(x, y);
      rotate((PI/12)*rotateDirection);
      if (rotateControl%100<1) rotateDirection = - rotateDirection;
      image(pokeball, 0, 0);
      popMatrix();
    }
    rotateControl++;
  }

  void move() {
    if (touched) {
      if (y<550) y+=10;
    } else {
      this.x = this.x - this.xs;
      this.y = this.y - this.ys;
      if (this.x<0) {
        this.x=-this.x;
        bounceBack();
      }
      if (this.x>700) {
        this.x=1400-this.x;
        bounceBack();
      }
      if (this.y<0) {
        this.y=-this.y;
        bounceBack();
      }
      if (this.y>500) {
        this.y=1000-this.y;
        bounceBack();
      }
    }
  }

  void bounceBack() {
    this.xs = -this.xs;
    this.ys = -this.ys;
  }

  void changeSpeed() {
    float fac = speed + t2/100000;
    this.xs = random(-fac, fac);
    this.ys = random(-fac, fac);
  }
}

