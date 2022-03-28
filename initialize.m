%% Initialize Values for the Model
function X_0 = intialize()
    %% Define inital conditions and const
    % inital Euler angles in rads z-y-x sequence
    psi = 0;   % z-axis
    theta = 0; % y-axis
    phi = 0;   % x-axis
    inital_euler = [psi, theta, phi]; % row vect for eul2quat

    % inital angular velocity
    t = pi; % time span limit
    R = 4; % z-axis
    Q = 0 / t; % y-axis
    P = 0 / t; % x-axis
    omega_initial = [P; Q; R]; % angular velocity rads/s

    % const mass moment of intertia
    I = MMOI;
    Ix = I(1,1);
    Iy = I(2,2);
    Iz = I(3,3);

    %% Obtain quaternions from Euler angles
    % using builtin
    q_initial = eul2quat(inital_euler, "ZYX");

    % state vector is [q, omega]
    % where q is [eta, eps1, eps2, eps3]
    % where omega [R, Q, P]
    X_0 = [q_initial, omega_initial.'];
end