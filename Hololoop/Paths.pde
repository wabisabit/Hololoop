class Paths {

  ArrayList<Path> paths;
  
  Paths() {
    paths = new ArrayList();
  }
  
  boolean isEmpty() {
    return paths.size() == 0;
  }
  
  Path add() {
    Path path = new Path();
    paths.add( path );
    
    println(paths.size());
    return path;
  }
  
  Path getLast() {
    return paths.get( paths.size() - 1 );
  }
  
  void update() {
    for ( int i = paths.size() - 1; i >= 0; i-- ) {
      
      Path path = paths.get(i);
      
      if ( path.particles.get(0).isDead() ) {
        paths.remove( path );
      }
    }
  }
  
  void display() {
    for ( Path path : paths ) {
            
      path.display();

    }
  }
  
  Path getClosest( PVector position ) {
    
    Path closestPath = new Path();
    float shortestDistance = sqrt( width * width + height * height );
    
    for (Path path : paths) {
      
      for ( Particle particle : path.particles ) {
        
        float distance = particle.position.dist( position );
        
        if ( distance < shortestDistance ) {
          shortestDistance = distance;
          closestPath = path;
        }
      }
    }
    
    return closestPath;
  }
  
  void kill() {
    for (Path path : paths) {
      path.kill();
    }
  }
}