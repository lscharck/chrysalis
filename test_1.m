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

    % set options and propagate the Euler Equations
    options = odeset('AbsTol', 1e-10, 'RelTol', 1e-10);
    [time, state_vec] = ode45(@euler_eqs, tspan, X_0, options);

    % plot angular velocity about each axis
    hold on
    plot(time, state_vec(:,4))
    plot(time, state_vec(:,5))
    plot(time, state_vec(:,6))
    title("Time Evolution of Angular Velocity Vector")
    ylabel("Angular Velocity [rad/s]")
    xlabel("Time [sec]")
    legend("x-axis", "y-axis", "z-axis")
    %print("fig1.png", "-dpng", "-r300")

end