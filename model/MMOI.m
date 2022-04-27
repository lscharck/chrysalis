%Mass Moment of Inertia for Aribtrary 6U Cubesat
function I = MMOI(varargin)
    %Formula from Wiki
    %From CubeSat.org ...
    m = 12; % Assumed Maximum [kg]
    x_dim = .2263; % [m]
    y_dim = .1000; % [m]
    z_dim = .3660; % [m]

    I = (m/12) * diag([(y_dim^2 + z_dim^2),(x_dim^2 + z_dim^2),(x_dim^2 + y_dim^2)]);
    
    %This is a monte carlo call
    if nargin == 1
        %Result of random mc draw
        draw = varargin{1};
        delta_cg = zeros(3,1);
        
        %See Cubesat Spec Sheet for Ranges
        %https://static1.squarespace.com/static/5418c831e4b0fa4ecac1bacd/t/5f24997b6deea10cc52bb016/1596234122437/CDS+REV14+2020-07-31+DRAFT.pdf
        switch length(draw)
            %Just varying one MMOI Tensor element - sliding along y-axis
            case 1
                y_range  = .02;%m
                delta_cg(3) = (-y_range + 2 * (y_range) * draw(1));
            %Checking out all three
            case 3
                ranges = [.045; .02; .07];
                delta_cg = (-ranges + 2 * (ranges) .* draw);
        end 
        
        %Taking the varied c.g. locations and tweaking the MMOI
        delta_I = m * [(delta_cg(2)^2 + delta_cg(3)^2),delta_cg(1)^2+delta_cg(3)^2, delta_cg(1)^2 + delta_cg(2)^2];
        
        for i = 1:3
           I(i,i) = I(i,i) + delta_I(i); 
        end
    end
end