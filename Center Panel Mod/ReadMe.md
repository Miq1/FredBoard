## The Center Panel Mod
I always disliked the lack of haptic response from the center panel sensors and found the printed symbols too dark.
With FredBoard the lower buttons are getting new and diverse functions anyway, so the original print has no more meaning mostly.
So I decided to build a new center panel...

### A word on the sensors
The sensors are given as are, despite their shortcomings in some aspects.
Fred is struggling to get around some, but the basic principles will remain the same.

The sensors are based on Infineon Capsense :tm: chips.
These are watching the capacitive changes around 4 sensors per chip.

- the sensors are no buttons or switches, so anything possible with a proper switch (double click, holding etc.) will not work
- the chips will constantly try to adapt to the capacitive environment around the sensors. This can lead to sensors not always reacting
- if one chip is struggling, all sensors attached to that chip will be unresponsive simultaneously
- besides the 19 sensors on the center panel the 2 * 12 sensors in the top row are the same type
- the chips seem to go into a 'sleep mode' after some time. They are woken again by another sensor contact, but that will not be sent as a button press at all times. You may have to push a second time to activate it

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/AmberIn.png" width="66%" alt="The Result">

### Bill of materials
First you will need some tools:

- gaffer tape
- a plectrum to open the TB case
- scalpel or razor blade
- a ~2.5mm drill
- a 3D printer - ideally able to print both TPU and PETG or PLA
- a soldering iron to melt in the threads

Plus some parts and consumables:

- translucent or white TPU filament
- opaque PETG or PLA filament
- a few drops of silicone adhesive (if you want to fix the color display filter)
- 4 M2 melt-in threads
- 4 M2 x 15mm screws with countersunk heads
- screen protector or color foil

### Disassembly
This will require some patience and carefulness to not damage anything ypou may want to put back later...

#### Open the case
Take off the top case lid by removing the four screws from the bottom side corners and *carefully* unkhooking the plastic clamps that are holding the lid on the inside. 
This can be done by sliding the plectrum all along the slit between lid and bottom case and carefully loosening the clamps one by one.

#### Remove the screen cover
Now we need to remove the printed screen cover from the center panel.
It is glued to the panel proper with a tough glue pasted on the complete surface, leaving out the display only.

img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/ScreenSet.png" width="66%" alt="The Result">

The best way I found is to start at a corner and slide a scalpel or razor blade flatly between printed screen and panel.
As soon as you can lift the edge a bit, do so and keep it under tension.
Now proceed with the blade along the edges and deeper into the opening.
Be careful to keep the blade flat to not damage the screen or panel.

A gentle stream of hot air may help, but take care to not overheat the materials.

This will take some time!

With this procedure some of the white inserts may already come from the panel. 
This is just fine, we will need to remove them in any case.

img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/OrigButtonsIn.png" width="66%" alt="The Result">

