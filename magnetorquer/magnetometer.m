%% Numerical Magnetometer Model
%% Finite difference
%% Returns B-dot relative to the body frame
function b_dot = magnetometer(bb_field_prev, b_field, x)
    
    % transform magnetic field from inertial to body
    q = x(1:4);
    C = trans_matrix(quat2eul(q));
    bb_field = C * b_field;

    % numerical derivative
    % how do I get previous time and bb_field_prev?
    % mabey this will work
    b_dot = (bb_field - bb_field_prev) / (time_2 - time_1);
    % need to get time from somewhere

    bb_field_prev = bb_field;

end
