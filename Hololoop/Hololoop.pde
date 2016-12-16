/* HOLOLOOP *

Modes:
1         - Rays
2         - Rectangle paths
3         - Circles (WIP)
BACKSPACE - Eraser mode (WIP only paths)
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
float amp;
/****************/

int mode = 1;
boolean eraserMode = false;

Paths paths;

Nodes nodes;
int gridSize = 100;

boolean drawing = false;

void setup() {
  
  hint(DISABLE_OPTIMIZED_STROKE); // To be able to draw rect with fill
  
  /*
  size( 1536, 698, P3D );
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
  
  /*****************/
  
  background( 0 );
  
  nodes.display();

  if ( mode == 1 ) {
    
    nodes.draw( eraserMode );
    
  }

  paths.update();
  paths.display();


  if ( mode == 2 ) {

    if ( !paths.isEmpty() ) {
      
      paths.getLast().draw();
      
    }
  }
  
  strokeWeight( 1 );
  stroke( 255 );
  point( mouseX + random ( -5, 5 ), mouseY + random ( -5, 5 ) );
}

void keyPressed() {
  
  if ( Character.isDigit( key ) ) {
    mode = Character.getNumericValue(key);
    println( "mode: " + key );
  }
  
  if ( key == '.' ) {
    nodes.kill();
    paths.kill();
    //pulses.kill();
  }
  
  if( keyCode == 8 ) {
    eraserMode = !eraserMode;
  }
  println( eraserMode ? "erasing" : "drawing" );
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