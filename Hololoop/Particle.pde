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

  void display( float audioScale ) {
    
    pushMatrix();
    if ( falling ) {
      position.z -= 50;
    }
    translate( position.x, position.y, position.z );
    rotate( heading );
    
    rect( 0, 0, pWidth + ( amp * audioScale * 1.618 ), pHeight + ( amp * audioScale ) );
    popMatrix();
  }
  
  void fall() {
    falling = true;
  }
  
  boolean isDead() {
     return position.z < -5000;
  }

}