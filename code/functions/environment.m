function [distance, ang2int, head_diff] = environment(xo,xi)
%ENVIRONMENT compute inputs to NN from plant outputs
% ****  Inputs ****
% - xo: outputs (states) of ownship
% - xi: outputs (states) of intruder
% **** Outputs ****
% - distance: 2-D distance between intruder and ownship
% - head_diff: heading angle difference of ownship and intruder
% - ang2int: difference between ownship heading and angle to intruder 

distance = sqrt((xo(1)-xi(1))^2 + (xo(2)-xi(2))^2);
head_diff = xi(3) - xo(3);
ang2int = atan2((xi(2)-xo(2)),(xi(1)-xo(1))) - xo(3);
head_diff = set_angleRange(head_diff);
ang2int = set_angleRange(ang2int);

end

