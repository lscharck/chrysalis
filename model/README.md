# Full Model
This is the full model of a rotating body in 3D with constant mass moment of
inertia and no external torques applied.

## Setup
The main function will take 2 inputs: initial angular displacement and initial
angular velocity.
1. Initial angular displacements are expected to be Euler angles in the rotation
   order z-y-x from the inertial frame to the body frame. Units are radians
2. Initial angular velocities are expected to be inertial relative rates in
   radians per second expressed in the body frame. There are 3 rotation rates
   one for each axis x, y, and z.
Internally the propagator will use quaternions. Thus, the first step is to
convert the initial *Euler angles* to quaternions.This is done using the builtin
MATLAB function. The initial angular rates are left untouched.

## Propagation
Propagation is done using the MATLAB ode45. The equations that are propagated
are both the kinematic and dynamic equations. The kinematic equation provides 
the angular displacement and the dynamic equation provides angular velocity.
They are coupled in the sense that the kinematic equations depend on the angular
velocity. The output is the time history of quaternion evolution and angular
velocity evolution. The quaternions are measured with respect to the inertial
frame. The angular velocity is relative to the inertial frame but expressed in
the body frame.
