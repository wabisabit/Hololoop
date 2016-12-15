class Particle {
  
  float x, y, z; 
  int parHeight, parWidth;
  float heading;
  boolean falling;
  
  Particle( float _x, float _y, int _parWidth, int _parHeight, float _heading ) {
    x = _x;
    y = _y;
    z = 0;
    parHeight = _parHeight;
    parWidth = _parWidth;
    heading = _heading;
    falling = false;
  }

  void display( boolean acceptAudio ) {
    
    float grow = acceptAudio ? ( 200 * bandLow ) : 0;
    
    pushMatrix();
    if ( falling ) {
      z -= 50;
    }
    translate( x, y, z );
    rotate( heading );
    
    rect( 0, 0, parWidth + grow, parHeight + grow);
    popMatrix();
  }
  
  void fall() {
    falling = true;
  }
  
  boolean isDead() {
     return z < 7000;
  }

}