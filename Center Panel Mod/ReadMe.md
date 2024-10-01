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

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/ScreenSet.png" width="66%" alt="Screen on">

The best way I found is to start at a corner and slide a scalpel or razor blade flatly between printed screen and panel.
As soon as you can lift the edge a bit, do so and keep it under tension.
Now proceed with the blade along the edges and deeper into the opening.
Be careful to keep the blade flat to not damage the screen or panel.
Take special care of the flat display flex cable at the top edge.

A gentle stream of hot air may help, but take care to not overheat the materials.

This will take some time!

With this procedure some of the white inserts may already come from the panel. 
This is just fine, we will need to remove them in any case.

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/OrigButtonsIn.png" width="66%" alt="Screen off">

Now use pieces of gaffer tape to dab off the glue residues.
If you repeatedly will press the tape on the glue and quickly lift it off again, the glue will rather stick to the tape than to the panel.

With the same technique you will be able to pull out all the 19 white inserts as well.

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/AllRemoved.png" width="66%" alt="All removed">

#### Lift off the center panel
Now 4 screws are accessible at the corners of the panel.
These are self-cutting plastic screws that may work with the new center panel, but I definitely do not recommend that.
The more you will loosen and fasten these screws, the wider the thread will get - finally not able to hold the screw any more.

I do recomment replacing these screws by a set of proper metric threads and screws.

1. remove the 4 screws
2. gently lift the center panel at one end - not too far! Be sure to keep the flex cables on the bottom side unharmed. The top side needs to be slid down a bit to let the USB and power sockets glide out of the case holes
3. with a hand drill slightly widen the screw holes in the bottom part of the case
4. use a heated soldering iron to set the melt-in threads into these holes. Do not force or overheat it
5. repeat at the other end of the panel to have all four threads replaced.

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/MeltIn2.png" width="66%" alt="Melt-in set">

### The new panel
The panel consists of two different components - the screen plate made from PETG or PLS, and the 19 button insets made from TPU.
You will find the STL files to print the parts right here in the files list.

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/PlateFC.png" width="66%" alt="Screen plate CAD">

The screen plate (here seen from below) is made to slip in the four former screw cutouts at the panel's corners, thus lying flat on the panel.
The display opening has a frame around it to hold an optional color filter or screen protector and openings for the 19 buttons.

<img src="https://github.com/Miq1/FredBoard/blob/main/Center Panel Mod/Buttons.png" width="66%" alt="Buttons CAD">

The buttons will be needed multiply, with the exception of the oval middle menu button.
- arrow left: 2 items
- arrow up: 2 items
- oval center button: 1 item
- rhombic select button: 14 items.

These buttons will be set into the respective openings in the panel, replacing the removed white original parts.

