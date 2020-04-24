function dx = dynamics2D(t,x,u)
%Combined dynamics of 2 Dubins airplanes
    v = 807; % ft/s
    % Ownship
    dx(1,1) = v*cos(x(3)); % x (ft)
    dx(2,1) = v*sin(x(3)); % y (ft)
    dx(3,1) = u;           % heading (rad)
    % Intruder
    dx(4,1) = v*cos(x(6)); % x (ft)
    dx(5,1) = v*sin(x(6)); % y (ft)
    dx(6,1) = 0; % Constant heading (rad)
    % nn inputs (environment)
    dx(7,1) = ((x(1)-x(4))*dx(1,1) - (-x(1)+x(4))*dx(4,1) + (x(2)-x(5))*dx(2,1) - (x(2)-x(5))*dx(5,1))/(sqrt((x(4)-x(1))^2+(x(5)-x(2))^2)); % distance (ft)
    dx(8,1) = (2*(dx(5,1)-dx(2,1)) + (2*(x(5)-x(2))*(dx(1,1)-dx(4,1)-dx(7,1)))/(x(4)-x(1)+x(7)))/((x(4)-x(1)+x(7))*((1+(x(5)-x(2))^2)/(x(4)-x(1)+x(7))^2)); % theta (rad)
    dx(9,1) = dx(6,1) - dx(3,1); % psi (rad)
end

