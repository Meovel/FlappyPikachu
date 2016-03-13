int POKEMON_NUM = 10, POKEMON_FLY_NUM = 3;
int POKEMON_LIFE = 60;
int POKEMON_SIZE = 50, POKEMON_FLY_SIZE = 100;
int evaluated = 0;
ArrayList<Pokemon> pokemons = new ArrayList<Pokemon>();

void pokemonProcess() {
  for (int i = pokemons.size ()-1; i>=0; i--) {
    Pokemon mon = pokemons.get(i);
    if ((t2-mon.born)/1000>POKEMON_LIFE) {
      pokemons.remove(mon);
      monsClicked.remove(mon);
    } else {
      float rand = random(-1, 100);
      if (rand<0) mon.genSpeed();
      mon.move();
      mon.display();
    }
  }
}

class Pokemon {
  PImage pokemon, pokemonR;
  float x, y, xs, ys, born;
  int sizex, sizey, no, mode;
  boolean clicked;

  Pokemon(float xp, float yp, int n, int m) {
    String add = "Pokemon"+str(n);
    pokemon = loadImage(add + ".png");
    pokemonR = loadImage(add + "R.png");
    no = n;
    mode = m;
    born = t2;
    if (mode == 0) {
      sizex = POKEMON_SIZE;
      sizey = POKEMON_SIZE;
      x = xp;
      y = random(550-POKEMON_SIZE, 600-POKEMON_SIZE);
    } else {
      sizex = (int) (POKEMON_FLY_SIZE*1.5);
      sizey = POKEMON_FLY_SIZE;
      x = xp;
      y = yp;
    }
    clicked = false;
    pokemon.resize(sizex, sizey);
    pokemonR.resize(sizex, sizey);
    genSpeed();
  }

  void genSpeed() {
    if (mode == 0) this.xs = random(-1.5, 1.5);
    else {
      this.xs = random(-1.5, 1.5);
      this.ys = random(-1.5, 1.5);
    }
  }

  void move() {
    x = x + xs;
    if (mode == 1) y = y + ys;
    if (x<0) {
      xs = -xs;
      x = - x;
    }
    if (x>(800-sizex)) {
      xs = -xs;
      x = 2*(800-sizex)-x;
    }
    if (y<0) {
      ys = -ys;
      y = -y;
    }
    if (mode == 0) {
      if (y>(600-sizey)) {
        ys = -ys;
        y = 2*(600-sizey) - y;
      }
    } else {
      if (y>(450-sizey)) {
        ys = -ys;
        y = 2*(450-sizey) - y;
      }
    }
  }

  void display() {
    if (xs < 0) image(pokemon, x, y);
    else image(pokemonR, x, y);
  }
}

void monClicked(Pokemon m) {
  if (!m.clicked) {
    click++;
    monsClicked.add(m);
    m.clicked = true;
    m.pokemon.resize((int) (m.sizex*1.2), (int) (m.sizey*1.2));
    m.pokemonR.resize((int) (m.sizex*1.2), (int) (m.sizey*1.2));
  } else {
    click--;
    monsClicked.remove(m);
    m.clicked = false;
    m.pokemon.resize(m.sizex, m.sizey);
    m.pokemonR.resize(m.sizex, m.sizey);
    m.clicked = false;
  }
}

void evolution() {
  // test if all pokemons selected are the same type
  boolean evo = true;
  for (int i = monsClicked.size ()-1; i>0; i--) {
    Pokemon mon = monsClicked.get(i);
    if (mon.no != monsClicked.get(0).no) evo = false;
  }
  if (evo) {
    click = 0;
    evaluated++;
    score += 10;
    Pokemon mon = monsClicked.get(0);
    String add = "Pokemon"+str(mon.no);
    if (mon.no == 9) {
      String t = str (int (random(0, 3)));
      mon.pokemon = loadImage(add + "b" + t + ".png");
      mon.pokemonR = loadImage(add + "Rb" + t + ".png");
    } else {
      mon.pokemon = loadImage(add + "b.png");
      mon.pokemonR = loadImage(add + "Rb.png");
    }
    mon.pokemon.resize(90, 90);
    mon.pokemonR.resize(90, 90);
    mon.born = t2;
    mon.sizex = 90;
    mon.sizey = 90;

    monsClicked.remove(mon);
    for (int i = monsClicked.size ()-1; i>=0; i--) {
      mon = monsClicked.get(i);
      monsClicked.remove(mon);
      pokemons.remove(mon);
    }
  }
}

