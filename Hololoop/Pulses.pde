class Pulses {
  
  float pulseWidth, pulseHeight;
  int columns, rows;
  ArrayList<Pulse> pulses = new ArrayList<Pulse>();

  
  Pulses( float pulseWidth, float pulseHeight ) {

    columns = abs( width / int(pulseWidth) );
    rows = abs( height / int(pulseHeight) );    

    for ( int x = 0; x < this.columns; x++ ) {
      for ( int y = 0; y < this.rows; y++ ) {
        
        pulses.add( new Pulse( new PVector( x * pulseWidth + pulseWidth / 2, y * pulseHeight + pulseHeight / 2 ), int( random( 1, 15 ) ) ) );
        
      }
    } 
  }

  Pulse getNearest( PVector position ) {

    Pulse nearest = pulses.get(0);

    for ( Pulse pulse : pulses ) {
      if ( pulse.position.dist( position )  < nearest.position.dist( position ) ) {
        nearest = pulse;
      }
    }

    return nearest;
  }

  void display() {

    for ( Pulse pulse : pulses ) {
      
      pulse.update();
      pulse.display();
      
    } 
  }
 

  void draw() {
    
    if ( drawing ) {
      
      PVector mousePosition = new PVector( mouseX, mouseY );
      Pulse pulse = getNearest( mousePosition );
    
      pulse.draw();
    }
    
  }
}