clc;
clear all;
close all;

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
    [time, state_vec] = ode45(@(time, state_vec) EOMS(time, state_vec, Ix, Iy, Iz), tspan, X_0, options);

    %% Convert quaternions back to Euler angels
    eul_angles = quat2eul(state_vec(:, 1:4));
    omega = state_vec(:, 5:7);

    %% Calculate inertial angular momentum vector
    L = angular_mom(eul_angles, omega, I);

    %% VisWiz
    % plot angular displacement about each axis
    %plot_disp(time, eul_angles)

    % plot angular velocity about each axis
    %plot_vel(time, omega)

    % plot angular momentum about each axis
    plot_mom(time, L)

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

function plot_3d_cube(theta,varargin) %%theta in radian

H=[0 0.3 0 0.3 0 0.3 0 0.3; 0 0 0.3 0.3 0 0 0.3 0.3; 0 0 0 0 0.3 0.3 0.3 0.3]; %Vertices of the cube
S=[1 2 4 3; 1 2 6 5; 1 3 7 5; 3 4 8 7; 2 4 8 6; 5 6 8 7]; %Surfaces of the cube

figure(1)
hold on
H1 = zeros(size(S,1),4) ;
H2 = zeros(size(S,1),4) ;
H3 = zeros(size(S,1),4) ;
for i=1:size(S,1)    
    Si=S(i,:); 
   fill3(H(1,Si),H(2,Si),H(3,Si),'g','facealpha',0.6)
end
axis equal, axis on, hold off, view(20,10)


hold off
figure(2)

for i = 1:length(th)
    Rx = [1 0 0 ; 0 cos(psi(i)) -sin(psi(i)) ; 0 sin(psi(i)) cos(psi(i))] ; %rotation matrix for rotation along x-axis
    Ry = [cos(theta(i)) 0 sin(theta(i)) ; 0 1 0 ; -sin(theta(i)) 0 cos(theta(i))] ; %rotation matrix for rotation along y-axis
    Rz = [cos(phi(i)) -sin(phi(i)) 0 ; sin(phi(i)) cos(theta(i)) 0 ; 0 0 1];  %rotation matrix for rotation along z-axis
    
    %% Rotate the vertices 
    H1 = zeros(size(H)) ;
    for j = 1:size(H,2)
        H1(:,j) = Rx*H(:,j) ;       %make changes to rotate the particular axis
    end
    for k=1:size(S,1)    
        Si=S(k,:); 
        fill3(H1(1,Si),H1(2,Si),H1(3,Si),'g','facealpha',0.6)
        hold on
    end
    drawnow
    pause(1)
    hold off
end

end
