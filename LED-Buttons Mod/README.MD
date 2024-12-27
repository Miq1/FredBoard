# The LED buttons mod
This modification will replace the top row buttons of the Theoryboard by RGB LED-lit ones the FredBoard firmware is controlling.
Initially the left button row is serving as a reference of the note colors, whereas the right button row will indicate the color of the currently selected root note.

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/NoteReference.png"  width="66%" alt="Example lit board">

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

## Requirements
### Materials
#### Case lid

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/LidParts.png"  width="66%" alt="Materials for the lid">

1. 3D printed components for the plastic lid.
Note that a 3D printer is required that is able to print a 300mm wide and 150mm deep part!
2. 3D printed top row buttons - requirements as described in the "Top Row Mod" instructions (TPU, best with IDEX printer)
3. 3D printed center panel buttons - requirements see the "Center Panel Mod" instructions
4. Screen protector/filter sheets as described in the "Center Panel Mod" as well
5. 4 M3 melt-in threads and 4 matching M3x12 screws.
Cylindrical screw heads advisable.
6. 4 M2 melt-in threads and 4 matching M2x16 screws.

#### Wiring and electronics

<img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/WiringParts.png"  width="66%" alt="Materials for wiring">

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
9. 100+ cm of 3mm wide, 5V, 60 LED/m LED stripe. 
    - Example from aliexpress.com:
    <img src="https://github.com/Miq1/FredBoard/blob/main/LED-Buttons Mod/AELEDstripe.png"  width="66%" alt="Example LED stripe">
