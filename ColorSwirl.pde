class ColorSwirl
{
//   private PVector[] buffer;
//   private int buffer_size; 
   private int j, f, k;
   private float r, g, b;
   
   ColorSwirl (int size)
   {
//     buffer_size = size;
//     buffer = PVector[buffer_size];
     
     j = 0;
     f = 0;
     k = 0;    
   }
   
   void update()
   {
     j = j + 1;
     f = f + 1;
     k = k + 2;
   }
   
   color getIndex(int i)
   {
     r = 64*(1+sin(i/2.0 + j/4.0       ));
     g = 64*(1+sin(i/1.0 + f/9.0  + 2.1));
     b = 64*(1+sin(i/3.0 + k/14.0 + 4.2));
     
      color c = color(r, g, b);
      
      return c;
   }
}
