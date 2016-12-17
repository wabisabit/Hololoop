/* HOLOLOOP *

Modes:
1         - Rays
2         - Rectangle paths
3         - Pulses
BACKSPACE - Eraser mode (1 & 2)

r         - Rotation on/off for rays
c         - Color on/off for paths
p         - Psychedelic!!!

.         - Reset

*/

import processing.sound.*;
//import signal.library.*;

AudioIn in;
SoundFile soundfile;

/** Analysis **/
Amplitude rms;
//FFT fft;
//int bands = 4;
//float[] spectrum = new float[bands];
//float bandLow, bandMidLow, bandMidHigh, bandHigh, amplitude;

float scale = 1;
float smooth_factor = 0.5; // 0-1 Lower -> more smoothing
float sum;
float amp, ampSum;
/****************/

int mode = 1;
boolean eraserMode = false;
boolean rotationSwitch = false;
boolean colorSwitch = false;
boolean psychoSwitch = false;

Paths paths;

Nodes nodes;
Pulses pulses;
int gridSize = 100;

boolean drawing = false;

color[] palette1 = { #BBBB88, #CCC68D, #EEDD99, #EEC290, #EEAA88 };
color[] palette2 = { #FF4242, #F4FAD2, #D4EE5E, #E1EDB9, #F0F2EB };
color[] palette3 = { #D1F2A5, #EFFAB4, #FFC48C, #FF9F80, #F56991 };
color[] palette4 = { #CFFFDD, #B4DEC1, #5C5863, #A85163, #FF1F4C };
color[] palette5 = { #B3CC57, #ECF081, #FFBE40, #EF746F, #AB3E5B };
color[] palette6 = { #CC0C39, #E6781E, #C8CF02, #F8FCC1, #1693A7 };
color[] palette7 = { #1693A5, #02AAB0, #00CDAC, #7FFF24, #C3FF68 };

color palettes[][] = { { #BBBB88, #CCC68D, #EEDD99, #EEC290, #EEAA88 },
                       { #FF4242, #F4FAD2, #D4EE5E, #E1EDB9, #F0F2EB },
                       { #D1F2A5, #EFFAB4, #FFC48C, #FF9F80, #F56991 },
                       { #CFFFDD, #B4DEC1, #5C5863, #A85163, #FF1F4C },
                       { #B3CC57, #ECF081, #FFBE40, #EF746F, #AB3E5B },
                       { #CC0C39, #E6781E, #C8CF02, #F8FCC1, #1693A7 },
                       { #1693A5, #02AAB0, #00CDAC, #7FFF24, #C3FF68 } };

color[] currentPalette = palettes[ int( random( palettes.length ) ) ];

void setup() {
  
  hint(DISABLE_OPTIMIZED_STROKE); // To be able to draw rect with fill
  
  /*
  size( 800, 600, P3D );
  /*/
  fullScreen( P3D, 1 );
  //*/
  
  noCursor();
  
  
  //fft = new FFT( this, bands );
  rms = new Amplitude( this );
  in = new AudioIn( this, 0 );
  in.start();
  //*
  //fft.input( in );
  rms.input( in );
  /*/
  soundfile = new SoundFile( this, "/Users/RR/Desktop/Conecta_01.wav" );
  soundfile.loop();
  //fft.input( soundfile );
  rms.input( soundfile );
  //*/
  
  paths = new Paths();
  
  nodes = new Nodes( gridSize, gridSize, 2 /*minNumRays*/, 100 /*maxNumRays*/);
  
  pulses = new Pulses( gridSize, gridSize );
  
}

void draw() {
  
  surface.setTitle(int(frameRate) + " fps");
  
  /** Analysis **/
  /*fft.analyze(spectrum);
  bandLow = spectrum[0];
  bandMidLow = spectrum[1];
  bandMidHigh = spectrum[2];
  bandHigh = spectrum[3];

  amplitude = ( bandLow + bandMidLow + bandMidHigh + bandHigh ) / 4;
  */
  
  // smooth the rms data by smoothing factor
  sum += ( rms.analyze() - sum ) * smooth_factor;  

  // rms.analyze() returns a value between 0 and 1.
  amp= sum * scale;
  ampSum += amp;
  
  /*****************/
  
  background( 0 );
  
  nodes.display();

  if ( mode == 1 ) {
    
    nodes.draw( eraserMode );
    
  }
  
  pulses.display();
  
  if ( mode == 3 ) {
    
    pulses.draw();
    
  }

  paths.update();
  paths.display();


  if ( mode == 2 ) {

    if ( !paths.isEmpty() ) {
      
      paths.getLast().draw();
      
    }
  }
  
  strokeWeight( random( 2 ) );
  
  if ( eraserMode ) {
    stroke( 255, 0, 0 );
  } else {
    stroke( 255 );
  }
  point( mouseX + random ( -5, 5 ), mouseY + random ( -5, 5 ) );
}

void keyPressed() {
  
  if ( Character.isDigit( key ) ) {
    mode = Character.getNumericValue(key);
    println( "mode: " + key );
  }
  
  switch ( key ) {
    case '.':
      nodes.kill();
      paths.kill();
      break;
    case 'r':
      rotationSwitch = !rotationSwitch;
      break;
    case 'c':
      currentPalette = palettes[ int( random( palettes.length ) ) ];
      colorSwitch = !colorSwitch;
      break;
    case 'p':
      psychoSwitch = !psychoSwitch;
      break;
  }
  
  
  if( keyCode == 8 ) {
    eraserMode = !eraserMode;
  }
  //println( eraserMode ? "erasing" : "drawing" );
}


void mousePressed() {

  drawing = true;

  switch( mode ) {
    
    case 1:
      
      
      break;
      
    // Paths
    case 2:
      
      if ( eraserMode ) {
        
        paths.getClosest( new PVector( mouseX, mouseY ) ).kill();
        
      } else {
        
        Path path = paths.add();
        path.addParticle( mouseX, mouseY, random( 1, 5 ), 0 );
        //paths.get( paths.size() - 1 )
      
      }
      
      break;

  }
}

void mouseReleased() {
  drawing = false;
}