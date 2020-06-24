function dx = dubindynamics(t,x,u)

v = 807; % ft/s

dx(1,1) = v*cos(x(3)); % x (ft?)
dx(2,1) = v*sin(x(3)); % y (ft?)
dx(3,1) = u;           % heading (deg?)

end

