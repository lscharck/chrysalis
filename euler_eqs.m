function [X_dot] = euler_eqs(t, X_0)

    % Euler's rotation equations for no applied moments and symmetric body

    % get mass moment of inertia for Cubesat
    I = MMOI;
    Ix = I(1,1);
    Iy = I(2,2);
    Iz = I(3,3);

    X_dot = zeros(6,1);

    X_dot(1) = X_0(4); 
    X_dot(2) = X_0(5);
    X_dot(3) = X_0(6);

    X_dot(4) = (Iy - Iz) *  X_0(5) * X_0(6) / Ix; 
    X_dot(5) = (Iz - Ix) *  X_0(6) * X_0(4) / Iy;
    X_dot(6) = (Ix - Iy) *  X_0(4) * X_0(5) / Iz;

end
