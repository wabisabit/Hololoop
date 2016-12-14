class Nodes {
  
  float nodeWidth, nodeHeight;
  int columns, rows;
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  Nodes( float nodeWidth, float nodeHeight, int minNumRays, int maxNumRays ) {

    columns = abs( width / int(nodeWidth) );
    rows = abs( height / int(nodeHeight) );    

    for ( int x = 0; x < this.columns; x++ ) {
      for ( int y = 0; y < this.rows; y++ ) {
        
        nodes.add( new Node( new PVector( x * nodeWidth, y * nodeHeight ), int( random( minNumRays, maxNumRays ) ) ) );
      }
    }

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
      node.display();
    }
  }

  void draw() {
    if (drawing) {
      PVector mousePosition = new PVector( mouseX, mouseY );
      Node node = getNearest( mousePosition );
      node.addRay( mousePosition );
    }
  }
}