%% Project Monarch
%% Jan. 31, 2022
%% Author: Luke Scharck

%% Propagation of Euler's rotation equations
clc; clear all; close all

% call main
main

% main function, entry point
function main

    % time span in seconds
    tspan = [0 60];

    % inital values in rad and rad/s
    % generate random intial rates in range (-5, 5) deg/s
    % X_0 = [phi, theta, psi, P, Q, R]
    init_rates = (pi / 180) * (-5 + (5+5) * rand(3,1));
    X_0 = [0; 0; 0; init_rates];

    I = MMOI;
    Ix = I(1,1);
    Iy = I(2,2);
    Iz = I(3,3);

    % set options and propagate the Euler Equations
    options = odeset('AbsTol', 1e-10, 'RelTol', 1e-10);
    [time, state_vec] = ode45(@(time, state_vec) euler_eqs(time, state_vec, Ix, Iy, Iz), tspan, X_0, options);

    % plot angular displacement about each axis
    %plot_disp(time, state_vec(:,1:3))

    % plot angular velocity about each axis
    plot_vel(time, state_vec(:,4:6))

end

function plot_disp(time, ang_disp)

    % plot angular displacement about each axis
    hold on
    plot(time, ang_disp(:,1))
    plot(time, ang_disp(:,2))
    plot(time, ang_disp(:,3))
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