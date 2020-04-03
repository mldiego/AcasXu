%% Test multiple scenarios with 3 different simulations
clc;clear;close all;
% --- Setup scenarios ---
% Initial states for ownship
own_init = [1400 4300 0.5 ; 
    0 25000 -pi/2;
    500 25000 -pi/2;
    1400 4300 0.5;
    12345 1500 -2*pi/3
    12000 2000 -2*pi/3;
    5000 2000 0.31;
    15000 0 pi;
    5000 -5000 2.1;
    10000 -5000 2.1;
    15000 -3000 3.0;
    10000 -1000 3.0;
    15000 -1000 3.0;
    5000 -1000 3.05;
    5000 -500 3.05];
% Initial states for intruder
int_init = [14750 0 1.65; 
    0 0 pi/2; 
    100 2000 pi/2;
    100 2000 pi/2;
    1000 1500 -pi/3
    1000 1500 -pi/3;
    5000 3000 0.32;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0];
% Number of simulations
m = size(own_init,1);
% time for all simulations
tf = 25; % Final time of simulation
st = 0.1; % Step size
time = 0:st:tf; % Time to simulate
% Simulate all
for i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    compareSimulations(own_init(i,:)',int_init(i,:)',time,i);
    disp(' ');
end