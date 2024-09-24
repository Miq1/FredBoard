### Why another Mod?
My original Irijule keypad on the right hand side was defective.
Over time one key ceased working.
I opened the keypad to find the cause but did not detect any obvious.
The conductive coating on the keypad foil seems to have lost its conductivity somehow.

From a former project I still had a sheet of Velostat - a conductive plastic film that changes conductivity when pressed, torn or stretched.
So I gave that a try to replace the Irijule stuff.

The result was overwhelming!
The sensitivity was massively improved, the pressure spans a wider range than the original material.
So I converted both keypads to Velastat pads now and would like to share the way it has been done.

```diff
- Note: the sensitivity curve of Velostat makes it tricky to play with velocity and aftertouch.  One can adjust to it, but the planned sensitivity  control in FredBoard will make it easier!
```

The mod is easily reversible!

### Bill of Materials
- A **sheet of Velostat**. The material is also known as Linqstat (from another manufacturer). The Net has sources; [Adafruit are selling it for about 5$ per sheet](https://www.adafruit.com/product/1361), the size is sufficient for modding 3 or 4 boards easily.
- **Carpet tape**. Get a roll of the thinnest double sided tape you can get. Your local hardware shop will have a variety.
- **Textile duct tape**. I used 19mm wide tape from Tesa, but other brands will do. 
- **Some tools**: scalpel, tweezers, scissors, ruler.
- a **plectrum** to open the TB case.
- a **7mm square hand punch tool**. These are sold cheaply in sets from China - see Aliexpress or Amazon for it. 

### Disassembly
#### Opening the TheoryBoard
Put your TB on a flat surface where it is completely supported.
Turn it upside down.
Remove the 4 screws at the four corners.
Turn around the board, safely store the screws for later reassembly.
With a thin plectrum or other plastic tool to open smartphones or tablets carefully slide along the slit between upper and lower part of the case to release the plastic clamps.
**Apply the least force possible, the clamps are likely to break!**
Lift off the upper case and safely place it upside down on a flat surface somewhere - it is fragile.

#### Removing the keypads
Remove the white silicone key mats. 
These have four tiny protruding bolts on the corners that go down into holes in the PCB.
Take care not to tear these off.
Now you will see the original sensor foil in place:

<img src=https://github.com/Miq1/FredBoard/blob/master/Velostat-Mod/GlueSpots.jpg width="66%" alt="Original sensors">

Bla