import processing.sound.*;
import signal.library.*;

AudioIn in;
FFT fft;
int bands = 4;
float[] spectrum = new float[bands];

int mode = 1;

ArrayList<Path> paths = new ArrayList();

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

  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  in.start();
  fft.input(in);
  
  nodes = new Nodes( gridSize, gridSize, 2 /*minNumRays*/, 100 /*maxNumRays*/);
  
}

void draw() {
  
  surface.setTitle(int(frameRate) + " fps");
  fft.analyze(spectrum);
  
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
    paths.clear();
    // TODO call the stuff kill method
  }
  println(key);
}


void mousePressed() {

  drawing = true;
println(mode);
  switch( mode ) {

    // Paths
    case 2:
      print('p');
      paths.add( new Path() );
      paths.get( paths.size() - 1 ).addParticle( mouseX, mouseY, random( 2, 5 ), 0 );

      break;

  }
}

void mouseReleased() {
  drawing = false;
}