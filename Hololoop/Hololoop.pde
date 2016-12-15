/* HOLOLOOP *

Modes:
1         - Rays
2         - Rectangle paths
3         - Circles (WIP)
BACKSPACE - Eraser mode (WIP)
.         - Reset


*/

import processing.sound.*;
import signal.library.*;

AudioIn in;
SoundFile soundfile;
FFT fft;
int bands = 4;
float[] spectrum = new float[bands];
float bandLow, bandMidLow, bandMidHigh, bandHigh, amplitude;

int mode = 1;
boolean eraserMode = false;

ArrayList<Path> paths = new ArrayList();

Nodes nodes;
int gridSize = 100;

boolean drawing = false;

void setup() {
  
  hint(DISABLE_OPTIMIZED_STROKE); // To be able to draw rect with fill
  
  //*
  size( 1536, 698, P3D );
  /*/
  fullScreen( P3D, 1 );
  //*/
  
  noCursor();
  
  
  fft = new FFT( this, bands );
  in = new AudioIn( this, 0 );
  in.start();
  //*
  fft.input( in );
  /*/
  soundfile = new SoundFile( this, "/Users/RR/Desktop/Conecta_01.wav" );
  soundfile.loop();
  fft.input( soundfile );
  //*/
  
  nodes = new Nodes( gridSize, gridSize, 2 /*minNumRays*/, 100 /*maxNumRays*/);
  
}

void draw() {
  
  surface.setTitle(int(frameRate) + " fps");
  
  // Audo Analysis
  fft.analyze(spectrum);
  bandLow = spectrum[0];
  bandMidLow = spectrum[1];
  bandMidHigh = spectrum[2];
  bandHigh = spectrum[3];
  //println(bandHigh);
  amplitude = ( bandLow + bandMidLow + bandMidHigh + bandHigh ) / 4;
  
  background( 0 );
  
  nodes.display();

  if ( mode == 1 ) {
    nodes.draw();
  }
  
  // Draw all paths
  for (Path path: paths) {
    path.display();
  }


  if ( mode == 2 ) {

    if ( paths.size() > 0 ) {
      
      paths.get( paths.size() - 1 ).draw();
      
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
    setup();
    for ( Path path : paths ) {
      path.kill();
    }
    // TODO call the stuff kill method
  }
  
  if( keyCode == 8 ) {
    eraserMode = !eraserMode;
  }
  println( eraserMode ? "erasing" : "drawing" );
}


void mousePressed() {

  drawing = true;

  switch( mode ) {

    // Paths
    case 2:
      println(eraserMode);
      if ( eraserMode ) {
        
        for ( Path path : paths ) {
          path.kill();
        }
        
      } else {
        println( "rect" );
        paths.add( new Path() );
        paths.get( paths.size() - 1 ).addParticle( mouseX, mouseY, random( 2, 5 ), 0 );
      
      }
      
      break;

  }
}

void mouseReleased() {
  drawing = false;
}