function dx = combinedDub(t,x,u)
%COMBINEDDUB Combined dynamics of 2 Dubins airplanes
    v = 807; % ft/s
    % Ownship
    dx(1,1) = v*cos(x(3)); % x (ft)
    dx(2,1) = v*sin(x(3)); % y (ft)
    dx(3,1) = u;           % heading (rad)
    % Intruder
    dx(4,1) = v*cos(x(6)); % x (ft)
    dx(5,1) = v*sin(x(6)); % y (ft)
    dx(6,1) = 0; % Constant heading (rad)
end

