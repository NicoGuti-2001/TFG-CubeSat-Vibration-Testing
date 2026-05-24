The following archives are the Matlab codes corresponding to each individual vibration test.

MESA was made first, it contains notes with additional information and the process of its creation. 
  -It loads the information from a .mat file, that usually contains this information:
      *Acceleration magnitude of the sensors
      *Time of each sensor
      *Shaker signal
      *Shaker time
      *FRF magnitude for each sensor
      *FRF frecuencies for each sensor
  -The code uses only the acceleration data
  -Once all the data is loaded, it assigns new names to simplify variable´s names
  -Then plots the acceleration of a sensor, and integrates muerically to calculate and plot its velocity and position
  -Then calculates and plots the transfer function of each sensor using 'tfestimate'
  -Finally it gets the maxs. and mins. of the TF 

  TestCubeI & TestCubeP use the same code as MESA, but add a couple of steps:
    -After changing the variable´s names, it creates a new varaible called 'accel' 
      *'accel' is the difference between the acceleration of the sensor placed in one corner of the structure and the adjacent sensor of the table
    -After estimating the Transfer Function of each sensor, it does not plot them
    -It estimates the TF of the 'accel' variables and plots them

    Test_SS is the only code to process information of Sine Sweep tests
    -It loads the data and assigns new names the same way the previuos codes do
    -It calculates and plot accelerations, velocities and positions the same way the previous codes do
    -It gets the max and min of the accelerations of each sensor

