## The Center Panel Mod
I always disliked the lack of haptic response from the center panel sensors and found the printed symbols too dark.
With FredBoard the lower buttons are getting new and diverse functions anyway, so the original print has no more meaning mostly.
So I decided to build a new center panel...

### A word on the sensors
The sensors are given as are, despite their shortcomings in some aspects.
Fred is struggling to get around some, but the basic principles will remain the same.

The sensors are based on Infineon Capsense:tm: chips.
These are watching the capacitive changes around 4 sensors per chip.

- the sensors are no buttons or switches, so anything possible with a proper switch (double click, holding etc.) will not work
- the chips will constantly try to adapt to the capacitive environment around the sensors. This can lead to sensors not always reacting
- if one chip is struggling, all sensors attached to that chip will be unresponsive simultaneously
- besides the 19 sensors on the center panel the 2 * 12 sensors in the top row are the same type
- the chips seem to go into a 'sleep mode' after some time. They are woken again by another sensor contact, but that will not be sent as a button press at all times. You may have to push a second time to activate it


<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/AmberIn.png" width="66%" alt="The Result">
