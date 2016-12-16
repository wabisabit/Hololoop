class Nodes {
  
  float nodeWidth, nodeHeight;
  int columns, rows;
  ArrayList<Node> nodes = new ArrayList<Node>();
  boolean dying;
  int numNodes = 0;
  int _numNodes;

  
  Nodes( float nodeWidth, float nodeHeight, int minNumRays, int maxNumRays ) {

    columns = abs( width / int(nodeWidth) );
    rows = abs( height / int(nodeHeight) );    

    for ( int x = 0; x < this.columns; x++ ) {
      for ( int y = 0; y < this.rows; y++ ) {
        
        nodes.add( new Node( new PVector( x * nodeWidth, y * nodeHeight ), int( random( minNumRays, maxNumRays ) ) ) );
        numNodes++;
      }
    }
    
    dying = false;  
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
      
      if ( dying ) {
        
        node.removeRays();        
          
        node.kill( false );
        
        _numNodes--;
        
        if ( _numNodes == 0 ) {
          dying = false;
        }
      }
      
      node.update();
      node.display();
      
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
    
    _numNodes = numNodes;
    dying = true;
    
    for ( Node node : nodes ) {
      node.kill( true );
    }
  }
}