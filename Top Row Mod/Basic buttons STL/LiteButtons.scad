// Unilluminated upper row buttons on FredBoard

fontSize = 7;           // size of text
textXOffset = 2;        // Distance to move text right
textYOffset = 4;        // Distance to move text up
fontName = "DejaVu Sans Condensed";

// Text strings
textLeft = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
textRight = [ "5", "12", "M1", "M2", "M3", "M4", "M5", "M6", "M7", "U1", "U2", "U3"];

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
textString = slice(textLeft, 0, 5);   // Left half of left row
// textString = slice(textLeft, 6, 11);  // Right half of left row
// textString = slice(textRight, 0, 1);  // 5, 12
// textString = slice(textRight, 2, 8);  // M1-M7
// textString = slice(textRight, 9, 11); // U1-U3

if(do==1) {
  makeButtons(textString, centerT);
} else {
  makeLetters(textString, centerT);
}

// -----------------------------------------------------------------
// internal modules
// -----------------------------------------------------------------

buttonWidth = 15;       // width/depth of a button
buttonHeight = 4;       // height of a button
buttonGap = 7;          // distance between buttons
buttonFrame = 2;        // outer rim around buttons
roundRadius = 1;        // corner rounding radius
$fn = 40;               // rendering steps
frameHeight = 0.52;     // adjust panel height

function slice(list, start, end) = [for (i = [start:end]) list[i]];

module basePlate (buttons) {
  cube([2*buttonFrame+buttons*buttonWidth+(buttons-1)*buttonGap, 2*buttonFrame+buttonWidth, frameHeight]);
}

module textItem (textIs = "new") {
  text(textIs, size = fontSize, font = fontName);
}

module singleButton (textIs = "new", center = false, centerShift = 0) {
  tw = textmetrics(textIs, fontSize, fontName);
  // echo(tw.size.x);
  difference(){
    // base form is a rounded square
    linear_extrude(height=buttonHeight)
      offset(r=+roundRadius)
      offset(delta = -roundRadius) 
      square(size = [buttonWidth, buttonWidth]);
    // ...minus the text 
    translate([buttonWidth/2-tw.size.x/2-centerShift, buttonWidth/2-tw.size.y/2, buttonHeight-1])
      linear_extrude(1.1)
      textItem(textIs);
  }
}

module makeButtons(bv = ["new"], center = false) {
  buttons = len(bv);
  centerShift = 1;
  basePlate(buttons);
  for (i = [0 : buttons - 1]) {
    tw = textmetrics(bv[i], fontSize, fontName);
    // echo(tw.size.x);
    translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight-0.1]) {
      singleButton(bv[i], center, centerShift);
    }
  }
}

module makeLetters(bv = ["new"], center = false) {
  buttons = len(bv);
  centerShift = 1;
  for (i = [0 : buttons - 1]) {
    tw = textmetrics(bv[i], fontSize, fontName);
    // echo(tw.size.x);
    translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight-0.1]) {
      if (center==true) {
        translate([buttonWidth/2-tw.size.x/2-centerShift, buttonWidth/2-tw.size.y/2, buttonHeight-1])
          color("Blue") 
          linear_extrude(1)
          textItem(bv[i]);
      } else {
        translate([textXOffset, textYOffset, buttonHeight-1])
          color("Green") 
          linear_extrude(1)
          textItem(bv[i]);
      }
    }
  }
}