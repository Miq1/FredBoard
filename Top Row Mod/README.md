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

The STL files for the buttons with the standard letters as were on the original plates are to be found <a href="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/Basic Buttons STL">in the 'Basic Buttons STL' directory</a>

#### Ideal: IDEX printer with 2 TPUs
An IDEX 3D printer is able to print two filaments with two extruders simultaneously.
This is perfect for our buttons to lay in the letters in a different color.

#### Alternative: single TPU and manual coloring


<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/CompleteLeft.png" width="66%" alt="The Result">
<img src="https://github.com/Miq1/FredBoard/blob/main/Top Row Mod/CompleteRight.png" width="66%" alt="The Result">
