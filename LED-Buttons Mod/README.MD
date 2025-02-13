# The LED buttons mod
This modification will replace the top row buttons of the Theoryboard by RGB LED-lit ones the FredBoard firmware is controlling.
Initially the left button row is serving as a reference of the note colors, whereas the right button row will indicate the color of the currently selected root note.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/NoteReference.png"  width="66%" alt="Example lit board">

## Some remarks before you start - please read!
This mod is a slightly complicated one and has several caveats to consider:

- it will make sense only if you are using the FredBoard firmware that controls it
- it will require some soldering skills as well as the ability to work in very small dimensions
- it will require you to solder on the Theoryboard's main PCB with a risk to damage it
- it will need permanent modifications to the Theoryboard's case - holes being cut into it
- it will cost you about 50 bucks for the materials used - more if you break something...

On the plus side you will gain some benefits:

- A much better visibility of buttons and their functions
- a case lid that is really sturdy, much more than the original
- the ability to choose a color you like
- overall a unique board no one else has

Note that this modification is including both the "Top Row Mod" and the "Center Panel Mod" in modified form.

## Update V1.1
- I modified the STLs for a better fit. All instructions remain valid, just the 3D prints are different.
- I added some pictures of the different lettering on the buttons (center/ragged left, lit/plain, main text only/second text added).

## Requirements
### Materials
#### Case lid

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/LidParts.png"  width="66%" alt="Materials for the lid">

1. 3D printed components for the plastic lid.
Note that a 3D printer is required that is able to print a 300mm wide and 150mm deep part!
2. 3D printed top row buttons - requirements as described in the "Top Row Mod" instructions (TPU, best with IDEX printer)
3. 3D printed center panel buttons - requirements see the "Center Panel Mod" instructions
4. Screen protector/filter sheets as described in the "Center Panel Mod" as well
5. 4 M3 melt-in threads and 4 matching M3x12 screws.
Cylindrical screw heads advisable.
6. 4 M2 melt-in threads and 4 matching M2x16 screws.

#### Wiring and electronics

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/WiringParts.png"  width="66%" alt="Materials for wiring">

1. Crimp contacts for JST XH type connectors
2. JST XH connectors 
    - board connectors (male): 
        - one 6-pin angled 90°
        - one 3-pin angled 90°
        - two 2-pin angled 90°
        - one 3-pin straight
        - one 2-pin straight
    - cable connectors (female)
        - two 3-pin
        - three 2-pin
        - one 6-pin
3. 3D printed PCB holders and cable clamps
4. some angled pin headers
5. a 470µF, 16V electrolytic capacitor
6. 20cm female/female Dupont patch wire
7. 2 2x8cm PCB universal prototype boards
8. 60+ cm of 2mm diameter PMMA fiber ("side glow")
9. 100+ cm of 3mm wide, 5V, 60 LED/m WS2812B LED stripe. 2m or more are not that expensive and will help if you break some... 
    - Example from aliexpress.com:
    <img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/AELEDstripe.png"  width="66%" alt="Example LED stripe">
10. 8+ 2.2x4mm self cutting screws
11. Enamelled 0.4mm wire
12. A good quality solder

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/FlatCableCrimp.png"  width="66%" alt="Flat cable and crimp tool">

* a length of AWG 24 flat cable - 5 wires at least
* (a crimp tool suitable for JST XH contacts)

### Tools
* a fine soldering iron or workstation
* a 3D printer capable of printed parts 300x150mm and able to print TPU. IDEX printer preferred for the two-color buttons.
* a multimeter for testing
* (optional) a heat gun or better a reflow workstation (recommended)
* a hot glue gun
* tweezers
* (optional) a Wemos D1 mini or NodeMCU board for testing

## Disassembly
Please refer to the "Center Panel Mod" and "Top Row Mod" instructions for the initial disassembly and removal of the printed original cover sheets on center panel and button rows.

