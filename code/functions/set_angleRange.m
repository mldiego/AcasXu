function ang = set_angleRange(angle)
% Compute angle in interval [-pi,pi)
% ang = angle - floor(angle/(2*pi) + 0.5)*2*pi;
% Compute angle in interval [-pi,pi)
ang = angle - ceil(angle/(2*pi) - 0.5)*2*pi;
end