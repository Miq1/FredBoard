// Unilluminated upper row buttons on FredBoard

fontSize = 7;           // size of text
textXOffset = 2;        // Distance to move text right/left in non-center mode
textYOffset = 4;        // Distance to move text up
fontName = "DejaVu Sans Condensed";

// Text strings
textLeft = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
textLeftAlt = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"];
textRight = [ "5", "12", "M1", "M2", "M3", "M4", "M5", "M6", "M7", "U1", "U2", "U3"];
textRightAlt = [ "5", "12", "Io", "Do", "Ph", "Ly", "Mx", "Ae", "Lo", "U1", "U2", "U3"];

// 1. Make the button base 
// Use the text strings from above to generate a full set or use
// makeButtons(["one", "two", "foo", bar"]) notation to generate your own.
//
// The text vector is mandatory, optional is
//   center = true/false to center the text on a button

// makeButtons(textLeft, center=true);

 // 2. Make the letters
 // Same options as above
 // *** Be sure to use the very same options as for the makeButtons() call,
 // *** else the result will be defective!
 
// makeLetters(textLeft, center=true);


// Both must be rendered separately and exported as separate STL!
do = 1;
centerT = true;
lightT = true;
 textString = slice(textLeft, 0, 5);   // Left half of left row
// textString = slice(textLeft, 6, 11);  // Right half of left row
// textString = slice(textRight, 0, 1);  // 5, 12
// textString = slice(textRight, 2, 8);  // M1-M7
// textString = slice(textRightAlt, 2, 8);  // Io, Do, ...
// textString = slice(textRight, 9, 11); // U1-U3

if(do==1) {
  makeButtons(textString, centerT, lightT);
} else {
  makeLetters(textString, centerT, lightT);
}

// -----------------------------------------------------------------
// internal modules
// -----------------------------------------------------------------

buttonWidth = 15;       // width/depth of a button
buttonHeight = 3;     // height of a button
buttonGap = 7;          // distance between buttons
buttonFrame = 2;        // outer rim around buttons
roundRadius = 1;        // corner rounding radius
$fn = 40;               // rendering steps
frameHeight = 2;        // adjust panel height
lightWidth = 0.4;       // additional rim for LED mounts
lightCubeWidth = 12;    // width of the extruded light guiding cube
lightTunnel = 1.1;      // radius of the light guiding tunnels
lightDistance = 9.2;    // narrow distance between LEDs
lightHeight = 2;        // elevation of light tunnels
tilt = 8;               // angle to tilt the light tunnels towards the center

function slice(list, start, end) = [for (i = [start:end]) list[i]];

module basePlate (buttons, light = false) {
  cube([2*buttonFrame+buttons*buttonWidth+(buttons-1)*buttonGap, 2*buttonFrame+buttonWidth + (light == true ? lightWidth : 0), frameHeight]);
}

module textItem (textIs = "new") {
  text(textIs, size = fontSize, font = fontName);
}

module singleButton (textIs = "new", center = false, centerShift = 0, light = false) {
  tw = textmetrics(textIs, fontSize, fontName);
  // echo(tw.size.x);
  union() {
    difference(){
      // base form is a rounded square
      linear_extrude(height=buttonHeight)
        offset(r=+roundRadius)
        offset(delta = -roundRadius) 
        square(size = [buttonWidth, buttonWidth]);
      // ...minus the text 
      translate(center == true ? [buttonWidth/2-tw.size.x/2-centerShift, textYOffset, buttonHeight-1] : [textXOffset, textYOffset, buttonHeight-1])
        linear_extrude(1.1)
        textItem(textIs);
    }
    if (light == true) {
      translate([buttonWidth/2-lightCubeWidth/2, buttonWidth, 0])
        cube([lightCubeWidth, buttonFrame + lightWidth, 1.5 ]); 
    }
  }
}

module makeButtons(bv = ["new"], center = false, light = false) {
  buttons = len(bv);
  centerShift = 1;
  difference() {
    union() {
      basePlate(buttons, light);
      for (i = [0 : buttons - 1]) {
        tw = textmetrics(bv[i], fontSize, fontName);
        translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight-0.1])
          singleButton(bv[i], center, centerShift, light);
      }
    }
    if (light == true) {
      for (i = [0 : buttons - 1]) {
        tw = textmetrics(bv[i], fontSize, fontName);
        translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, lightHeight ]) {
          translate([buttonWidth/2-lightDistance/2, buttonWidth+buttonFrame+2, 0])
            rotate([-90, 0, 180+tilt])
            cylinder(r = lightTunnel, h = buttonWidth); 
          translate([buttonWidth/2+lightDistance/2, buttonWidth+buttonFrame+2, 0])
            rotate([-90, 0, 180-tilt])
            cylinder(r = lightTunnel, h = buttonWidth); 
          translate([buttonWidth/2-lightDistance/2, buttonWidth/3, 0])
            rotate([-90, 0, -90])
            cylinder(r = lightTunnel, h = lightDistance); 
//          translate([buttonWidth/2-lightDistance/2, buttonWidth/3, 0])
//            sphere(lightTunnel+0.2); 
//          translate([buttonWidth/2+lightDistance/2, buttonWidth/3, 0])
//            sphere(lightTunnel+0.2); 
        }
      }
    }
  }
}

module makeLetters(bv = ["new"], center = false, light = false) {
  buttons = len(bv);
  centerShift = 1;
  for (i = [0 : buttons - 1]) {
    tw = textmetrics(bv[i], fontSize, fontName);
    // echo(tw.size.x);
    translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight-0.1]) {
      translate(center == true ? [buttonWidth/2-tw.size.x/2-centerShift, textYOffset, buttonHeight-1] : [textXOffset, textYOffset, buttonHeight-1])
        color("Green") 
        linear_extrude(1)
        textItem(bv[i]);
    }
  }
}