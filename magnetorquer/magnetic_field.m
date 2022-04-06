%% Generate B-field
function b_field = magnetic_field()
%Could implement some random bit later
%Arbitrary B-field in inertial frame

field_strength = 34000e-9; %
field_direction = [1;0;0];

b_field = field_strength * field_direction;
end