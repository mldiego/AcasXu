%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Choose corners and random points from the edge cases regions
% Initial states for each test point
init_dyn = [0 0 0 0 43736 -0.43 43736 pi/2 -0.43; % Test point 1
    0 0 0 -43736 0 0 43736 pi 0; % Test point 2
    0 0 0 -7071.1 -7071.1 0.49 10000 -(3*pi)/4 0.49; % Test point 3
    0 0 0 -30926 30926 -0.5418 43736 3*pi/4 -0.5418; % Test point 4
    0 0 0 7071.1 7071.1 -0.24 10000 pi/4 -0.24; % Test point 5
    0 0 0 0 -43736 0.62 43736 -pi/2 0.62; % Test point 6
    0 0 0 33474 -80814 0.78 87472 -3*pi/8 0.78; % Test point 7
    0 0 0 30926 -30926 0.76 43736 -pi/4 0.76; % Test point 8
    0 0 0 43736 0 0 43736 0 0; % Test point 9
    0 0 0 120000 0 pi 120000 0 pi; % Test point 10
    ];  
% Number of test points
m = size(init_dyn,1);
% tf = 10; % Final time of simulation% 
tf = 2; % Final time of simulation
st = 1; % Step size
timeV = 0:st:tf; % Time to simulate
%% Simulate all
% parpool(6);
% parfor K = 1 : 10
%     if K == 1
%         % Test 1
%         t1 = tic;
%         data1 = reach_TestPoints(Star(init_dyn(1,:)',init_dyn(1,:)'),@dyns_tp1,1,tf,'approx-star',955,1050);
%         t1 = toc(t1);
%     end
%     if K == 2
%         % Test 2
%         t2 = tic;
%         data2 = reach_TestPoints(Star(init_dyn(2,:)',init_dyn(2,:)'),@dyns_tp2,1,tf,'approx-star',463,900);
%         t2 = toc(t2);
%     end
%     if K == 3
%         % Test 3
%         t3 =tic;
%         data3 = reach_TestPoints(Star(init_dyn(3,:)',init_dyn(3,:)'),@dyns_tp3,1,tf,'approx-star',61.57,150);
%         t3 = toc(t3);
%     end
%     if K == 4
%         % Test 4
%         t4 = tic;
%         data4 = reach_TestPoints(Star(init_dyn(4,:)',init_dyn(4,:)'),@dyns_tp4,1,tf,'approx-star',204.76,600);
%         t4 = toc(t4);
%     end
%     if K == 5
%         % Test 5
%         t5 = tic;
%         data5 = reach_TestPoints(Star(init_dyn(5,:)',init_dyn(5,:)'),@dyns_tp5,1,tf,'approx-star',362.26,300);
%         t5 = toc(t5);
%     end
%     if K == 6
%         % Test 6
%         t6 = tic;
%         data6 = reach_TestPoints(Star(init_dyn(6,:)',init_dyn(6,:)'),@dyns_tp6,1,tf,'approx-star',609,750);
%         t6 = toc(t6);
%     end
%     if K == 7
%         % Test 7
%         t7 = tic;
%         data7 = reach_TestPoints(Star(init_dyn(7,:)',init_dyn(7,:)'),@dyns_tp7,1,tf,'approx-star',1145,1145);
%         t7 = toc(t7);
%     end
%     if K == 8
%         % Test 8
%         t8 = tic;
%         data8 = reach_TestPoints(Star(init_dyn(8,:)',init_dyn(8,:)'),@dyns_tp8,1,tf,'approx-star',636.2,450);
%         t8 = toc(t8);
%     end
%     if K == 9
%         % Test 9
%         t9 = tic;
%         data9 = reach_TestPoints(Star(init_dyn(9,:)',init_dyn(9,:)'),@dyns_tp9,1,tf,'approx-star',497.56,60);
%         t9 = toc(t9);
%     end
%     if K == 10
%         % Test 10
%         t10 = tic;
%         data10 = reach_TestPoints(Star(init_dyn(10,:)',init_dyn(10,:)'),@dyns_tp10,1,tf,'approx-star',600,600);
%         t10 = toc(t10);
%     end
% end

%% Test 1
t1 = tic;
data1 = reach_TestPoints(Star(init_dyn(1,:)',init_dyn(1,:)'),@dyns_tp1,1,tf,'approx-star',955,1050);
t1 = toc(t1);

%% Test 2 
% Too many splits, does not finish within reasonable time
% t2 = tic;
% data2 = reach_TestPoints(Star(init_dyn(2,:)',init_dyn(2,:)'),@dyns_tp2,1,tf,'approx-star',463,900);
% t2 = toc(t2);

%% Test 3
t3 =tic;
data3 = reach_TestPoints(Star(init_dyn(3,:)',init_dyn(3,:)'),@dyns_tp3,1,tf,'approx-star',61.57,150);
t3 = toc(t3);

%% Test 4
t4 = tic;
data4 = reach_TestPoints(Star(init_dyn(4,:)',init_dyn(4,:)'),@dyns_tp4,1,tf,'approx-star',204.76,600);
t4 = toc(t4);

%% Test 5
t5 = tic;
data5 = reach_TestPoints(Star(init_dyn(5,:)',init_dyn(5,:)'),@dyns_tp5,1,tf,'approx-star',362.26,300);
t5 = toc(t5);

%% Test 6
t6 = tic;
data6 = reach_TestPoints(Star(init_dyn(6,:)',init_dyn(6,:)'),@dyns_tp6,1,tf,'approx-star',609,750);
t6 = toc(t6);

%% Test 7
t7 = tic;
data7 = reach_TestPoints(Star(init_dyn(7,:)',init_dyn(7,:)'),@dyns_tp7,1,tf,'approx-star',1145,1145);
t7 = toc(t7);

%% Test 8
t8 = tic;
data8 = reach_TestPoints(Star(init_dyn(8,:)',init_dyn(8,:)'),@dyns_tp8,1,tf,'approx-star',636.2,450);
t8 = toc(t8);

%% Test 9
t9 = tic;
data9 = reach_TestPoints(Star(init_dyn(9,:)',init_dyn(9,:)'),@dyns_tp9,1,tf,'approx-star',497.56,60);
t9 = toc(t9);

%% Test 10
t10 = tic;
data10 = reach_TestPoints(Star(init_dyn(10,:)',init_dyn(10,:)'),@dyns_tp10,1,tf,'approx-star',600,600);
t10 = toc(t10);

