%% Startup Script to pull things in from the Workspace
home = pwd;
addpath(strcat(home, '/model'));
addpath(strcat(home, '/magnetorquer'));
I = MMOI;
X_0 = initialize();
b_field = magnetic_field();