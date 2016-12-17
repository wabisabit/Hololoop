class Node {
  
  PVector position;
  ArrayList<PVector> rays = new ArrayList<PVector>();
  int numRays;
  int rotationDirection;
  float rotationSpeed;
  boolean dying;
  
  Node( PVector _position, int _numRays ) {
    position = _position;
    numRays = _numRays;
    rotationDirection = ( random( 2 ) > 1 ) ? 1 : -1;
    rotationSpeed = random( 0.5 );
    dying = false;
  }

  void addRay( PVector endPoint ) {
 
    rays.add( PVector.sub( endPoint, position ) );
    if ( rays.size() > numRays ) {
      rays.remove( rays.get( 0 ) );
    }
  }

  void display() {
    //print(dying ? "d" : "");
    
    for ( PVector rayV : rays ) {
      
      strokeWeight( 2 );
      stroke( 255, 255, 255, 100 );
  
      pushMatrix();
      translate( position.x, position.y );
      line( 0, 0, rayV.x, rayV.y );
      popMatrix();
      
    }
  }
  
  void update() {
    
    if ( amp > 0.1 && random( 100 ) > 60 ) {
        rotationDirection *= -1;  
    }
    
    for ( PVector rayV : rays ) {
      
      /*
      if ( dying ) {
        rayV.mult( 0.8 );
      }*/
      if ( rotationSwitch ) {
        rayV.rotate( rotationSpeed * rotationDirection / rayV.mag() );
      }
      
      if ( psychoSwitch ) {
        if ( random( 1 ) > 0.9 ) {
          rayV.mult( 1 + amp );
        }
      }
      
    }
  }
  
  void removeRay() {
    
    if ( rays.size() > 0 ) {
      rays.remove( rays.size() - 1 );
    }
    
  }
  
  void removeRays() {
    for ( int i = rays.size() - 1; i >= 0; i-- ) {
      rays.remove( i );
    }
  }
  
  void kill( boolean kill ) {
    dying = kill;
  }

}