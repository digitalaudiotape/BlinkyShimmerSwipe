// Dat Phan dat.hy.phan@gmail.com

// BlinkyShimmer - An aesthetically-pleasing random blinking animation for BlinkyTape

// My goal was to capture the shimmering effect of light reflecting
// off the top of waves in a body of water

import processing.serial.*;

import de.voidplus.leapmotion.*;

LeapMotion leap;
int lastId = -1;
float lastX, lastY;


int numberOfLEDs = 60;

int[] touchedPixels = new int[numberOfLEDs];
ColorSwirl swirl;

PVector[] ledBuffer = new PVector[numberOfLEDs];

Shimmer shim;

BlinkyTape bt = null;


void setup()
{
  // initialize leap motion
    leap = new LeapMotion(this);
  
  // instantiate all the LEDs, set their values to 0
  for (int i = 0; i < numberOfLEDs; i++)
  {
     ledBuffer[i] = new PVector(0, 0, 0);
     touchedPixels[i] = 0;
  }
  
  // hard code touchedPixels to all go left in the beginning
//     for (int i = 0; i < numberOfLEDs; i++)
//   {
//      touchedPixels[i] = -300;
//   }
  
  // setup color swirl data
  
  swirl = new ColorSwirl(numberOfLEDs);
 
  
  
  
  
  
  
  
  
  
  
  
  // instantiate a Shimmer object
  shim = new Shimmer(numberOfLEDs);

  // connect to one blinkyboard at COM9 - change to fit your setup
  for (String p : Serial.list())
  {
    if (p.startsWith("COM7"))
    {
      bt = new BlinkyTape(this, p, 60);
    }
  }
}

void draw()
{
  ArrayList<Hand> hands = leap.getHands();
  
if (hands.size() > 0)
  {
    Hand h = hands.get(0);
   // touch corresponding LEDs 
   
   // Wherever hand is, make corresponding LED address go negative if hand is moving to the left, and positive if hand is moving to the right
   
   float handX = h.getPalmPosition().x;
  println("Hand position: " + handX);

// println("Finger position: " + f.getPosition().x);

  int touchedIndex = (int)((handX + 45) * 0.315); // mapping 0-60 leds to -45 to 145 X-coordinate data range from leap motion over 1-meter length of BlinkyTape
  
  // avoid index out of bounds exception
  if (touchedIndex < 0)
     touchedIndex = 0;
  if (touchedIndex > 59)
     touchedIndex = 59;
  
  if (handX > lastX) // if hand is moving to the right, make swirl go right
     touchedPixels[touchedIndex] = 200;
  else if (handX < lastX) // if hand is moving to the left, make swirl go left
     touchedPixels[touchedIndex] = -200; 
   
  lastX = handX;
   
  }

  
  swirl.update();
  shim.update();
  shim.sendToBuffer(ledBuffer, numberOfLEDs); 
  
  
  color c = color(0,0,0);
  if (bt != null)
  {    
    for (int i = 0; i < 60; i++)
    { 
      if (touchedPixels[i] < 0)
      {
        // c gets color for left swirl
        c = swirl.getIndex(i);
        
        //make touched pixels fade back to shimmer
        touchedPixels[i]++;
      }
      else if (touchedPixels[i] > 0)
      {
        // c gets color for right swirl
        c = swirl.getIndex(numberOfLEDs - i);
        
        //make touched pixels fade back to shimmer
        touchedPixels[i]--;
      }
      else
      {
         // else c gets regular shimmer pixel data
           
         c = color(ledBuffer[i].x, ledBuffer[i].y, ledBuffer[i].z);
      }
      bt.pushPixel(c);
      
           
    }
    bt.update();
  }
  
  for (int i = 0; i < numberOfLEDs; i++)
  {
    
  }
  
}
