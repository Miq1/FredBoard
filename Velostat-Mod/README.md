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

#### Update: 3M adhesive
While the mod as described was working nicely, I had a special issue with it. 
When modding I tend to open and close the Theoryboard multiple times.
Since the key pads are made from silicone, the adhesive tape I used to fix the Velostat on it is not sticking strongly, rather like a Post-It&trade; note.
Therefore the Velostat bit came off sometimes.

I found a special 3M double adhesive tape to get around that issue.
It unfortunately ius rather expensive but nicely does its job.
The "3M mod update" was added at the end of the page.

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

### Making the sensors
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

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Alignment.jpg width="66%" alt="Piece placed">

Now we have two options to get the material in a better adjusted shape:
- When the board is reassembled, for some time firmly press on each key before using the board. This will bend the material over time to accept the form of the keys. I did this with one side of my board and never was urged to correct anything since.
- Use a heat gun or reflow workstation with moderate temperature (135°C is more than sufficient) to soften the material, then gently nudge it into the right shape. **Be careful not to heat the material too much - Velostat does shrink when heated!**

The heat formed piece will look like this:

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Heated.jpg width="66%" alt="Piece heated">

You can see the white carpet tape shine through now where the Velostat has shrunk a little, but the form is exactly molded to the key shape.

Repeat this for all 96 pieces on both silicone mats.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/AllInPLace.jpg width="66%" alt="All in place">

As you can see, I was not very successful cutting exactle fitting square pieces, but that does not matter at all!

### Adding the bumpers
If used as is, our keypad would work already, but it will generate a lot of unwanted key presses due to the Velostat lying on the sensor surface already and being highly conductive.
So we need to separate it from the sensors by just a little bit.
For that purpose we will apply small bumper plates made from duct tape.

I cut the textile duct tape to small squares of 5x5mm.
These squares are placed on the intersections of the stripes separating the golden sensor surfaces, tilted by 45°.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Bumper.jpg width="66%" alt="Single bumper">

Repeat that for all intersections and add some more bumper pieces to the outer separations as well.
Leave out the 4 corners as there the silicone bolts must snap into the PCB.
Seen in green here (I ran out of black duct tape :grinning:)

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/BumpersComplete.jpg width="66%" alt="All bumpers">

### Reassembly
Put the silicone mats back on the PCB.
Be sure to slide the 4 bolts on the corners into their fixing holes in the PCB.

Now you can do a first test already to see if everything is working.
Plug in your board into your PC and boot it up.
Try out each single key to see if it is working and no other keys are triggered with it.

The pieces of Velostat can be removed easily - if you find a defective one just try with a new one.

If you found everything working, get the upper case and set it back in place.
Remember the fragility of the clamps and use no force to seize it in.
If it is snapped on, turn the board and fasten the 4 corner screws.

#### Mod the Mod
Alain Blanchard had an idea that may be worthwhile considering: to improve the feel of the keys, put some soft silicone under them.
I had some 1mm self-adhesive foamed rubber lying around, so I stamped out 6mm circles and placed these on the duct tape bumpers.
I did not remove the duct tape because I was afraid the glue on the rubber would not be easily removable in case.

This is the result:

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/keapad.gif width="66%" alt="Soft pads">

### 3M tape mod
There is a special 3M double adhesive tape (type 9731) that has one side with a traditional acrylic glue, but the other coated with a special silicone glue.
This tape will stick very good to both the Velostat and the silicone key pads. It is expensive, though: I had to buy a 65m roll of 14mm wide tape for 60+€, knowing I would need only 1.5m in the end. It was worth it for me, you may have to decide yourself.

The tape has two liners, a brownish paper one on the acrylic side, a transparent plastic liner on the silicone side.

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/3Mliner.png width="66%" alt="3M tape">

#### Additional tools used
To make the production of the almost 100 Velostat tiles easier I created some 3D printed tools:

<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/3Mtools.png width="66%" alt="Making tools">

From the left, the grey part is called the "Press" and is used to exactly center a tile on a keypad key. 
The green part ("Cut") is to cut a tile to measure from a stripe of Velostst sandwich and the yellow ("Punch") is used to adjust the length for a commecrial punching tool.

I used this [this 8mm punch from Amazon](https://amzn.eu/d/eW3AJuU), the Punch adjustment part is constructed for it.
You may have to modify it if your punch is different.
The purpose is to have the 8mm hole centered 7mm before the end of the Velostat stripe, so that it will be in the center of a 14mm x 14mm square tile.

#### Making the tiles
The steps are similar to those above, but modified to use the printed tools.
In the end the making of 100 tiles took less than half of the time than I used originally.

1. pull off the brown paper liner from a length of 3M tape and apply it to the Velostat.
Try to avoid any bubbles of air between the materials.

2. cut the stripe from the Velostat sheet, resulting in a 14mm wide sandwich from 3M tape and Velostat. 
The cleaner you will cut, the easier the further processing will be.

3. cut one end of the stripe to be exactly right-angled. 
Push it into the punch tool with the printed guide inserted.
<img src=https://github.com/Miq1/FredBoard/blob/main/Velostat-Mod/Punch.png width="66%" alt="Punching holes">

