// Buttoner
// Copyright 2020 by miq1@gmx.de

#include "Buttoner.h"

Buttoner::Buttoner(int port, bool onState, bool pullUp, uint32_t queueSize) :
  BE_port(port),
  BE_onState(onState),
  BE_queueSize(queueSize),
  BE_doubleClickTime(BE_defaultDCT),
  BE_pressTime(BE_defaultPT),
  BE_state(BS_IDLE),
  BE_keyState(0),
  BE_stateTimer(0) {
  // If pullUp is set, configure the GPIO accordingly
  if (pullUp) {
    pinMode(BE_port, INPUT_PULLUP);
  } else {
    pinMode(BE_port, INPUT);
  }
}

ButtonEvent Buttoner::getEvent() {
  if (BE_eventList.empty()) return BE_NONE;
  ButtonEvent be = BE_eventList.front();
  BE_eventList.pop();
  return be;
}

ButtonEvent Buttoner::peekEvent() {
  if (BE_eventList.empty()) return BE_NONE;
  return BE_eventList.front();
}

void Buttoner::clearEvents() {
  queue<ButtonEvent>().swap(BE_eventList);
}

void Buttoner::setTiming(uint32_t doubleClickTime, uint32_t pressTime) {
  BE_doubleClickTime = doubleClickTime;
  BE_pressTime = pressTime;
}

int Buttoner::update() {
  // We do not sample in less than 5ms intervals
  if (millis() - BE_stateTimer < 5) {
    return -1;
  }
  BE_stateTimer = millis();

  // Get debounced button state
  // The 0xFC00 (first six bits set) results in 16-6=10 samples being considered 
  // to determine the button state (= 50ms)
  const uint16_t SAMPLES(0xFC00);
  BE_keyState = (BE_keyState << 1) | (digitalRead(BE_port) != BE_onState) | SAMPLES;
  bool buttonState = (BE_keyState == SAMPLES);

  // State machine...
  switch (BE_state) {
  case BS_IDLE:  // Waiting for something to happen
    // Button pressed?
    if (buttonState) {
      // Yes. Wind up timer and proceed to next state
      BE_timer = millis();
      BE_state = BS_CLICKED1;
    }
    break;
  case BS_CLICKED1: // Button was pressed down initially
    // Button still held down?
    if (buttonState) {
      // Yes. Did the holding time pass?
      if (millis() - BE_timer > BE_pressTime) {
        // Yes. Report a PRESS event
        if (!BE_queueSize || BE_eventList.size() < BE_queueSize)  BE_eventList.push(BE_PRESS);
        // Go into cooldown phase to have the button released again
        BE_state = BS_COOLDOWN;
      }
    } else {
      // No, button was released in the meantime. Proceed to next state
      BE_state = BS_RELEASED1;
    }
    break;
  case BS_RELEASED1: // Button was released after the first click
    // Did the time for double clicks pass without another click?
    if (millis() - BE_timer > BE_doubleClickTime) {
      // Yes. report a single click then. No cooldown required!
      if (!BE_queueSize || BE_eventList.size() < BE_queueSize)  BE_eventList.push(BE_CLICK);
      BE_state = BS_IDLE;
    } else {
      // No, still waiting for second click.
      // Was the button clicked again?
      if (buttonState) {
        // Yes. Report double click and proceed to cooldown
        if (!BE_queueSize || BE_eventList.size() < BE_queueSize)  BE_eventList.push(BE_DOUBLECLICK);
        BE_state = BS_COOLDOWN;
      }
    }
    break;
  case BS_COOLDOWN: // Wait for button release
    if (!buttonState) {
      BE_state = BS_IDLE;
    }
    break;
  default: // May not get here, but lint likes it...
    break;
  }
  return BE_eventList.size();
}
