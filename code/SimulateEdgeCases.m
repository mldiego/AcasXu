%% Test all test points and edge cases 
clc;clear;close all;
%% --- Setup scenarios ---
% Choose corners and random points from the edge cases regions
% Initial states for ownship
own_init = [0 0 0; % Edge Case 1
    0 0 0;
    0 0 0;
    0 0 0; % Edge Case 2
    0 0 0;
    0 0 0;
    0 0 0;
    0 0 0; % Edge Case 3
    0 0 0;
    0 0 0; % Edge Case 4
    0 0 0;
    0 0 0; % Edge Case 5
    0 0 0;
    0 0 0; % Edge Case 6
    0 0 0;
    0 0 0; % Edge Case 7
    0 0 0;
    0 0 0; % Edge Case 8
    0 0 0;
    0 0 0; % Edge Case 9
    0 0 0;
    ]; 
% Initial states for intruder
int_init = [37700 -6470 -pi; % Edge Case 1
    41000 6470 -pi;
    40000 0 -pi;
    22658 6470 -pi; % Edge Case 2
    24148 10565 -pi;
    22658 -6470 -pi;
    24148 -10565 -pi;
    13500 7000 -pi; % Edge Case 3
    13500 -7000 -pi;
    10000 9000 -pi; % Edge Case 4
    10000 -9000 -pi;
    5635 5660 -pi; % Edge Case 5
    6680 -7460 -pi;
    3660 6145 -pi; % Edge Case 6
    3255 -6920 -pi;
    2645 5891 -pi; % Edge Case 7
    2060 -5060 -pi;
    -625 -4465 -pi; % Edge Case 8
    -4500 -1000 -pi;
    -4500 1000 -pi; % Edge Case 9
    0 5000 -pi;
    ]; 
% Number of simulations
m = size(own_init,1);
% time for all simulations
tf = 15; % Final time of simulation
st = 1; % Step size
time = 0:st:tf; % Time to simulate
%% Simulate all
% Save pictures with title name
titles = ['Edge Case 1 '; 'Edge Case 1 ';'Edge Case 1 ';'Edge Case 2 ';
    'Edge Case 2 ';'Edge Case 2 ';'Edge Case 2 ';'Edge Case 3 ';'Edge Case 3 ';
    'Edge Case 4 ';'Edge Case 4 ';'Edge Case 5 ';'Edge Case 5 ';'Edge Case 6 ';
    'Edge Case 6 ';'Edge Case 7 ';'Edge Case 7 ';'Edge Case 8 ';'Edge Case 8 ';
    'Edge Case 9 ';'Edge Case 9 ';] ;
for i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    compareSimulations(own_init(i,:)',int_init(i,:)',time,i,titles(i,:));
    disp(' ');
end