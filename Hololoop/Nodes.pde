class Nodes {
  
  float nodeWidth, nodeHeight;
  int columns, rows;
  ArrayList<Node> nodes = new ArrayList<Node>();
  boolean dying;
  int deathTime;
  
  Nodes( float nodeWidth, float nodeHeight, int minNumRays, int maxNumRays ) {

    columns = abs( width / int(nodeWidth) );
    rows = abs( height / int(nodeHeight) );    

    for ( int x = 0; x < this.columns; x++ ) {
      for ( int y = 0; y < this.rows; y++ ) {
        
        nodes.add( new Node( new PVector( x * nodeWidth, y * nodeHeight ), int( random( minNumRays, maxNumRays ) ) ) );
      }
    }
    
    dying = false;  
    deathTime = 0;
  }

  Node getNearest( PVector position ) {

    Node nearest = nodes.get(0);

    for ( Node node : nodes ) {
      if ( node.position.dist( position )  < nearest.position.dist( position ) ) {
        nearest = node;
      }
    }

    return nearest;
  }

  void display() {

    for ( Node node : nodes ) {
      node.update();
      node.display();
      if ( dying && frameCount > deathTime ) {
        // TODO remove all rays not just last
        node.removeRay();
        node.kill( false );
        dying = false;
      }
    }
    
    
  }
 

  void draw( boolean eraserMode ) {
    if ( drawing ) {
      PVector mousePosition = new PVector( mouseX, mouseY );
      Node node = getNearest( mousePosition );
      
      if ( eraserMode ) {
        node.removeRay();
      } else {
        node.addRay( mousePosition );
      }
      
    }
  }
  
  void kill() {
    dying = true;
    for ( Node node : nodes ) {
      node.kill( true );
    }
    deathTime = frameCount + 200;
  }
}