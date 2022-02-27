%% Turn a 1x3 vector into a skew matrix
function A = vec_to_skew(v)

    a12 = -v(3, 1);
    a13 = v(2, 1);
    a21 = v(3, 1);
    a23 = -v(1, 1);
    a31 = -v(2, 1);
    a32 = v(1, 1);

    A = [0 a12 a13; a21 0 a23; a31 a32 0];

end