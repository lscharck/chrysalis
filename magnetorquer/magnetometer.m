%% Numerical Magnetometer Model
%% Finite difference
%% Returns B-dot relative to the body frame
function output = magnetometer(time_prev, time_current, bb_field_prev, b_field, x)
    
    % transform magnetic field from inertial to body
    q = x(1:4);
    C = trans_matrix(quat2eul(q));
    bb_field = C * b_field;

    % numerical derivative
    % how do I get previous time and bb_field_prev?
    % mabey this will work
    output.b_dot = (bb_field - bb_field_prev) / (time_current - time_prev);
    % need to get time from somewhere

    output.bb_field_prev = bb_field;
    output.time_prev = time_current;
    
    

end
