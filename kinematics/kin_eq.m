%% Kinematic equations
function q_dot = kin_eq(t, q, omega)

    eta = q(1, 1);
    eps = [q(2, 1); q(3, 1); q(4, 1)];
    eps_skew = vec_to_skew(eps);

    eps_dot = 0.5 * (eps_skew + eta * eye(3, 3)) * omega;
    eta_dot = -0.5 * (eps.' * omega);

    q_dot = [eta_dot; eps_dot(1, 1); eps_dot(2, 1); eps_dot(3, 1)];

end