// Dat Phan dat.hy.phan@gmail.com

// These are particles that increase in brightness up to random values from 0 to 1,
// before decreasing back down to 0

class ShimmerParticle
{
  private float value;
  private float max;
  private float death; // makes the LED stay dead for a bit after it has cycled up and down
  private float direction;
  private float step_size = 0.02;
  
  ShimmerParticle ()
  {
    value = 0;
    max = (float)Math.random();
    death = max + 0.1 + (0.5 * (float)Math.random());
    direction = 1;
  }
  
  void step()
  {
    // accelerated_step gives each blink a bit more personality, varying the speed
    // of each brightness rise depending on the max brightness
    float accelerated_step = step_size + (0.3 * max * max * max * max); 
    
     if (direction > 0) // if step direction is upward
     {
       if (value < max)
       {
         value = value + step_size;
         value = value + accelerated_step;
       }
       else
       {
         direction = -1;
       }
     }
     else if (direction < 0) // if step direction is downward
     {
       if (value > 0) // if particle is decaying
       {
         death = death - step_size;
         value = value - step_size;         
       }
       else // if particle is dead
       {
         death = death - step_size;
         if (death < 0)
         {
           direction = 1;
           max = (float)Math.random();
           death = max + 0.1 + (0.5 * (float)Math.random());
         }
       }
     }
     
     //error-checking
     if (value > 1)
     {
       value = 1;
     }
     else if (value < 0)
     {
       value = 0;
     }
  }
  
  float getValue()
  {  
    return value; 
  }
  
}
