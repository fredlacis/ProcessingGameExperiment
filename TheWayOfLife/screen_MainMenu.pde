void drawMainMenu() {
    cursor();
    noStroke();

    drawButtons();
}

boolean button1Over = false;
boolean button2Over = false;
boolean button3Over = false;

void drawButtons() {
    noStroke();
    checkMousePressed();
    textAlign(CENTER, CENTER);
    textSize(30);

    int buttonWidth = 300;
    int buttonHeight = 70;
    int buttonX = width / 2 - buttonWidth / 2;

    int buttonShift = 85;

    int button1Y = height / 2 - (buttonHeight / 2 + buttonHeight + 15) + buttonShift;
    int button2Y = height / 2 - buttonHeight / 2 + buttonShift;
    int button3Y = height / 2 - (buttonHeight / 2 - buttonHeight - 15) + buttonShift;

    button1Over = overRect(buttonX, button1Y, buttonWidth, buttonHeight);
    button2Over = overRect(buttonX, button2Y, buttonWidth, buttonHeight);
    button3Over = overRect(buttonX, button3Y, buttonWidth, buttonHeight);

    color baseColor = color(0, 65, 100);
    color hoverColor = color(0, 40, 60);
    color textColor = color(0, 130, 210);

    /*****BUTTON 1*****/
    if (button1Over) {
        fill(hoverColor);
    } else {
        fill(baseColor);
    }
    rect(buttonX, button1Y, buttonWidth, buttonHeight);
    fill(textColor);
    text("START", buttonX, button1Y, buttonWidth, buttonHeight-5);

    /*****BUTTON 2*****/
    if (button2Over) {
        fill(hoverColor);
    } else {
        fill(baseColor);
    }
    rect(buttonX, button2Y, buttonWidth, buttonHeight);
    fill(textColor);
    text("CREDITS", buttonX, button2Y, buttonWidth, buttonHeight-5);

    /*****BUTTON 3*****/
    if (button3Over) {
        fill(hoverColor);
    } else {
        fill(baseColor);
    }
    rect(buttonX, button3Y, buttonWidth, buttonHeight);
    fill(textColor);
    text("EXIT", buttonX, button3Y, buttonWidth, buttonHeight-5);

    image(loadImage("TitleScreen.png"), 0, 0, width, height);
}

boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x + width &&
        mouseY >= y && mouseY <= y + height) {
        return true;
    } else {
        return false;
    }
}

void checkMousePressed() {
    if(mousePressed){
        if (button1Over) {
            character.currentLife = 100;
            character.addDamageDelay(3);
            orbSpawnTimestamp = millis() + 25000;
            whaleSpawnTimestamp = millis();
            currentGameState = GameStates.Playing;
        } else if (button2Over) {
            currentGameState = GameStates.Credits;
        } else if (button3Over) {
            exit();
        }
    }
}

void youDiedScreen(){
    
    cursor();

    image(loadImage("YouDiedScreen.png"), 0, 0, width, height);

    if(mousePressed){
        if(mouseX >= 418 && mouseX <= 418+444
        && mouseY >= 472 && mouseY <= 472+85){
            currentGameState = GameStates.MainMenu;
        }
    }

}

void creditsScreen(){

    cursor();

    image(loadImage("CreditsScreen.png"), 0, 0, width, height);

    if(mousePressed){
        if(mouseX >= 102 && mouseX <= 102+134
        && mouseY >= 84 && mouseY <= 84+48){
            currentGameState = GameStates.MainMenu;
        }
    }

}

void keyPressed() {
  if(key == 'm' || key == 'M'){
    playMusic = !playMusic;
  } 
  
  if(key == 'h' || key == 'H'){
    DEBUG_MODE = !DEBUG_MODE;
  } 
  
  if (key == 'd' || key == 'D') {
    if(DEBUG_MODE){
      character.currentLife = 0;
    }
  }
}
