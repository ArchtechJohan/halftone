import processing.pdf.*;
import java.util.Calendar;

PImage img;

void setup() {
  size(1000, 1000); //Must be the same as the image loaded into img
  background(255);
  smooth();
  beginRecord(PDF, timestamp()+".pdf");

  img = loadImage("testpattern.png");

  img.loadPixels();

  processImage(img, width, height, 24);


  img.updatePixels();
  endRecord();
}


void draw() {
}

void processImage(PImage pic, int sizeX, int sizeY, int subsize) {
  for (int y = 0; y < sizeY; y += subsize) {
    for (int x = 0; x < sizeX; x += subsize) {
      processSubimage(pic, sizeX, sizeY, x, y, subsize);
    }
  }
}


void processSubimage(PImage pic, int sizeX, int sizeY, int x_start, int y_start, int subsize) {
  float tot = 0;
  pic.loadPixels();
  int counter = 0;

  if ((x_start > (sizeX-subsize)) && (y_start <= (sizeY-subsize))) {

    for (int y = y_start; y < (y_start+subsize); y++) {

      for (int x = x_start; x < sizeX; x++) {
        counter++;
        tot += (red(pic.pixels[y*sizeX + x])+green(pic.pixels[y*sizeX + x])+blue(pic.pixels[y*sizeX + x]))/3;
      }
    }
  }



  if ((x_start <= (sizeX-subsize)) && (y_start > (sizeY-subsize))) {

    for (int y = y_start; y < sizeY; y++) {

      for (int x = x_start; x < (x_start+subsize); x++) {
        counter++;
        tot += (red(pic.pixels[y*sizeX + x])+green(pic.pixels[y*sizeX + x])+blue(pic.pixels[y*sizeX + x]))/3;
      }
    }
  }



  if ((x_start > (sizeX-subsize)) && (y_start > (sizeY-subsize))) {

    for (int y = y_start; y < sizeY; y++) {

      for (int x = x_start; x < sizeX; x++) {
        counter++;
        tot += (red(pic.pixels[y*sizeX + x])+green(pic.pixels[y*sizeX + x])+blue(pic.pixels[y*sizeX + x]))/3;
      }
    }
  }


  //default case
  if ((x_start <= (sizeX-subsize)) && (y_start <= (sizeY-subsize))) {

    for (int y = y_start; y < (y_start+subsize); y++) {
      for (int x = x_start; x < (x_start+subsize); x++) {
        counter++;
        tot += (red(pic.pixels[y*sizeX + x])+green(pic.pixels[y*sizeX + x])+blue(pic.pixels[y*sizeX + x]))/3;
      }
    }
  }

//Need to check why the second loop in the special cases never is reached
//Also need to count how many pixels are traversed instead of just dividing by subsize*subsize

  if ((tot/counter) >= 0 && (tot/counter) < 32) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, subsize-3, subsize-3);
  }

  if ((tot/counter) >= 32 && (tot/counter) < 64) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.88*subsize, 0.88*subsize);
  }

  if ((tot/counter) >= 64 && (tot/counter) < 96) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.8*subsize, 0.8*subsize);
  }

  if ((tot/counter) >= 96 && (tot/counter) < 128) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.72*subsize, 0.72*subsize);
  }

  if ((tot/counter) >= 128 && (tot/counter) < 160) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.64*subsize, 0.64*subsize);
  }

  if ((tot/counter) >= 160 && (tot/counter) < 192) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.4*subsize, 0.4*subsize);
  }

  if ((tot/counter) >= 192 && (tot/counter) < 224) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.35*subsize, 0.35*subsize);
  }

  if ((tot/counter) >= 224 && (tot/counter) < 250) {
    noStroke();
    fill(0);
    ellipse(x_start + subsize/2, y_start + subsize/2, 0.3*subsize, 0.3*subsize);
  }


  pic.updatePixels();
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}