// Upper row buttons on FredBoard

fontSize = 6;           // size of text
textXOffset = 1;        // Distance to move text right/left in non-center mode
textYOffset = 6;        // Distance to move text up
fontName = "DejaVu Sans:style=Condensed Bold";

fontSize2 = 3;          // size of second text
textXOffset2 = 13;      // horizontal offset of 2nd text
textYOffset2 = 1;       // vertical offset of 2nd text
fontName2 = "DejaVu Sans:style=Condensed Bold Oblique";

// Standard text string vectors - 12 button texts from left to right in each
textLeft = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
textLeftAlt = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"];
textLeft2nd = [" ", "Db", " ", "Eb", " ", " ", "Gb", " ", "Ab", " ", "Bb", " "];
textRight = [ "5", "12", "M1", "M2", "M3", "M4", "M5", "M6", "M7", "U1", "U2", "U3"];
textRightAlt = [ "5", "12", "Io", "Do", "Ph", "Ly", "Mx", "Ae", "Lo", "U1", "U2", "U3"];
textRight2nd = [ "bsp", "sep", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

// 1. Make the button base 
// Set "do = 1;"
// Use the text strings from above to generate a full set or use
// makeButtons(["one", "two", "foo", bar"], ["bla", "bot", "", "<"]) notation
// to generate your own.
//
// The text vectors are mandatory, optional is
//   center = true/false to center the text on a button
//   light = true/false to get lighting-enabled buttons
//
// 2. Make the letters
// Set "do = 0;"
// Same options as above
// *** Be sure to use the very same options as for the makeButtons() call,
// *** else the result will be defective!
//
// Both must be rendered separately and exported as separate STL!

do = 0;
centerT = false;
lightT = true;
secondText = true;

// Common calls - uncomment the one you want and comment out all others!
// Left half of left row
// textString = slice(textLeft, 0, 5);  textString2 = (secondText == true ? slice(textLeft2nd, 0, 5) : []); 

// Right half of left row
// textString = slice(textLeft, 6, 11);  textString2 = [];  

// 5, 12
// textString = slice(textRight, 0, 1); textString2 = (secondText == true ? slice(textRight2nd, 0, 1) : []); 

// M1-M7
// textString = slice(textRight, 2, 8); textString2 = (secondText == true ? slice(textRight2nd, 2, 8) : []); 

// Io, Do, ...
// textString = slice(textRightAlt, 2, 8); textString2 = (secondText == true ? slice(textRight2nd, 2, 8) : []); 

// U1, U2, U3
// textString = slice(textRight, 9, 11); textString2 = (secondText == true ? slice(textRight2nd, 9, 11) : []); 

// Following two are for TEST ONLY!
// textString = textLeft; textString2 = (secondText == true ? textLeft2nd : []);
// textString = textRightAlt; textString2 = (secondText == true ? textRight2nd : []); 

// -----------------------------------------------------------------
// All below is internal - do not change!
// -----------------------------------------------------------------
if(do==1) {
  makeButtons(textString, textString2, centerT, lightT);
} else {
  makeLetters(textString, textString2, centerT, lightT);
}


buttonWidth = 15;       // width/depth of a button
buttonHeight = 3;       // height of a button
buttonGap = 7;          // distance between buttons
buttonFrame = 2;        // outer rim around buttons
roundRadius = 1;        // corner rounding radius
$fn = 40;               // rendering steps
frameHeight = 2;        // adjust panel height
lightWidth = 0.4;       // additional rim for LED mounts
lightCubeWidth = 12;    // width of the extruded light guiding cube
lightTunnel = 1.1;      // radius of the light guiding tunnels
lightDistance = 9.2;    // narrow distance between LEDs
lightHeight = 1.1;      // elevation of light tunnels
tilt = 5;               // angle to tilt the light tunnels towards the center

function slice(list, start, end) = [for (i = [start:end]) list[i]];

module basePlate (buttons, light = false) {
  cube([2*buttonFrame+buttons*buttonWidth+(buttons-1)*buttonGap, 2*buttonFrame+buttonWidth + (light == true ? lightWidth : 0), frameHeight]);
}

module singleButton (textIs = "new", textIs2 = "", center = false, centerShift = 0, light = false) {
  tw = textmetrics(textIs, fontSize, fontName);
  tw2 = textmetrics(textIs2, fontSize2, fontName2);
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
        text(textIs, size = fontSize, font = fontName);
      // ...and second text, if present
      if(textIs2!="") {
        translate([textXOffset2-tw2.size.x, textYOffset2, buttonHeight-1])
          linear_extrude(1.1)
          text(textIs2, size = fontSize2, font = fontName2);
      }
    }
    if (light == true) {
      translate([buttonWidth/2-lightCubeWidth/2, buttonWidth, 0])
        color("Red")
        cube([lightCubeWidth, buttonFrame + lightWidth, 0.6 ]); 
    }
  }
}

module makeButtons(bv = ["new"], bv2 = [], center = false, light = false) {
  buttons = len(bv);
  centerShift = 1;
  difference() {
    union() {
      basePlate(buttons, light);
      for (i = [0 : buttons - 1]) {
        tw = textmetrics(bv[i], fontSize, fontName);
        translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight-0.1])
          singleButton(bv[i], bv2[i], center, centerShift, light);
      }
    }
    if (light == true) {
      for (i = [0 : buttons - 1]) {
        translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, lightHeight ]) {
          translate([buttonWidth/2-lightDistance/2, buttonWidth+buttonFrame+2, 0])
            rotate([-90+tilt, 0, 180+tilt])
            cylinder(r = lightTunnel, h = buttonWidth); 
          translate([buttonWidth/2+lightDistance/2, buttonWidth+buttonFrame+2, 0])
            rotate([-90+tilt, 0, 180-tilt])
            cylinder(r = lightTunnel, h = buttonWidth); 
          translate([buttonWidth/2-lightDistance/2, buttonWidth/3, 0.8])
            rotate([-90, 0, -90])
            cylinder(r = lightTunnel, h = lightDistance); 
        }
      }
    }
  }
}

module makeLetters(bv = ["new"], bv2 = [], center = false, light = false) {
  buttons = len(bv);
  centerShift = 1;
  for (i = [0 : buttons - 1]) {
    tw = textmetrics(bv[i], fontSize, fontName);
    tw2 = textmetrics(bv2[i], fontSize2, fontName2);
    translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight-0.1]) {
      translate(center == true ? [buttonWidth/2-tw.size.x/2-centerShift, textYOffset, buttonHeight-1] : [textXOffset, textYOffset, buttonHeight-1])
        color("Green") 
        linear_extrude(1)
        text(bv[i], size = fontSize, font = fontName);
      // ...and second text, if present
      if(bv2[i]!="") {
        translate([textXOffset2-tw2.size.x, textYOffset2, buttonHeight-1])
          color("Blue")
          linear_extrude(1.1)
          text(bv2[i], size = fontSize2, font = fontName2);
      }
    }
  }
}