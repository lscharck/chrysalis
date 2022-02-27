%% Project Monarch
%% Jan. 31, 2022
%% Author: Luke Scharck

%% Propagation of Euler's rotation equations
clc; clear all; close all

% call main
main

% main function, entry point
function main

    %% Define inital conditions and const
    % inital Euler angles in rads z-y-x sequence
    theta = pi / 2; % y-axis
    phi = 0;   % x-axis
    psi = 0;   % z-axis
    inital_euler = [psi, theta, phi]; % row vect for eul2quat
    P = 0; % x-axis
    Q = 0; % y-axis
    R = deg2rad(5); % z-axis
    omega = [P; Q; R]; % angular velocity rads/s

    %% Obtain quaternions from Euler angles
    % obtain transformation matrix from inital Euler angles
    %c = trans_matrix(inital_euler); % z-y-x sequence

    % convert transformation matrix to Euler axis
    %eul_axis = eul_to_ax(c);

    % convert transformation matrix to quaternions
    %q = ax_to_quat(eul_axis)

    % using builtin
    q_inital = eul2quat(inital_euler, "ZYX");

    %% Propagate kinematics
    tspan = [0 5]; % time span in seconds 
    options = odeset('AbsTol', 1e-10, 'RelTol', 1e-10);
    [time, state_vec] = ode45(@(time, state_vec) kin_eq(time, state_vec, omega), tspan, q_inital, options);

    %% convert quaternions back to Euler angels
    state_vec = quat2eul(state_vec);

    %% VisWiz

end