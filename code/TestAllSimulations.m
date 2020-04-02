%% Test multiple scenarios with 3 different simulations
clc;clear;close all;
% --- Setup scenarios ---
% Initial states for ownship
own_init = [1400 4300 0.5 ; 
    0 25000 -pi/2;
    500 25000 -pi/2;
    1400 4300 0.5;
    12345 1500 -2*pi/3];
% Initial states for intruder
int_init = [14750 0 1.65; 
    0 0 pi/2; 
    100 2000 pi/2;
    100 2000 pi/2;
    1000 1500 -pi/3];
% Number of simulations
m = size(own_init,1);
% time for all simulations
tf = 25; % Final time of simulation
st = 0.05; % Step size
time = 0:st:tf; % Time to simulate
% Simulate all
for i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    compareSimulations(own_init(i,:)',int_init(i,:)',time,i);
    disp(' ');
end