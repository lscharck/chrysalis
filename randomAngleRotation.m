close all
clear all
clc

M = load('eulers');
M = M.eul;
% save as matlab variable

%% Define cube
H=[-10 10 -10 10 -10 10 -10 10; -5 -5 5 5 -5 -5 5 5; -17.025 -17.025 -17.025 -17.025 17.025 17.025 17.025 17.025]; % Vertices of the 6U cubesat in cm
S=[1 2 4 3; 1 2 6 5; 1 3 7 5; 3 4 8 7; 2 4 8 6; 5 6 8 7]; % Surfaces of the cube
% 1 = z
% 2 = y
% 3 = x
%% Plot of rotation cube
figure(1)
[X,Y,Z] = meshgrid(-20:5:20,-20:5:20,-20:5:20);
U = abs(X);
V = 0*Y;
for i = 1:length(M)
    %x = M(i,4)
    %t = x + 1
    %if t = i
    
    Rx = [1 0 0 ; 0 cos(M(i,1)) -sin(M(i,1)) ; 0 sin(M(i,1)) cos(M(i,1))] ; % Rotation matrix for rotation along x-axis
    Ry = [cos(M(i,2)) 0 sin(M(i,2)) ; 0 1 0 ; -sin(M(i,2)) 0 cos(M(i,2))] ; % Rotation matrix for rotation along y-axis
    Rz = [cos(M(i,3)) -sin(M(i,3)) 0 ; sin(M(i,3)) cos(M(i,3)) 0 ; 0 0 1]; % Rotation matrix for rotation along z-axis
    
    T = Rx * Ry * Rz; % Combine rotation into one 
    
    % Only for very small angles
    %Rx = [1 0 0 ; 0 M(i,1) M(i,1) ; 0 M(i,1) M(i,1)] ; % Rotation matrix for rotation along x-axis
    %Ry = [M(i,2) 0 M(i,2) ; 0 1 0 ; M(i,2) 0 M(i,2)] ; % Rotation matrix for rotation along y-axis
    %Rz = [M(i,3) M(i,3) 0 ; M(i,3) M(i,3) 0 ; 0 0 1];  % Rotation matrix for rotation along z-axis
    
    
    %% Rotate the vertices 
    H1 = zeros(size(H));

    for j = 1:size(H,2)
        H1(:,j) = T*H(:,j); % Make changes to rotate transformation matrix
    end
    
    for k=1:size(S,1)  
        xlabel('X-Axis'); 
        ylabel('Y-Axis');
        zlabel('Z-Axis'); 
        
        Si=S(k,:); 
        
        if k == 1 || k == 2 || k == 3
            if M(i, 7 - k) == 1
                color_id = 'g';
            elseif M(i, 7 - k) == -1
                color_id = 'r';
            else
                color_id = 'b';
            end
        else
            color_id = 'b';
        end

        fill3(H1(1,Si),H1(2,Si),H1(3,Si),color_id,'facealpha',0.6)

        axis([-40 40 -40 40 -40 40])
        hold on
    end
    quiver3(X,Y,Z,U,V,V)
    drawnow
    pause(0.25)
    %filename = ['./VideoViz/Donahue', num2str(i, '%015.0f')]; 
    %print(gcf, filename, '-r300', '-dpng')
    hold off
end
