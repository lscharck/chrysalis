%% Equations of motion
function [X_dot] = EOMS(t, X, Ix, Iy, Iz)

    X_dot = zeros(7,1); % go away. No

    %% Kinematics
    q = X(1:4, 1) / norm(X(1:4, 1));
    
    eta = q(1, 1);
    eps = [q(2, 1); q(3, 1); q(4, 1)];
    eps_skew = vec_to_skew(eps);

    eta_dot = -0.5 * (eps.' * X(5:7, 1));
    eps_dot = 0.5 * (eps_skew + eta * eye(3, 3)) * X(5:7, 1);

    X_dot(1, 1) = eta_dot;
    X_dot(2, 1) = eps_dot(1, 1);
    X_dot(3, 1) = eps_dot(2, 1);
    X_dot(4, 1) = eps_dot(3, 1);

    %% Dynamics - no torque symmetric body
    X_dot(5) = (Iy - Iz) *  X(6) * X(7) / Ix; 
    X_dot(6) = (Iz - Ix) *  X(5) * X(7) / Iy;
    X_dot(7) = (Ix - Iy) *  X(5) * X(6) / Iz;

end