%% Convert Euler angles to Euler axis parms
function E = eul_to_ax(c)

    %% fix me!!

    sigma = trace(c);

    phi = acos(0.5 * (sigma - 1));

    if (int8(sigma) ~= 3) && (int8(sigma) ~= -1)
        a_1 = 0.5 * (c(2, 3) - c(3, 2)) / sin(phi);
        a_2 = 0.5 * (c(3, 1) - c(1, 3)) / sin(phi);
        a_3 = 0.5 * (c(1, 2) - c(2, 1)) / sin(phi);
    elseif (int8(sigma) == -1)
        a_1 = ((1 + c(1, 1)) / 2)^(0.5);
        a_2 = ((1 + c(2, 2)) / 2)^(0.5);
        a_3 = ((1 + c(3, 3)) / 2)^(0.5);
    else
        a_1 = 0;
        a_2 = 0;
        a_3 = 0;
    end
    
    E = [a_1, a_2, a_3, phi];
    
end