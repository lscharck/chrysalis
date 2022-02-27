%% Form rotation matrix c from raw Euler angles z-y-x sequence
%% Needs input order as [psi, theta, phi]
function c = trans_matrix(angles)

    psi = angles(1);
    theta = angles(2);
    phi = angles(3);

    R3 = [cos(psi) sin(psi) 0; -sin(psi) cos(psi) 0; 0 0 1];         % z-axis
    R2 = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)]; % y-axis
    R1 = [1 0 0; 0 cos(phi) sin(phi); 0 -sin(phi) cos(phi)];         % x-axis

    c = (R1 * R2 * R3);

end
