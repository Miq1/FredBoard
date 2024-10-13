## The Top Row Mod
The choice of colors, font and haptics for the top row buttons (sensors in fact) of the original Irijule design was not optimal as far as I am concerned.
I hardly could read the buttons, especially in darker environments and the cavities were too deep to please me.
So it is time for another mod.

### This mod requires some making skills - you have been warned!
To replace the top row buttons we will need to remove the old panels, print new buttons from TPU on a 3D printer at least.
The planned lighting add-on additionally requires some soldering.

### Bill of materials
We will need:
- a **plastic spatula** to lift off the original panels
- a **hot air** gun or reflow workstation is helpful
- a **3D printer**, ideally an **IDEX** one that is able to print two filaments at a time.
- two contrasting colors of **TPU filament**. 

### Disassembly
First open the case by removing the 4 screws from the bottom side.
Lift off the lid **carefully** by sliding a plastic plectrum or spatula along the long sides of the lid and unhooking the plastic clamps that are holding the lid.

Put the lid aside, laying it flat on its face.
It is fragile, so take care.

The printed panels are glued to the PCB with a double-side adhesive tape.
With hot air (I had 135°C with good results) warm up the panels over the sensor plates.
If you do it slowly and step by step, you will be able to push the spatula between the panel and the PCB.
Gently push the spatula inside, lifting the panel.
If it is too hard to push, rather warm up some more instead of forcing the spatula in.

If you succeeded removing the plates and adhesives you will see the sensor plates:
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/Sensors.png" width="66%" alt="Sensor plates">

### Printing the buttons
The buttons will be printed from TPU filament.
TPU is not the easiest stuff to print, known for its "stringing" tendency that will pull out thin threads of filament when the extruder is moving.
You should know which settings are best for your choice of filament.
The TPU is profiting enormously from being dried, so if you own a filament dryer, use it!

I did not try to use other filaments like PLA or PETG.
Those may work as well, but the button dimensions (``buttonWidth`` in ste OpenSCAD file) may need to be adjusted for it.
The fitting of the buttons is as tight as can be.

The STL files for the buttons with the standard letters as were on the original plates are to be found <a href="https://github.com/Miq1/FredBoard/tree/main/Top%20Row%20Mod/Basic%20buttons%20STL"> in the 'Basic Buttons STL' directory</a>

There are sets of two STLs for each button stripe:
- **C-F**, Letters and Buttons - the left half of the left button row
- **F#-B**, Letters and Buttons - the right half of the left button row
- **5-12**, Letters and Buttons - the two left buttons of the right button row
- **M1-M7**, Letters and Buttons - the middle Mode buttons of the right button row
- **U1-U3**, Letters and Buttons - the right User buttons of the right button row

The 'Letters' files are containing the inlay letters, teh 'Button' files the button stripe.

See below how to use both.

#### Ideal: IDEX printer with 2 TPUs
An IDEX 3D printer is able to print two filaments with two extruders simultaneously.
This is perfect for our buttons to lay in the letters in a different color.
Any other printer able to print more than one filament at a time will be fine, too.

I will describe the procedure for Prusaslicer here - that is the one I am using.
Other slicers will do as well, but you may need to adjust the settings accordingly.

To print a strip you will need to open the Letters and Buttons files of that strip simultaneously.
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/PrusaLoad2.png" width="66%" alt="Load two STL files">

If you do, Prusaslicer will ask you if to combine both STLs into one compound:
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/PrusaUnion.png" width="66%" alt="Combine into compound">

Answer 'YES' to that.
Now the object will be placed on the bed facing up.
On the right hand side, check if the extruders have been assigned correctly to the buttons and letters. 
If not, adjust it now.
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/PrusaColor.png" width="66%" alt="Select colors">

To get a cleaner look, it is better to print the top surface of the buttoms placed on the print bed, so we need to flip the print object over now.
Select the object and in the tool bar on the left select the rotate tool.
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/PrusaRotate.png" width="66%" alt="Rotate object">

Grab the red or green handle and turn the object by exactly 180°.
If you will move the mouse pointer to the inner circle of the rotate tool while holding down the left mouse key, you will be able to rotate in 45° steps.

Next use the tool below the rotate tool in the tool bar to place it on the print bed.

Since we have two TPU filaments in use, we will have to print support structures with these as well.
TPU is sticking on TPU like hell, so we need sensible settings to prevent the supports coming out unseparatable from the button strip.
These are the settings I found to allow an "easy" (well, sort of :winking:) removal of the supports:
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/PrusaOptions.png" width="66%" alt="Support print options">


#### Alternative: single TPU and manual coloring


<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/CompleteLeft.png" width="66%" alt="The Result">
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/CompleteRight.png" width="66%" alt="The Result">