In addition you will need to remove the PCBs. 
The center board is held by 4 screws in the corners of the board.
The two keyboard PCBs have 4 larger screws in their corners and 8 smaller ones on top and bottom of the boards.
Remove all to completely loosen the boards.
Put the screws at a safe place to later find them again...

The left and right keyboard halves are connected to the main board by flex cables.
Be careful not to bend these cables or break them! 

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/FlexConnector.png"  width="66%" alt="Flex cable connector">

These flex cable connectors have a rectangular lock sitting around the flex cable.
To release it, gently pull the lock out of the connector.
It will not detach from it completely, but just move up a few millimeters to unlock the flex cable.
You can pull out the flex cable without force once the lock is released.

I would suggest loosening the flex cables on the main board side only and leave them connected to the keyboard PCBs to not displace or switch them.

Put the keyboard PCBs aside to a safe place.

## The Lid
We will replace the original case lid with a new, 3-part printed one.
It consists of the left and right keyboard sections and a center plate.
You will find the STL files for these parts in the "3D STLs" folder; the files are:

* ``TBLid-LeftKB.stl`` for the left,
* ``TBLid-RightKB.stl`` for the right keyboard halves and
* ``TBLid-Plate.stl`` for the center panel

You may print these parts with any hard filament you like, I recommend using PETG or even ABS for better UV resilience.

Note that lighter colors will tend to let the LEDs shine through. 
I suggest to put some black acrylic paint over the affected areas to reduce the effect:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/LEDfixedCable.png"  width="66%" alt="Areas painted matte black">

Note also that the center panel has two long slits on either side that will match the two rims in the keyboard parts.
With the final assembly we will join all three parts with these.
Do not try to join the parts prematurely (before the LEDs are installed) because the fit is **very** tight and may not be loosened again without breaking it.

Finally insert the melt-in M3 threads into the 4 cylindrical columns (2 each on either lid half).
Be careful not to deform these columns when warming up, they need to fit into the corresponding holes in the lower case tray.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/LidMeltedIn.png"  width="66%" alt="Threads melted in the lid">

## The Buttons
As is described in the "Top Row Mod" and "Center Panel Mod" instructions, print the buttons from TPU filament to keep them flexible. 
Print the center panel buttons in any translucent color you like, as the LEDs beneath it are all white. 
A translucent white TPU is highly recommended for the button bases to let the colored LED light shine through unmodified.

