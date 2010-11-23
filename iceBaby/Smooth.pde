////////////////////////////////////////////////////////
//  smoothing a stream of floats by averaging them
////////////////////////////////////////////////////////

class Smooth
{
  
  int NUM_VALUES = 70;
  float[] values;
  int index = 0;
  float total = 0;
  float average = 0;
  float result;
  
  Smooth()
  {
     
    values = new float[ NUM_VALUES ];
     
    //  initialize values to 0
    for ( int thisValue = 0; thisValue < NUM_VALUES; thisValue++ )
    values[ thisValue ] = 0;
  }
  
  float getAverage( float avg )
  {
    //  substract last reading
    total = total - values[index];
    //  fill in number stream from outside
    values[index] = avg;
    //  add the value to the total
    total = total + values[index];
    //  next position in the array
    index = index + 1;
    //  check if end of array
    if ( index >= NUM_VALUES ) index = 0;
    // calc average
    average = total/NUM_VALUES;
    //  return the average value
    return average;
  }
}
