% Project Monarch
% 17 February 2022
% Author: Shannon Donahue

% Graphical visualization of results of propagator
% Plot and graph attributes of CubeSat

clc; clear all; close all;

% Call main
main

% plot angular velocity about each axis
hold on
plot(time, C(1,:))
plot(time, C(2,:))
plot(time, C(3,:))
title("Time Evolution of Euler Angles")
ylabel("Euler Angle [rad]")
xlabel("Time [sec]")
legend("Theta 1", "Theta 2", "Theta 3")
