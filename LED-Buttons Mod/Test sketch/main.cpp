#include <Arduino.h>

#include <FastLED.h>
#include "Buttoner.h"

///////////////////////////////////////////////////////////////////////////////////////////
//
// Move a white dot along the strip of leds.  This program simply shows how to configure the leds,
// and then how to turn a single pixel white and then off, moving down the line of pixels.
// 

// How many leds are in the strip?
#define NUM_LEDS 48

// For led chips like WS2812, which have a data line, ground, and power, you just
// need to define DATA_PIN.  For led chipsets that are SPI based (four wires - data, clock,
// ground, and power), like the LPD8806 define both DATA_PIN and CLOCK_PIN
// Clock pin only needed for SPI based chipsets when not using hardware SPI
#define DATA_PIN  D6
// #define CLOCK_PIN 13

Buttoner toggle(D5, LOW, true);
uint8_t mode = 0;
const uint8_t MAXMODE = 2;

// This is an array of leds.  One item for each led in your strip.
CRGB leds[NUM_LEDS];

const uint16_t usedLED[] = {
   0, 2, 3, 6, 7, 10, 11, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31, 34, 35, 38, 39, 42, 44, 46, 47, 9999 
};

// This function sets up the ledsand tells the controller about them
void setup() {
  // sanity check delay - allows reprogramming if accidently blowing power w/leds
  delay(2000);

  Serial.begin(115200);
  while(!Serial) {
    Serial.printf(". ");
  }
  Serial.printf("_OK_\n");

  FastLED.addLeds<WS2812B, DATA_PIN, RGB>(leds, NUM_LEDS);  // GRB ordering is typical
  FastLED.setBrightness(27);
}

// This function runs over and over, and is where you do the magic to light
// your leds.
void loop() {
  static unsigned long T3 = 0;
  static unsigned long T2 = 0;
  static uint8_t ONOFF = 0;
  static uint16_t point = 0;

  T2 = millis();
  if(toggle.update()) {
    if(toggle.getEvent() == BE_CLICK) {
      mode++;
      if (mode > MAXMODE) {
          mode = 0;
      }
      Serial.printf("mode=%u\n", mode);
    }
  } 

  if (mode == 0 || mode == 1) {
    if (T2 - T3 > 2000) {
      if (ONOFF == 0) {
        CRGB randomcolor_1  = CHSV(random(192), 255, 255);
        CRGB randomcolor_2  = CHSV(random(192), 255, 255);
        if (mode == 0) {
          for(int led = 0; led < NUM_LEDS; led++) {
            leds[led] = randomcolor_1;
            if (random(8) == 1) leds[led] = randomcolor_2;
          }
        } else {
          for(auto led : usedLED) {
            if (led < 9999) {
              leds[led+1] = randomcolor_1;
              if (random(8) == 1) leds[led+1] = randomcolor_2;
            }
          }
        }
      } else {
        for(int led = 0; led < NUM_LEDS; led++) {
          // Turn our current led back to black for the next loop around
          leds[led] = CRGB::Black;
        }
      }
      FastLED.show();
      T3 = millis();
      ONOFF = !ONOFF;
    }
  } else if (mode == 2) {
    if (T2-T3 > 500) {
      for(int led = 0; led < NUM_LEDS; led++) {
        leds[led] = CRGB::DarkBlue;
      }
      leds[point] = CRGB::DarkGoldenrod;
      point++;
      if (point >= NUM_LEDS) point = 0;
      FastLED.show();
      T3 = millis();
    }
  }
}