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
m = size(init_dyn,3);
% tf = 35; % Currently saved data
% tf = 62; % Points 1,7,8 and 10
tf = 4; % Final time of simulation
% st = 1; % Step size
st = 2;
timeV = 0:st:tf; % Time to simulate
output = struct('data',cell(1,10),'tT',cell(1,10));
%% Simulate all
[~, cores] = evalc('feature(''numcores'')');
parpool(cores);
parfor K = 1 : 10
    if K == 1
        % Test 1
        [lb,ub] = calc_unc(init_dyn(1,:)',100);
        init_set = Star(lb,ub);
        t1 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp1,st,tf,'approx-star',955,1050);
        output(K).tT = toc(t1);
    end
%     if K == 2
%         % Test 2
%         t2 = tic;
%         [lb,ub] = calc_unc(init_dyn(2,:)',1);
%         init_set = Star(lb,ub);
%         output(K).data = reach_TestPoints(init_set,@dyns_tp2,st,tf,'approx-star',463,900);
%         output(K).tT = toc(t2);
%     end
    if K == 3
        % Test 3
        [lb,ub] = calc_unc(init_dyn(3,:)',100);
        init_set = Star(lb,ub);
        t3 =tic;
        output(K).data  = reach_TestPoints(init_set,@dyns_tp3,st,tf,'approx-star',61.57,150);
        output(K).tT = toc(t3);
    end
    if K == 4
        % Test 4
        [lb,ub] = calc_unc(init_dyn(4,:)',100);
        init_set = Star(lb,ub);
        t4 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp4,st,tf,'approx-star',204.76,600);
        output(K).tT = toc(t4);
    end
    if K == 5
        % Test 5
        [lb,ub] = calc_unc(init_dyn(5,:)',100);
        init_set = Star(lb,ub);
        t5 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp5,st,tf,'approx-star',362.26,300);
        output(K).tT = toc(t5);
    end
    if K == 6
        % Test 6
        [lb,ub] = calc_unc(init_dyn(6,:)',100);
        init_set = Star(lb,ub);
        t6 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp6,st,tf,'approx-star',609,750);
        output(K).tT = toc(t6);
    end
    if K == 7
        % Test 7
        [lb,ub] = calc_unc(init_dyn(7,:)',100);
        init_set = Star(lb,ub);
        t7 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp7,st,tf,'approx-star',1145,1145);
        output(K).tT = toc(t7);
    end
    if K == 8
        % Test 8
        [lb,ub] = calc_unc(init_dyn(8,:)',100);
        init_set = Star(lb,ub);
        t8 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp8,st,tf,'approx-star',636.2,450);
        output(K).tT = toc(t8);
    end
    if K == 9
        % Test 9
        [lb,ub] = calc_unc(init_dyn(9,:)',100);
        init_set = Star(lb,ub);
        t9 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp9,st,tf,'approx-star',497.56,60);
        output(K).tT = toc(t9);
    end
    if K == 10
        % Test 10
        [lb,ub] = calc_unc(init_dyn(10,:)',1);
        init_set = Star(lb,ub);
        t10 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp10,st,tf,'approx-star',600,600);
        output(K).tT = toc(t10);
    end
end

save('../data_reach/testPointsOrigin.mat','output','-v7.3');
%% Visualize results
plot_all = true;
for i=1:1
    if i==2
        disp('Working on it');
    else
        f = figure;
        hold on;
        if ~plot_all
            Star.plotBoxes_2D(output(i).data.step_sets,1,2,'r');
            Star.plotBoxes_2D(output(i).data.step_sets,4,5,'k');
        else
            Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,'r');
            Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,4,5,'k');
        end
        xlabel('X Position (ft)');
        ylabel('Y Position (ft)');
        if plot_all
            saveas(f,"../data_reach/TestPoint"+string(i)+"all.png");
        else
            saveas(f,"../data_reach/TestPoint"+string(i)+".png");
        end
    end
end