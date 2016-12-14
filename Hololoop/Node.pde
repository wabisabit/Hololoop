class Node {
  
  PVector position;
  ArrayList<PVector> rays = new ArrayList<PVector>();
  int numRays;
  
  Node( PVector _position, int _numRays ) {
    position = _position;
    numRays = _numRays;
  }

  void addRay( PVector endPoint ) {
 
    rays.add( PVector.sub( endPoint, position ) );
    if ( rays.size() > numRays ) {
      rays.remove(rays.get(0));
    }
  }

  void display() {
    
    for ( PVector rayV : rays ) {
      strokeWeight( 2 + spectrum[0] *100 );
      stroke( 255, 255 - spectrum[1] * 200, 255, 100 );
  
      pushMatrix();
      translate( position.x, position.y );
      line( 0, 0, rayV.x, rayV.y );
      popMatrix();
      
    }
  }
  
  void update() {
    for ( PVector rayV : rays ) {
      //rayV.heading();
      
    }
    
  }

}