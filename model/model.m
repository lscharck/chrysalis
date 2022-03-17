%% Project Monarch
%% Mar. 1, 2022
%% Author: Luke Scharck

%% Propagation of rotation equations of motion
clc; clear all; close all

% call main
main

% main function, entry point
function main

    %% Define inital conditions and const
    % inital Euler angles in rads z-y-x sequence
    psi = 0;   % z-axis
    theta = 0; % y-axis
    phi = 0;   % x-axis
    inital_euler = [psi, theta, phi]; % row vect for eul2quat

    % inital angular velocity
    t = pi; % time span limit
    R = 1 / t; % z-axis
    Q = 2 / t; % y-axis
    P = 4 / t; % x-axis
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

    %% Propagate EOMS
    tspan = [0 t]; % time span in seconds 
    options = odeset('AbsTol', 1e-10, 'RelTol', 1e-10);
    [time, state_vec] = ode45(@(time, state_vec) EOMS(time, state_vec, Ix, Iy, Iz,0), tspan, X_0, options);

    %% Convert quaternions back to Euler angels
    eul_angles = quat2eul(state_vec(:, 1:4));
    omega = state_vec(:, 5:7);

    %% Calculate inertial angular momentum vector
    L = angular_mom(eul_angles, omega, I);

    %% VisWiz
    % plot angular displacement about each axis
    %plot_disp(time, eul_angles)

    % plot angular velocity about each axis
    plot_vel(time, omega)

    % plot angular momentum about each axis
    %plot_mom(time, L)

end

function plot_disp(time, ang_disp)

    % plot angular displacement about each axis
    hold on
    plot(time, ang_disp(:,3))
    plot(time, ang_disp(:,2))
    plot(time, ang_disp(:,1))
    title("Time Evolution of Angular Displacement Vector")
    ylabel("Angular Displacement [rad]")
    xlabel("Time [sec]")
    legend("x-axis", "y-axis", "z-axis")
    %print("fig1.png", "-dpng", "-r300")

end

function plot_vel(time, ang_vel)

    % plot angular velocity about each axis
    hold on
    plot(time, ang_vel(:,1))
    plot(time, ang_vel(:,2))
    plot(time, ang_vel(:,3))
    title("Time Evolution of Angular Velocity Vector")
    ylabel("Angular Velocity [rad/s]")
    xlabel("Time [sec]")
    legend("x-axis", "y-axis", "z-axis")
    %print("fig2.png", "-dpng", "-r300")

end

function plot_mom(time, ang_mom)

    % plot angular momentum about each axis
    hold on
    plot(time, ang_mom(:,1))
    plot(time, ang_mom(:,2))
    plot(time, ang_mom(:,3))
    title("Time Evolution of Angular Momentum Vector")
    ylabel("Angular Momentum [kg-m^2/s]")
    xlabel("Time [sec]")
    legend("x-axis", "y-axis", "z-axis")
    %print("fig3.png", "-dpng", "-r300")

end