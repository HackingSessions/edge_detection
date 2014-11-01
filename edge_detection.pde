import processing.video.*;

// Capture cam;
Capture cam;
float threshhold=10;

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

PImage edgeDetectget(PImage src){
  int r,g,b;
  PImage result = createImage(src.width,src.height,RGB);
  for (int x = 0; x< src.width;x++) {
    for (int y=0; y< src.height;y++) {
      float src_brightness = brightness(src.get(x,y));
      float diff = abs(src_brightness - brightness(src.get(x-1,y)))+
        abs(src_brightness - brightness(src.get(x+1,y)))+
        abs(src_brightness - brightness(src.get(x,y+1)))+
        abs(src_brightness - brightness(src.get(x,y-1)));
      if (diff/4 > threshhold) {
        result.set(x,y,color(0,0,0));
      }      else {
        result.set(x,y,color(255,255,255));
      }
        
    }
  }
  return result;
}


PImage edgeDetectarray(PImage src){
  int r,g,b;

  PImage result=createImage(src.width,src.height,RGB);
  src.loadPixels();
  int w = src.width;
  int h = src.height;
  float diff,br;
  color[][] vals = new color[src.width][src.height];

  for (int x=0;x<w;x++) {
    for   (int y =  0; y < h-1 ; y++ ){
      if (x>0 && x < w && y > 0 && y < h) {
        
        br = brightness(src.get(x,y));
        diff = abs(br - brightness(src.pixels[(y+1)*w+x]))+
          abs(br - brightness(src.pixels[(y-1)*w+x]))+
          abs(br - brightness(src.pixels[y*w+x+1]))+
          abs(br - brightness(src.pixels[y*w+x-1]));
        diff = diff / 4;
        
        if (diff > threshhold){
          vals[x][y]=color(0,0,0);
        } else {
          vals[x][y]=color(255,255,255);
        }
      }
    }
  }
    for (int x=0;x<w;x++) {
      for (int y =  0; y < h ; y++ ){
        result.set(x,y,vals[x][y]);
      }
    }
  
  return result;
}

void draw() {

  if ( cam.available() == true ) {
    cam.read();
  }
  
  
  PImage r = edgeDetectget(cam);
  image(r, 0, 0);
}


void keyTyped() {
  if (key=='u')
    threshhold = threshhold + 1;
  if (key=='d')
    threshhold = threshhold - 1;
}
