import processing.video.*;

// Capture cam;
PImage cam;
float threshhold=10;

void setup() {
  cam = loadImage("macaw.jpg");
  /*  
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
  */
  size( 640, 480 );
}

PImage edgeDetectget(PImage src){
  int r,g,b;
  PImage result = createImage(src.width,src.height,RGB);
  for (int x = 1; x< src.width-1;x++) {
    for (int y=1; y< src.height-1;y++) {
      float src_brightness = brightness(src.get(x,y));
      float diff = abs(src_brightness - brightness(src.get(x-1,y)))+
        abs(src_brightness - brightness(src.get(x+1,y)))+
        abs(src_brightness - brightness(src.get(x,y+1)))+
        abs(src_brightness - brightness(src.get(x,y-1)));
      if (diff/4 > threshhold) {
        result.set(x,y,color(255,255,255));
      }      else {
        result.set(x,y,color(0,0,0));
      }
        
    }
  }
  return result;
}


PImage edgeDetectpixels(PImage src){
  int r,g,b;

  PImage result=createImage(src.width,src.height,RGB);
  result.copy(src,0,0,src.width,src.height,0,0,src.width,src.height);
  
  return result;
}

void draw() {
  /*
  if ( cam.available() == true ) {
    cam.read();
  }
  
  grayscale( cam );
  */
  PImage r = edgeDetectpixels(cam);
  image(r, 0, 0);
}


void keyTyped() {
  if (key=='u')
    threshhold = threshhold + 1;
  if (key=='d')
    threshhold = threshhold - 1;
}
