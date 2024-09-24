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

Optional:
- a **cutting machine** to cleanly cut the 96 sensor pieces.
- a **heat gun** or **reflow workstation** to form the sensors.

### Disassembly
#### Opening the TheoryBoard
Put your TB on a flat surface where it is completely supported.
Turn it upside down.
Remove the 4 screws at the four corners.
Turn around the board, safely store the screws for later reassembly.
With a thin plectrum or other plastic tool to open smartphones or tablets carefully slide along the slit between upper and lower part of the case to release the 10+ plastic clamps.
**Apply the least force possible, the clamps are likely to break!**
Lift off the upper case and safely place it upside down on a flat surface somewhere - it is fragile.

#### Removing the keypads
Remove the white silicone key mats. 
These have four tiny protruding bolts on the corners that go down into holes in the PCB.
Take care not to tear these off.
Now you will see the original sensor foil in place:

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/GlueSpots.jpg width="66%" alt="Original sensors">

The red arrows are pointing to the spots where the sensor foil is glued to the PCB.
These glue blobs have to be cut to separate foil and PCB. 
The easiest is to slide a razor or scalpel carefully between both to cut away the glue.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/GluedCorner.jpg width="66%" alt="Glue spot">

*Note:* To revert the mod you will have to glue the sensor foil in exactly the same position.

Lift off the foil, put it in a sleeve and store it safely, lying flat for a potential later reversion of the mod.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/IrijuleFoil.jpg width="66%" alt="Original sensor foil removed">

Now you will see the PCB sensors and center LEDs.
Take care not to scratch or soil the golden sensor surfaces.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Sensors.jpg width="66%" alt="PCB sensors">

#### Preparing the Velostat
The Velostat material needs to be attached to the silicone key mat, one piece for each key.
The pieces must have a hole in the middle to let pass the LED's light.

The key structure in the silicone is hollow in the middle and slightly domed to the sides.
The most important area for the keys to work properly is the rim around the LED hole.
Contact to the sensors is made with this rim first, gradually widening the contact area when pressing a key.

Hence the exactness of the rim is relevant for the function of the keys, the outer area is less critical.

We will cut out squares of Velostat that have a square center hole matching that of the key and are some mm wide to each side.

Since Velostat itself is not adhesive, we need to add the carpet tape to it first.
Cut a length of carpet tape and laminate it as flat as possible to the Velostat sheet - lining up to one edge.
If you got some bubbles left between tape and Velostat, you may try to prick into it with a needle  and try to flat out the bubble.
Be careful: once stuck, the Velostat is no more removable from the tape.

With a scalpel and a ruler or a scissor cut the laminated piece of Velostat/tape from the sheet to get a stripe.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Laminated.jpg width="66%" alt="Laminated with tape">

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Stripe.jpg width="66%" alt="Cut stripe">

#### Cutting the sensor pieces
We will need 96 pieces from our laminated material.
I used these dimensions (note again that the inner 7mm is mandatory!):

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Cutout.png width="66%" alt="Cut dimensions">

I have no cutting machine available, so I cut all the pieces by hand.
First I cut 17mm x 17mm squares with a ruler and a scalpel, as precise as I could manage. 
You will see below that I did not well, but the outer border is less relevant.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/17mm.jpg width="66%" alt="17mm alignment with ruler">

Next I punched out the 7x7mm holes with a hand punch tool and a hammer.
Again I sometimes missed the center a bit, the hole was shifted to the sides by up to 1mm.
Does not matter too much as well...

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Punches.jpg width="66%" alt="Square punch tools">

I used these punch tools. 
The larger one is a 17x17mm square, but I found it easier to cut the squares by hand than punching those out.

#### Applying the material
Now we will peel off the liner paper from the cut out pieces and place on on each key on the silicone mat.
Be sure to align the inner hole as good as possible with the punched hole of the Velostat piece.

The material will not fit perfectly to the keys due to their domed shape.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/StickOn.jpg width="66%" alt="Piece placed">
