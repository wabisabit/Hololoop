class Pulse {
  
  PVector position;
  int numPulses;
  float[] pulseWidths;
  float[] pulseOpacities;
  boolean finished;
  
  
  Pulse( PVector _position, int _numPulses ) {
    
    position = _position;
    
    numPulses = _numPulses;
    
    pulseWidths = new float[ _numPulses ];
    pulseOpacities = new float[ _numPulses ];
    
    finished = true;
  }
  
  void draw() {
    
    if ( finished ) {
      
      finished = false;
      
      for ( int i = 0; i < numPulses; i++ ) {
        pulseWidths[ i ] = 0;
      }
      for ( int i = 0; i < numPulses; i++ ) {
        pulseOpacities[ i ] = random( 255 );
      }
    }
  }
  
  void update() {
   
    if ( !finished ) {
      
      float opacitiesSum = 0;
      
      for ( int i = 0; i < numPulses; i++ ) {
        pulseWidths[ i ] += 0.1 + random( 5 );
        pulseOpacities[ i ] -= 5 - random( 1 );
        opacitiesSum += pulseOpacities[ i ];
      }
      println(opacitiesSum);
      if ( opacitiesSum <= 0) {
        finished = true;
      }
    }
  }
  
  void display() {
    
    if ( !finished ) {
      for ( int i = 0; i < numPulses; i++ ) {
        
        strokeWeight( 5 / ( pulseWidths[ i ] ) );
        stroke( 255, 255, 255, pulseOpacities[ i ] );
        noFill();
        pushMatrix();
        translate( position.x, position.y );
        ellipse( 0, 0, pulseWidths[ i ], pulseWidths[ i ] );
        popMatrix();
      }
    }
  }
}