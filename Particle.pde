class Particle {
  
  float x, y; 
  int parHeight, parWidth;
  float heading;
  
  Particle( float _x, float _y, int _parWidth, int _parHeight, float _heading ) {
    x = _x;
    y = _y;
    parHeight = _parHeight;
    parWidth = _parWidth;
    heading = _heading;
  }

  void display() {

    pushMatrix();
    translate( x, y );
    rotate( heading );
    rect( 0, 0, parWidth + 200 * spectrum[1], parHeight + 200 * spectrum[1] );
    popMatrix();
  }

}