// Buttoner
// Copyright 2020 by miq1@gmx.de
//
// Buttoner maintains a click button connected to a GPIO.
// It can register single and double clicks and a long press.
// Button events are kept in a queue for serial processing
// 
#ifndef _BUTTONER_H
#define _BUTTONER_H
#include <Arduino.h>
#include <queue>

using std::queue;

// Reported events
enum ButtonEvent : uint8_t { BE_NONE = 0, BE_CLICK, BE_DOUBLECLICK, BE_PRESS };

// Timing values
const uint32_t BE_defaultDCT(250);   // maximum time between clicks of a double click
const uint32_t BE_defaultPT(400);    // holding time to determine a held button

class Buttoner {
public:
  // Constructor: arguments are
  // - port: GPIO number (mandatory)
  // - onState: logic level of the GPIO when the button is pressed
  // - pullUp: set to true to have the GPIO configured as INPUT_PULLUP
  // - queueSize: number of events to keep (0=unlimited)
  explicit Buttoner(int port, bool onState = HIGH, bool pullUp = false, uint32_t queueSize = 4);

  // update: polling function to read the button state and generate events. This function
  // needs to be called frequently!
  // Returns the number of events currently held in queue
  int update();

  // getEvent: pull first event from queue, deleting it from the queue
  ButtonEvent getEvent();

  // peekEvent: get first event from queue, but leaving the entry in queue
  ButtonEvent peekEvent();

  // clearEvents: purge all events unseen from queue
  void clearEvents();

  // setTiming: adjust the times for double clicks and held buttons to your preferences
  void setTiming(uint32_t doubleClickTime, uint32_t pressTime);

  // qSize: get the number of events curently in queue
  inline uint32_t qSize() { return BE_eventList.size(); }

protected:
  int BE_port;                     // GPIO number of button
  bool BE_onState;                 // logical level of a button pressed down
  uint32_t BE_queueSize;           // Queue size limit

  uint32_t BE_doubleClickTime;     // Time between double clicks for this button
  uint32_t BE_pressTime;           // Time to detect a held button for this button

  // Internal state machine states
  enum ButtonState : uint8_t { BS_IDLE = 0, BS_CLICKED1, BS_RELEASED1, BS_COOLDOWN };
  ButtonState BE_state;

  uint32_t BE_timer;               // Timer watching the clicking times
  uint16_t BE_keyState;            // Shift register to hold sampled button states
  uint32_t BE_stateTimer;          // Timer to maintain polling interval
  queue<ButtonEvent> BE_eventList; // Queue of events
};

#endif
