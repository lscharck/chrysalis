%Creates transformation matrix from euler parameters
%Inputs 
%eps - vector of epsilon
%eta
%Source: Spacecraft Attitude Dynamics - Hughes

function C = euler_param_transform(eps, eta)
e1 = eps(1);
e2 = eps(2);
e3 = eps(3);

C = zeros(3);
C(1,:) = [1 - 2*(e2 ^ 2 + e3 ^2), 2*(e1*e2 + e3 * eta), 2*(e1*e2 - e2*eta)];
C(2,:) = [2 * (e2*e1 - e3*eta), 1 - 2*(e3^2 + e1^2), 2*(e2*e3 + e1*eta)];
C(3,:) = [2 * (e3*e1 + e2*eta), 2 * (e3*e2 - e1*eta), 1 - 2(e1^2 + e2^2)];
end