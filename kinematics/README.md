# SEE MODEL
## Kinematics

Code related to rotation kinematics. Please see model for the updated version.

## Define Initial Euler Angels
The initial Euler angles of the body in 3d space will be represented as a 3-2-1
rotation sequence corresponding to a rotation about the z-y-x body axis
respectively. Thus, the angles will be psi-theta-phi in a vector [theta, phi,
psi]. This will represent the initial angular displacement of the body with
respect to the inertial frame.

## Transform Initial Euler Angels to Quaternions
Propagation of the kinematics will be done with quaternions. Thus, the initial
angular displacements need to be transformed to quaternions. [theta, phi, psi]
will become [eps1, eps2, eps3, eta]. MATLAB's builtin function will be used to 
handle this transformation.

## Propagation of Kinematics Equations
With the quaternions, propagate the kinematic equations. These will be a set of
first order linear differential equations. Constant angular velocity omega will
be used. Using a MATLAB ode function the equations will be propagated. The 
state represented by [eps1, eps2, eps3, eta] will be propagated to return 
[eps1, eps2, eps3, eta] at some delta time step later. Resulting output will be
a time series history of the quaternion state vector.

## Return Quaternions to Euler Angles
In order to plot and view the time series history of the angular rotation. The
quaternions must be transformed back to Euler angles. This will be done with a
builtin MATLAB function. The decision to do this at each time step still remains
to be decided.

## Vizwiz handles this part
Plot and visualize the time series history of Euler angles
