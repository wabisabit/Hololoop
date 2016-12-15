class Node {
  
  PVector position;
  ArrayList<PVector> rays = new ArrayList<PVector>();
  int numRays;
  int rotationDirection;
  float rotationSpeed;
  
  Node( PVector _position, int _numRays ) {
    position = _position;
    numRays = _numRays;
    rotationDirection = ( random( 2 ) > 1 ) ? 1 : -1;
    rotationSpeed = random( 0.5 );
  }

  void addRay( PVector endPoint ) {
 
    rays.add( PVector.sub( endPoint, position ) );
    if ( rays.size() > numRays ) {
      rays.remove(rays.get(0));
    }
  }

  void display() {
    
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
    
    if ( bandHigh > 0.1 && random( 100 ) > 60 ) {
        rotationDirection *= -1;  
    }
    
    for ( PVector rayV : rays ) {
      
      rayV.rotate( rotationSpeed * rotationDirection / rayV.mag() );
      
      /* TODO: store original 
      if ( random( 1 ) > 0.99 ) {
        rayV.setMag( bandHigh * 200 );
      }
      */
    }
  }

}