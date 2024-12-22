### Prerequisites

You will need the FastLED library (compiled for the ESP8266)!

To build the test program I recommend using PlatformIO, but of course the Arduino-IDE will work.

The D6 pin must be connected with the DATA IN line of the LED stripe. The D5 ping will cycle through the test modes when pulled to GND shortly.

Test modes:

1. 2s all LEDs ON, a few set to a different color. Then 2s of OFF before repeating the cycle.

2. LEDs switched on in pairs, leaving two OFF in between

3. All LEDs blue with a yellow dot wandering through in sequence.
