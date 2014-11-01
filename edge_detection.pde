import processing.video.*;

Capture cam;

void setup() {
  
  String[] cameras = Capture.list();
  if ( cameras.length == 0 ) {
    println( "There are no available cameras" );
    exit();
  }
  
  //Show Available cameras
  for (int i=0; i < cameras.length; i++) {
    println( cameras[i] );
  }
  
  cam = new Capture( this, cameras[0] );
  cam.start();
  size( 640, 480 );
}

void draw() {
  if ( cam.available() == true ) {
    cam.read();
  }
  
  grayscale( cam );
  image(cam, 0, 0);
}


void grayscale(PImage pic) {
   for(int i=0; i < pic.width; i++) {
    for(int j=0; j < pic.height; j++) {
    
      color c = pic.get(i, j);
      pic.set(i, j, color( (red(c) + blue(c) + green(c)) / 3));
    }
   }
}

