class Path {
  
  ArrayList<Particle> particles;
  float audioScale;
  
  Path() {
    particles = new ArrayList<Particle>();
    //acceptAudio = random( 100 ) > 20 ? true : false;
    audioScale = abs( randomGaussian( ) ) * 50;
  }

  void addParticle( float x, float y, float parHeight, float heading ) {
    int parWidth = int( parHeight * 1.618 );
    this.particles.add( new Particle( x, y, parWidth, int( parHeight ), heading ) );
  }

  void draw(  ) {


    if ( drawing && !eraserMode ) {

      Particle lastParticle = this.particles.get( this.particles.size() - 1 );

      if ( exitedParticle( lastParticle ) ) {

        PVector mouseV = new PVector( mouseX, mouseY );
        PVector lastParticleV = new PVector( lastParticle.position.x, lastParticle.position.y );
        float parHeight = noise( this.particles.size() * 0.5 ) * 20;

        PVector newParticleV = PVector.sub( mouseV, lastParticleV );
        float heading = newParticleV.heading();
        newParticleV.setMag( newParticleV.mag() + parHeight * 0.5 );
        newParticleV.add( lastParticleV );

        parHeight += PVector.dist( mouseV, new PVector( pmouseX, pmouseY ) ) * 2;
        addParticle( newParticleV.x, newParticleV.y, parHeight, heading + HALF_PI );
      }
    }
  }
  
  boolean exitedParticle( Particle lastParticle ) {

    return mouseX < lastParticle.position.x - lastParticle.pWidth * 0.5  || 
           mouseX > lastParticle.position.x + lastParticle.pWidth * 0.5  ||
           mouseY < lastParticle.position.y - lastParticle.pHeight * 0.5 ||
           mouseY > lastParticle.position.y + lastParticle.pHeight * 0.5;
  };

  void display() {

    
    fill( 0 );
    stroke( 255 );
    strokeWeight( 2 );
    rectMode( CENTER );
    
    for (Particle particle: particles) {
      particle.display( audioScale );
    }
  }
  
  void kill() {
    for (Particle particle: particles) {
      particle.fall();
    }
  }
}