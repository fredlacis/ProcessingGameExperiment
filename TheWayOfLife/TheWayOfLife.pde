//
//   G1 - Interfaces Físicas e Lógicas - DSG1412
//   Aluno: Frederico Lacis
//   Matrícula: 1810590
//
import ddf.minim.*;

boolean DEBUG_MODE = true;
boolean GOD_MODE = false;

///GLOBAL VARIABLES
/// Background image
PImage bg;
/// The enviroment (Clouds + Sun)
Enviroment enviroment;
/// GameState used to know what screen to draw
GameStates currentGameState;
/// Background sound
boolean playMusic = true;
Minim minim;
AudioPlayer player;

void setup() {
  size(1280, 720, P3D);
  frameRate(30);

  bg = loadImage("background.png");
  enviroment = new Enviroment();

  setupGameplay();

  currentGameState = GameStates.MainMenu;

  minim = new Minim(this);
  player = minim.loadFile("windSound.mp3");
  player.loop();
}

void draw() {

  background(bg);
  enviroment.drawEnviroment();

  switch (currentGameState) {
    case MainMenu:
      drawMainMenu();
      break;
    case Playing:
      drawGameplay();
      break;
    case Credits:
      creditsScreen();
      break;
    case Died:
      youDiedScreen();
      break;
    default :
      exit();
      break;	
  }

  playBackgroundSound();

  debugMenu();
}

void playBackgroundSound(){
  if(playMusic){
    player.play();
    if(player.position() >= player.length() - 2000){
      player.rewind();
    }
  } else {
    player.pause();
  }
}

void debugMenu() {
  if (DEBUG_MODE) {
    fill(0);
    textSize(20);
    textAlign(LEFT);
    text("Press H to exit or enter DEBUG_MODE", 10, 20);
    text("FrameRate: " + int(frameRate), 10, 40);
    text("FrameCount: " + int(frameCount), 10, 60);
    text("Millis: " + int(millis()), 10, 80);
    text("Whales: " + int(whales.size()), 10, 100);
    text("PlayMusic: " + playMusic, 10, 120);
    text("Life: " + int(character.currentLife), 10, 140);
    text("GOD_MODE: " + GOD_MODE, 10, 160);
    text("Press M to mute", 10, 180);
    text("Press D to die", 10, 200);
  }
  
}

enum GameStates {
  MainMenu,
  Playing,
  Credits,
  Died
}
