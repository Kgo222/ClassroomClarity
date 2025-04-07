#include <TFT_eSPI.h>
#define LINE_SPACING 4
void drawWrappedText(std::string str, int x, int y, int maxWidth, TFT_eSPI* tft) {
  int cursorX = x;
  int cursorY = y;
  String word = ""; // Stores each word
  
  for (int i = 0; i < str.length(); i++) {
    char c = str[i];

    if (c == ' ' || i == str.length() - 1) {  // End of a word
      if (i == str.length() - 1){
        word += c;   // Add last character if it's the end
      } 

      int wordWidth = tft->textWidth(word); // Get word width given set screen parameters (font size, font, etc.)

      if (cursorX + wordWidth > maxWidth) { // If word doesn’t fit, move to new line
        cursorX = x;
        cursorY += tft->fontHeight() + LINE_SPACING;
      }

      tft->setCursor(cursorX, cursorY);
      tft->print(word); // Print the word
      cursorX += wordWidth + tft->textWidth(" "); // Move cursor forward

      word = ""; // Reset word
    } else {
      word += c; // Append character to the word
    }
  }
}