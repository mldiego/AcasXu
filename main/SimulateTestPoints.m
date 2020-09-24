%% Simulate all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Test case initial states (original)
init_dyn = [0 1000 pi/2 -43736 0 pi/2-0.4296 43747.43 pi/2 -0.4296; % Test point 1
    0 0 pi/2 0 -43736 pi/2 43736 -3.14159265358979 0; % Test point 2
    0 0 pi/2 30926 -30926 pi/2+0.3617 43736 -(3*pi)/4 0.3617; % Test point 3
    0 0 pi/2 -30926 -30926 pi/2-0.5415 43736 3*pi/4 -0.5415; % Test point 4
    0 0 pi/2 -30926 30926 pi/2-0.2379 43736 pi/4 -0.2379; % Test point 5
    0 0 pi/2 43736 0 pi/2+0.6226 43736 -pi/2 0.6226; % Test point 6
    0 0 pi/2 80814 33474 pi/2+0.7835 87472 -3*pi/8 0.7835; % Test point 7
    0 0 pi/2 30926 30926 pi/2+0.7577 43736 -pi/4 0.7577; % Test point 8
    0 0 pi/2 0 43736 pi/2 43736 0 0; % Test point 9
    0 0 pi/2 0 120000 -pi/2 120000 0 pi; % Test point 10
    ];
% Test case initial states (rotated)
% init_dyn = [0 0 0 0 43736 -0.43 43736 pi/2 -0.43; % Test point 1
%     30000 40000 0.785398163397448 -926.020000000000 9073.98000000000 0.785398163397448 43735.9969142216 -3.14159265358979 0; % Test Point 2
%     0 0 0 -30926 -30926 0.3617 43736 -(3*pi)/4 0.3617; % Test point 3
%     0 0 0 -30926 30926 -0.5415 43736 3*pi/4 -0.5415; % Test point 4
%     0 0 0 30926 30926 -0.24 43736 pi/4 -0.24; % Test point 5
%     0 0 0 0 -43736 0.62 43736 -pi/2 0.62; % Test point 6
%     0 0 0 33474 -80814 0.78 87472 -3*pi/8 0.78; % Test point 7
%     0 0 0 30926 -30926 0.76 43736 -pi/4 0.76; % Test point 8
%     0 0 0 43736 0 0 43736 0 0; % Test point 9
%     0 0 0 120000 0 pi 120000 0 pi; % Test point 10
%     ];

% Number of simulations
m = size(init_dyn,1);
% time for all simulations
tf = 100; % Final time of simulation
st = 1; % Step size
timeV = 0:st:tf; % Time to simulate
out_sim = struct('data',cell(1,10));
%% Simulate all
% Test 1
out_sim(1).data = sim_TestPoints(init_dyn(1,:),@dyns_tp1,timeV,'TestPoint1',955,1050);
% Test 2
out_sim(2).data = sim_TestPoints(init_dyn(2,:),@dyns_tp2,timeV,'TestPoint2',463,900);
% Test 3
out_sim(3).data = sim_TestPoints(init_dyn(3,:),@dyns_tp3,0:2:400,'TestPoint3',100,200);
% Test 4
out_sim(4).data = sim_TestPoints(init_dyn(4,:),@dyns_tp4,timeV,'TestPoint4',204.76,600);
% Test 5
out_sim(5).data = sim_TestPoints(init_dyn(5,:),@dyns_tp5,0:2:400,'TestPoint5',362.26,300);
% Test 6
out_sim(6).data = sim_TestPoints(init_dyn(6,:),@dyns_tp6,timeV,'TestPoint6',609,750);
% Test 7
out_sim(7).data = sim_TestPoints(init_dyn(7,:),@dyns_tp7,timeV,'TestPoint7',1145,1145);
% Test 8
out_sim(8).data = sim_TestPoints(init_dyn(8,:),@dyns_tp8,timeV,'TestPoint8',636.2,450);
% Test 9
out_sim(9).data = sim_TestPoints(init_dyn(9,:),@dyns_tp9,timeV,'TestPoint9',497.56,60);
% Test 10
out_sim(10).data = sim_TestPoints(init_dyn(10,:),@dyns_tp10,timeV,'TestPoint10',600,600);
