%% Startup Script to pull things in from the Workspace
home = pwd;
addpath(strcat(home, '/model'));
addpath(strcat(home, '/magnetic_field'));
addpath(strcat(home, '/controller'));

%Mass Moment of Inertia
I = MMOI;

%Intilize State Variable (Quaternions and then rates)
X_0 = initialize();

%Magnetic Field
b_field = magnetic_field();
