%Mass Moment of Inertia for Aribtrary 6U Cubesat
function I = MMOI()
    %Formula from Wiki
    %From CubeSat.org ...
    m = 12; % Assumed Maximum [kg]
    x_dim = .2263; % [m]
    y_dim = .1000; % [m]
    z_dim = .3660; % [m]

    I = (m/12) * diag([(y_dim^2 + z_dim^2),(x_dim^2 + z_dim^2),(x_dim^2 + y_dim^2)]);

end