### OpenSCAD Script
In the "3D STLs" folder you will find an OpenSCAD script named ``LitButtons.scad``.
You will need to install the OpenSCAD tool to use it - it is Open Source and can be found at [the OpenSCAD Home page](https://openscad.org/downloads.html).

Be sure to have the Customizer visible in it; it can be displayed with the 'Customizer' entry in the 'Windows' menu.

In the Customizer you will find all modifiable parameters to generate the buttons to your liking:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/OpenSCAD.png"  width="66%" alt="Customizer menu">

``do`` needs to be set to both 'Letters' and 'Buttons' to generate the two respective STL files in a separate run each.

``item`` lets you choose which set of buttons you want to have generated.
Note that the 'Full set' items will require a printer with a print bed at least 270mm wide!
If you have a smaller printer only, I recommend to print the shorter button sets instead.

``centerT`` will have the main text centered on the buttons if the tick mark is set.
The text is left bound else.

``lightT`` should be marked for this mod. 
It will generate the necessary light tunnels etc. on the buttons that are needed for lighting.
If unchecked, buttons for the plain top row mod without LEDs will be generated.

``secondText`` will reduce the main text in size and put a right bound second text below it.
This second text is the alternative note names on the left side and a digit sequence plus 'bsp' and 'sep' on the right side. 
These are used for the FredBoard firmware in certain cases.

The rendered picture in OpenSCAD will show you the resulting objects after you modified any value.

The get a valid STL from this result, you will need to first press the **F6** key to render the objects again in a finer structure, then the **F7** key to save it as a STL.
A recommended file name based on your chosen parameters will be shown in the Console window as indicated above with the red frame.

The LEDs are placed at the sides of the buttons.
To improve the lighting the buttons have two 2mm light channels each in them that will be used to transport the light to the far sides of the buttons as well.
This is achieved by inserting short segments of PMMA fiber into the channels.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/PMMA.png"  width="66%" alt="PMMA and tools">

Push the fiber into the channel as far as possible, the cut it cleanly with a sharp scalpel.
The more even the cut is, the better the light will be passed through.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/PMMAShotIn.png"  width="66%" alt="PMMA pushed in">

Do not yet insert the buttons into the keyboard parts before the LED stripes have been installed.

## The Wiring
We will take all needed signals and power from the main board. 
With one exception all are available on solder points that are easy to connect.
These main board wires will go to a "rail board" tha sits under the main board and will distribute the signals to the LED stripes and the flash button (optional, see below).

The schematics is simple:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/Schematic.png"  width="66%" alt="Wiring schematics">

The connector from the main board has GND, 3V3 and the DATA IN signal for the LED stripes, plus two wires that, when shorted at power up, will set the board into flashing mode.
This is purely optional, if you do not want the flash button extension, leave out the two wires completely - but be sure to connect the other three as are seen in the schematic and wiring.

The capacitor is to stabilize the power supply of the LEDs.
Newer Theoryboards will have the same type of capacitor sitting below the keyboard PCBs (large pads close to the flex cable connector, minus is the upper pad) for the same reason.

The power lines are split into two sets of wires to supply each side independently, whereas the DATA IN line is only directed to the left keyboard'S LED stripe.

The general order of LEDs is from the far left to the far right. The DATA IN signal is guided through a single wire between the left and right stripe running below the center plate.

Keep this in mind! 
If you happen to miss this order at some point, the stripes may not work at all or at least are not lit correctly by the firmware, that is relying on the order described.

You will see that most LED stripes have arrow symbols printed on that will give the direction the stripes' LEDs are ordered. We will need the arrows are strictly pointing to the right.

### Three PCBs
We will build three small PCBs. 
One center "rail board" and two small connector boards to the left and to the right.

I am preferring designs that will allow a separation of components if necessary in the future, so all the PCBs are connected by JST XH type sockets and plugs.
You may solder the wires directly if you prefer, but I strongly advise to at least leave in the 6-pin connector between main board and the rail PCB to be able to restore the Theoryboard to almost its original state if needed.

The rail board has 90° angled JST XH connectors - else it will not fit below the main board any more.
These angled connectors are not to be found in the common sets of JST XH connectors, but must be ordered separately.
The set boxes will have straight connectors only.

**Be sure to always maintain the order of wires GND, 3V3 and DATA IN!**

#### The Rail Board
I took one of the 2x8cm prototype PCBs to set up the rail board.
This PCB will fit neatly into the lower middle compartment of the case tray (after some preparations described further down).

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/RailPCBTop.png"  width="66%" alt="Rail board from top">
<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/RailPCBBottom.png"  width="66%" alt="Rail board from below">

As you can see I used enamelled wire to construct the traces. The capacitor must be placed lying sideways to again fit under the main board.

It is advisable to use the exact same layout to have the connectors accessible when the board is mounted into the case tray.

#### The Connector Boards
The left (3 pins) and right (2 pins) connector boards are very similar.
A plug and a approx. 36cm ribbon cable are the connection to the rail board, whereas the other end of the cable will be soldered to a small PCB with a matching straight JST XH connector on it.
These connectors will accept the plugs from the respective side's LED stripe.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/AllPCBs.png"  width="66%" alt="3 PCBs">

**I cannot emphasize enough to maintain the order of pins!**

I used the 3D printed cable clamps (``CableClamp.stl`` in the "3D STLs" folder) with two of the angled pin headers to secure the ribbon cables against being ripped off.
This may be overly cautious - you may decide to omit that.

I recommend to use a multimeter frequently to make sure all connections are correct and no short has been introduced.

#### Mounting Plates
I like to fix such additions to an existing device with hot glue.
In case you need to remove it again, a hot air gun is sufficient to heat the glue to get it off the ground.
Hot glue is mostly fine, but adhesion may not be the best depending of the material it is applied to.
This is why I designed mounting plates for the three PCBs that have the right dimensions to fit and have a grid structure at the bottom side to nicely be filled and held by the hot glue.

Print files are again in the "3D STLs" folder, named ``PCBsocketLarge.stl``and ``PCBsocketSmall.stl``, respectively.

The mounting plates can be fixed to the PCBs by the tiny 2.2mm screws through their holes in the corners.

### Wiring the Main Board
**This is the point where you may accidentally damage the main board - take utmost care to only solder to the points as described!**

Please see the following picture of the main board for the remarks below it:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/MainBoardCabling.png"  width="66%" alt="Main board wire connections">

A 12cm ribbon cable with 5 wires (3, if you do not want to have the flash mode button) is used to connect to the main board.
It is advisable to crimp the 6-pin JST XH plug before soldering the other ends to the main board to prevent strain on the freshly soldered connections.
On the picture you see my colors used for the different signals:

- red for 3V3
- brown for GND
- orange for DATA IN
- yellow and green for the flash connection

With the exception of DATA IN all wires can be cut to length and soldered to the indicated soldering points.

DATA IN is available only at the indicated pin of the flex cable connector.
With a tiny drop of solder you should be able to fix the DATA IN wire to it.

I like to secure the ribbon cable with two drops of hot glue to the main board.
When routing the cable, avoid the white dots marked with a green circle around it: these are the spots where the support struts from the case tray will touch the main board.
The green vertical line is marking another support structure of the case tray that we will have to open later at exactly the spot where you laid the ribbon cable.

### Modifying the Case Tray
To make room for the wiring and PCBs the case tray needs to be opened at several places.

Note that this is irreversible as you will be forced to remove material from the case tray.

The main modifications have to be made underneath the main board:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/CaseCutouts.png"  width="66%" alt="Cutouts at the case tray">

At the area marked "1" we need to cut a hole to let through the plug from the flash mode button - should you decide to want it.
You can see the (blurry) blot of hot glue where I mounted mine in the back.

The "2" marks the area where the freshly soldered ribbon cable will run under the main board.
The traversal structure needs a 1-2mm opening here to let pass that cable.

"3" and "4" are marking the inner edges of the supporting struts that must make way for our rail board.
These inner edges of the X-shaped struts need to be removed completely, making the struts' profiles to a "T" shape.
The edges have to be removed down to the bottom, making a flat surface there.

I used a Dremel tool with a cutting disc to remove all these pieces.

In addition to the modifications show on the picture we need thin slits in the blocking walls towards the left and right outer walls of the case tray to let pass the ribbon cables leading to the connector boards.

Again I used the Dremel tool to cut small openings - just one disc thickness wide and just as deep as was necessare to get the ribbon cable through.

### Placing the Boards
Now that everything is prepared we can install the three boards.

The rail board should neatly fit into the opening we created between the struts:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/RailPCBinPlace.png"  width="66%" alt="Rail PCB placed">

Note the openings marked with red rectangles.

Now is the time to also melt in the M2 threads into the openings marked green.
These will later accept the M2 screws used to hold everything together in the middle.
Again take care not to deform the the cylindrical columns when warming those with the heated threads.

As an example for both sides see the placement of the left connector board below.
The cables are running through the opened walls, the board is placed immediately adjacent to the outer wall of the case tray.
The connector is on the side pointing outwards - when the keyboard PCBs are back in place there will be a gap leaving the connector accessible.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/LeftPortInPlace.png"  width="66%" alt="Left connector board placed">

(The inner wall next to the board was broken already when I got my Theoryboard...)

All three boards now can be fixed in place with a good portion of hot glue.

## Reassembly of the Case Tray
Now that the lower part of the wiring is inplace, we can put most components back together.

- reconnect the keyboard PCBs to the main board, using the flex cables. 
Be sure to use the correct orientation of cables if you had completely removed those.
The flex cable connectors' locks will fall in place again when pushing these gently towards the boards until you will feel a slight clicking movement.
- put the PCBs back into the case tray.
- use the 8 larger corner screws to fix the keyboard PCBs (4 each)
- **do not fix the main board yet**
- add the 8 bottom screws with smaller heads to additionally fix the keyboard PCBs.
**Leave off the 8 top screws (4 each) as are marked on the picture below**

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/RemoveScrews.png"  width="66%" alt="Screws to leave off">

## The LED stripes
This step is that with the most difficult procedures.
Take your time and act cautiously.

Since the LED stripe has a 60/m measure, meaning 60 LEDS are evenly distributed on one meter of stripe, their distance of 16,667mm is not suitable for the distances our board will need.

The technique used to achieve the distances for the buttons is to loop the stripe between the LEDs proper in different lengths.

The LED stripe not only is really narrow, the LEDs and their connections to the stripe are not very robust.
A single broken connection will render the stripe useless for our purpose.

Thus utmost care must be taken to not bend the stripe too close to the LEDs to prevent them to break off.
The stripe material itself is tolerating some rough treatment, though, so if you need to force a bend, do so at the plain stripe.

As said before, the stripes have a direction, indicated by arrows printed on the stripe.
You need to maintain a direction of left-to-right (if seen from above the Theoryboard) throughout the stripes' installation.
**You will have to install the stripes from the bottom side of the lid parts, so keep in mind the directions will be reversed!**

### Wiring the Stripes
For each stripe we will need 24 LEDs. 
These 24 LEDs must be consecutive on a piece of stripe that is native - no modifications made to it.
I have to explicitly state that as I learned that the vendors seem to join shorter pieces of stripes to form a longer one by soldering them together.
On the picture below the red arrow is pointing to such a soldering point.
We can not use these mended stripes as they will tend to break when bent at the soldered joints.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/Stripe.png"  width="66%" alt="Example stripe">

The green arrow pointing to the left end of the stripe indicates a cut made by me.
I recommend to cut at the beginning of a 3-trace contact area, hence sacrificing the LED before it.
You will benefit from the longer traces when soldering a ribbon cable to it.
Same holds true for the end of the 24 LED segment.

Note also the tiny arrow symbols on the stripe indicating the direction, and the order of signals at the connectors:

* top: GND
* middle: DATA IN
* bottom: +5V - specified voltage, we will be using 3V3

I strongly advise to cut, tin, trim and crimp the cables before soldering these to the LED stripe.
Even if you may lose the work when breaking something afterwards, preparing the cables will protect the stripes from being broken by rough treatment.

#### Leftmost Cable
On the far left side we have a 3-wire ribbon cable that will be plugged into the left JST XH socket and connect to the left end of the stripe on the other end.
A 9-10cm length of ribbon cable will be sufficient to connect to the socket.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/LeftCable.png"  width="66%" alt="Cable for left stripe on left side">

**Note that the DATA IN and 3V3 wires need to be crossed at the connector to maintain the order of the internal wiring!**

Having the prepared cable ready as seen on the picture, first with a hot soldering iron tin the three contact pads on the stripe.
Try not to put excess tin on it to prevent a short that is hard to remove.

Soldering is best to be done with a "third hand" tool fixing the parts to be joined in place.
The connection will not stand any bending or pulling, so try to avoid these movements completely to the end of the work on it.

Next with a swift touch of the iron solder the middle DATA IN wire to the middle pad.
It does not need to be overly fixed, a small unbroken connection will do.

With a multimeter check if you produced a short between any of the three pads before proceeding.
The best way to get rid of a short is to unsolder the wire again, remove most of the tin on the pads and try again.

Next bend the outer wires to their target pads one by one and again with a swift touch fix each on the respective pad.

With the multimeter check for any shorts again.
There must be no connection between any of the pads.

#### Interlude: the Test Sketch
I found it handy to always check if the stripe was working while I was on it.
I wrote a small test sketch running on an ESP8266 MCU that will drive the connected stripe to show some test patterns.
You will find the sketch code in the "Test sketch" directory with a few explanations in the enclosed README.MD file there.

No would be the first sensible point to put it into action to see if the stripe as is will work.

#### Leftmost Cable continued
If the stripe is working, we can fix the connection to further prevent breaks or shorts.
I normally will use a drop of "Pattex Repair Extreme" glue - an acrylic glue that is viscous and will fill the tiny gaps between the ribbon cable and the stripe.
Once that is applied, I additionally will put a short piece of heat shrinking tube over the joint and let it shrink with a heat gun.

The result:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/ConnectionFixed.png"  width="66%" alt="Connection with glue and shrunk tube over it">

If you came here with success, take a break now and let the connection harden for some hours!

#### Left Stripe, Data Pin
Next we will take care of the DATA IN connection that will be located on the far side of the stripe, opposite to the connection we just made.

There we will need the middle pad on the stripe only and solder one angled pin header to it.
The longer leg of that pin header shall point out from the stripe in the direction the LEDs are facing.
In the end the single data wire across the center plate will connect here.

First of all shove another short piece of heat shrinking tube from the far end over the stripe, as you will not be able to do that any more as soon as the pin header is soldered.

Next put a little bit of tin on the middle pad of the connector at the end of the stripe.
Try to not hit the adjacent GND and +5V pads if possible.

Remove the plastic frame from the pin header, so that you get the metal part only. 
With a soldering iron put some tin on the short leg of the header.

If you have a very fine brush and acrylic paint at hand, try to cover the GND and +5V pads with it to provide a minimal isolation,
Do not touch the tinned middle pad with it.

Now with a swift touch of the iron again solder the pin to the stripe pad.

With the multimeter check if there is any short between the pin and GND or +5V.

If all is still working, you may secure the pin on the stripe with the technique as before: put a drop of glue on the joint, shove over the heat shrinking tube and shrink that with a heat gun.

Again the result:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/PinConnectionFix.png"  width="66%" alt="Header pin with glue and shrunk tube over it">

#### Right Stripe, Data Pin
The right LED stripe has to have the single DATA pin on the left hand end that will get the signal from the similar pin on the rightmost end of the left stripe.

Be sure to have the little arrow symbols pointing away from the pin to get the right order of LEDs.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/RightPinFixed.png"  width="66%" alt="Right stripe data pin in place">

#### Right stripe, connector cable
Finally the right end of the right stripe has to get its 2-wire ribbon cable with a 2-pin JST XH plug.

The same techniques are applied here: prepare the ribbon cable including the plug first.
Take care to maintain the order of wires for the socket - GND and 3V3 must not be swapped.
Think thrice before fixing it...
Next tin the two outer pads on the stripe and cover the middle with acrylic paint if you can.
Solder the ribbon cable to the stripe pads, again checking the order of signals.
Finally - after testing the stripe - put some glue on the connection and cover it with a heat shrinking tube.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/RightCableFixed.png"  width="66%" alt="Right stripe ribbon cable in place">

### Inserting the Stripes
Now that the wiring is done, we will insert the stripes into their respective lid halves.
Remember that the left part has the 3-wire ribbon cable leftmost and the pin in the middle, whereas the right part has the 2-wire cable far right and again the DATA pin in the middle.

If you will look at the inner side of the lid parts you will notice a complicated meandering structure at the upper edge.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/LEDchannel.png"  width="66%" alt="Structure to hold the LED stripe">

The structure has segments shaped like a inverted "T" in the bottom row and "bubbles" on top of each T.
The T shapes have two alternating sizes, a narrower T for the spacing between the two LEDs for one button and a wider T for the spacing between two buttons.

You will notice the "bubble" on top of the narrower T always is larger than that on top of the wider T. That is because the bubbles need to hold the excess stripe material and a narrower distance between LEDs results in more stripe to be held.

Starting on one side we will insert the LED stripe in such a way that the LEDs are placed in the gaps between the Ts and the stripe will be looped through the bubbles between the LEDs.

**A word of caution again: the stripe sections immediately to the left and right of a LED must not be bent to prevent a break-off of the LED!**

I found it handy to use a small tweezer to grab and bend the stripe at the right spots in right angles, but gently push it into the structure with a finger only.
If a LED does not yet fit into its gap, gently pull the previous loop in the previous bubble a bit to set it right.
Finally I used a rounded plastic tool to push the stripe at the bent corners deeper into the structure.
At all times I let the stripe connected to the test ESP8266 to immediately notice if I had something broken.
That did happen a couple of times during development - I had to spend about 2 meters of LED stripe until I had finished two complete sets.
I got better over time...

When the stripe is set into the structure, it should look like on the picture below - and still be working.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/StripeSetIn.png"  width="66%" alt="LED stripe inserted">

Finally you can fix the stripe additionally by filling the larger bubbles with hot glue:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/StripeSealed.png"  width="66%" alt="LED stripe fixated">

## Reassembly Part 2
Now you can squeeze the TPU buttons in their holes below the LEDs.
The fit is **very** tight on purpose.
The best way to get the buttons in is to first press the side with the PMMA fibers against the LED row and into the button openings.
Then with some force but carefully try to press the lower side of the buttons in.

After the procedure the buttons must be flush with the LED frame:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/ButtonsFlushing.png"  width="66%" alt="Buttons are even with the LED frame">

Next insert the data wire into the channel on the bottom side of the center panel.
Try to have the ends of even length.
I used a rounded plastic tool to press the cable in.
It will hold without any glue.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/DATAcable.png"  width="66%" alt="DATA wire set into the center panel">

Finally we must join the three parts of the lid.
There are two slits on each side of the center plate where the 2 edges of the keyboard parts must fit in.

The fit is overly tight on purpose, since any 3D printer will have its own tolerances.

With a flat file you will have to remove some material at the areas marked red in the picture below:

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/Pictures/PlateJoin.png"  width="66%" alt="Areas marked to be filed to fit">

Do not overdo - rather file, try, file again etc. until you will get a very precise fit.
depending on your printer you may have to file the inner or outer rims of the slits.
Best try first by holding the center plate in place to find which direction will suit you better.
A perfect fit will hold the parts together without any glue.
This is advantageous if you later decide to have a different center plate or need to repair one part.

If all else fails or if you feel better with it, you of course can put a few drops of acrylic glue (or whatever sticks best to the filament type you chose) on the joints to secure them.

If the parts are neatly connected, plug in the DATA wire on both keyboard sides (as seen for the right keyboard side on the picture above).

## Final Assembly
Place the screen protector/filter on the display and set all center panel buttons into their places.
Now lift the joint lid on the keyboard and connect the two ribbon cables to their sockets.
Gently nudge the lid in place:

- the center panel buttons must glide into their openings in the center plate
- the keypads must fit into the grids
- the clamps at the outer edges of the lid must go into the openings in the case tray
- the 4 corner struts with the melt-in threads must slip into the cylindrical holes of the tray

You may need to wiggle and nudge a lot until all is matching.

Use the 4 M2 screws to fix both center plate and overlapping keyboard halves to their thread down in the tray.

Flip the board over, holding the outer sides of lid and tray pressed together witch your hands.

From the bottom side fasten the 4 M3 screws into their holes in the corners of the tray.

Flip over again - it is done!

Congratulations!