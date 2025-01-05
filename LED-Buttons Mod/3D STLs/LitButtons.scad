// Upper row buttons on FredBoard

// Customizer variables
/* {Global] */
// What to render
do = 0; // [0:Letters, 1:Buttons]

// Item to render
item = 1; // [0:C to F, 1:F# to B, 2:5/12, 3:M1 to M7, 4:Io to Lo, 5:U1/U2/U3, 6:Full left set, 7:Full right set, 8:Full alternate right set]

// Centered text?
centerT = false;

// Lit buttons?
lightT = true;

// Second text line?
secondText = true;

/* [Hidden] */

fontSize = secondText == true ? 6 : 7;           // size of text
textXOffset = 0;        // Distance to move text right/left in non-center mode
textYOffset = secondText == true ? 6 : 4;        // Distance to move text up
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

// -----------------------------------------------------------------
// All below is internal - do not change!
// -----------------------------------------------------------------
iVector = [slice(textLeft, 0, 5), slice(textLeft, 6, 11), slice(textRight, 0, 1), slice(textRight, 2, 8), slice(textRightAlt, 2, 8), slice(textRight, 9, 11), textLeft, textRight, textRightAlt];
iVector2 = secondText == true ? [slice(textLeft2nd, 0, 5), slice(textLeft2nd, 6, 11), slice(textRight2nd, 0, 1), slice(textRight2nd, 2, 8), slice(textRight2nd, 2, 8), slice(textRight2nd, 9, 11), textLeft2nd, textRight2nd, textRight2nd] : [];
iOption = ["C_F", "F#_B", "5_12", "M1_M7", "Io_Do", "U123", "FullLeft", "FullRightM1_M7", "FullRightIo_Do"];

textString = iVector[item];
textString2 = iVector2[item];
fileName = concat(do == 0 ? "Letters" : "Buttons", lightT == true ? "Lit" : "Plain", iOption[item], secondText == true ? "2nd" : "", ".stl");

echo("Export file name: ", join(fileName));

if(do==1) {
  render() makeButtons(textString, textString2, centerT, lightT);
} else {
  render() makeLetters(textString, textString2, centerT, lightT);
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

join = function (l,delimiter="") 
  let(s = len(l), d = delimiter,
      jb = function (b,e) let(s = e-b, m = floor(b+s/2)) // join binary
        s > 2 ? str(jb(b,m), jb(m,e)) : s == 2 ? str(l[b],l[b+1]) : l[b],
      jd = function (b,e) let(s = e-b, m = floor(b+s/2))  // join delimiter
        s > 2 ? str(jd(b,m), d, jd(m,e)) : s == 2 ? str(l[b],d,l[b+1]) : l[b])
  s > 0 ? (d=="" ? jb(0,s) : jd(0,s)) : "";

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
        translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight])
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
    translate([buttonFrame+i*(buttonWidth+buttonGap), buttonFrame, frameHeight]) {
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