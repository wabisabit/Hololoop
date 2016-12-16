class Particle {
  
  PVector position; 
  int pHeight, pWidth;
  float heading;
  boolean falling;
  
  Particle( float x, float y, int _pWidth, int _pHeight, float _heading ) {
    position = new PVector( x, y, 0 );
    pHeight = _pHeight;
    pWidth = _pWidth;
    heading = _heading;
    falling = false;
  }

  void display( boolean acceptAudio ) {
    
    float grow = acceptAudio ? ( 200 * amp ) : 0;
    
    pushMatrix();
    if ( falling ) {
      position.z -= 50;
    }
    translate( position.x, position.y, position.z );
    rotate( heading );
    
    rect( 0, 0, pWidth + grow * 1.618, pHeight + grow);
    popMatrix();
  }
  
  void fall() {
    falling = true;
  }
  
  boolean isDead() {
     return position.z < -5000;
  }

}