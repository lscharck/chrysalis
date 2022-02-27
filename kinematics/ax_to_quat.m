%% Convert Euler axis / angle variables to quaternions
%% Returns q as [x y z w] w is scalar part
function q = ax_to_quat(E)

    eps = E(1, 1:3) * sin(E(1, 4) / 2);
    eta = cos(E(1, 4) / 2);
    q = [eps, eta];

end