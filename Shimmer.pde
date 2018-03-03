// Dat Phan dat.hy.phan@gmail.com

// Shimmer keeps track an array of ShimmerParticle objects and maintains an
// internal buffer of the current brightness of each ShimmerParticle object,
// translated from values between 0 and 1 to values between 0 and 254.
//
// The brightness value is applied to all color channels in the internal buffer,
// making all the LEDs white.

class Shimmer
{
  private PVector[] buffer;
  private int buffer_size;
  private ShimmerParticle[] particles;
  private float ledMax = 254.0;
  
  Shimmer (int size)
  { 
    buffer_size = size;
    buffer = new PVector[buffer_size];
    particles = new ShimmerParticle[buffer_size];
  
    // fill out the local buffer and fill the particle array with objects
    for (int i = 0; i < buffer_size; i++)
    {
      buffer[i] = new PVector(0, 0, 0);
      particles[i] = new ShimmerParticle();
    }
  }
  
  void update()
  {
    float brightness;
        
    for (int i = 0; i < buffer_size; i++)
    {
      particles[i].step();
      brightness = particles[i].getValue() * ledMax;
            
      buffer[i].x = brightness;
      buffer[i].y = brightness;
      buffer[i].z = brightness;
    }
  }

  void sendToBuffer(PVector[] tape, int size)
  {
    if (buffer_size == size)
    {
      for (int i = 0; i < size; i++)
      {
        tape[i].x = buffer[i].x;
        tape[i].y = buffer[i].y;
        tape[i].z = buffer[i].z;
      }
    }
  } 
}
