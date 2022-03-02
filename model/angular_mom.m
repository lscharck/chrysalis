%% Calculate the angular momentum vector at each time step
function L = angular_mom(angles, omega, I)

    L = zeros(length(angles), 3);       % define return array

    for i = 1:length(angles)

        c = trans_matrix(angles(i, :)); % transformation matrix from inertial to body

        L_b = I * omega(i, :).';        % angular momentum in body frame

        L(i, :) = c.' * L_b;            % transform L from body to inertial

    end

end