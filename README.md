# Project Monarch
![Image](./logo.png)
This is chrysalis, the official repository for Project Monarch.

A detumbling program for AUSSP's CubeSats.

## Members
- Shannon Donahue
- Justin Brouillette
- Luke Scharck

---

## Getting Started
Project Monarch consist of 3 programs divided amongst 2 brances. The programs are as follows:

1. Main Simulink model
3. Monte Carlo framework
5. Visualization program

### Main Model
Located in the main branch

The main model preforms 2 critical functions:
1. Propagate the equations of motion for an arbitrary cuboid
2. Provide control via magnetorquers

This program models the CubeSat as it rotates as well as implementing a controller. The model itself lives in the "basic_model.slx" file which is a Simulink file. The model can be run by using the start tab in the Simulink tool bar or by executing "pre_processor.m" which will run the model and generate a file of the time history Euler angels.

### Monte Carlo framework
Located in the MonteCarloDev branch

This program uses the main model to preform statistical analysis on the inital conditions. By executing the "milkweed" app located in the "monte_carlo" directory the user will be promoted to enter the requested information.

### Visualization program
Located in the main branch

This program creates a moving picture of the CubeSat as it tumbles and eventually detumbles. By executing the "pre_processor.m" to generate the Euler angles the "randomAngleRotation.m" script can be run to draw the movie to the screen.
