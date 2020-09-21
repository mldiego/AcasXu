%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---

% Test points a few steps before making a decision other than COC
init_dyn = [44884.9999999997,0,0,44857.4597464554,23163.4259001182,-0.430000000000000,23163.4422721634,1.57198528047930,-0.430000000000000; % Test point 1
    11112.0000000000,0,0,-22136.0000000001,0,0,33248.0000000006,-pi,0; % Test point 2
    17485.8800000001,0,0,6661.37977679120,-10877.3371639104,0.490000000000000,15345.5932320212,-2.35375663242015,0.490000000000000; % Test point 3
    3276.16000000001,0,0,-22700.8942631274,25975.4812779605,-0.541800000000000,36736.0215678262,2.35622443749876,-0.541800000000000; % Test point 4
    3622.60000000000,0,0,24127.0139245561,20499.8921207186,-0.240000000000000,8994.71074014045,0.806197043559839,-0.240000000000000; % Test point 5
    19488.0000000001,0,0,19533.0829599008,-29791.1561471050,0.620000000000000,29791.1902591093,-1.56928302783920,0.620000000000000; % Test point 6
    53814.9999999996,0,0,71731.8120481306,-42967.0180557308,0.780000000000000,46552.6003870736,-1.17572944847083,0.780000000000000; % Test point 7
    24811.8000000002,0,0,43646.8719885023,-18835.4286383100,0.760000000000000,26637.0978151548,-0.785407440292358,0.760000000000000; % Test point 8
    15424.3600000000,0,0,45596.0000000000,0,0,30171.6399999997,0,0; % Test point 9
    26999.9999999998,0,0,93000.0000000004,3.30654635769789e-12,3.14159265358979,66000.0000000004,5.00991872378461e-17,3.14159265358979; % Test point 10
    ];

% Number of test points
m = size(init_dyn,1);
% tf = 2; % Final time of simulation
tf = [8;0;6;4;10;2;8;8;8;8];
st = 1; % Initial advisory
output = struct('data',cell(1,10),'tT',cell(1,10));
%% Simulate all
delete(gcp('nocreate')); % End previous parallel session
[~, cores] = evalc('feature(''numcores'')');

parpool(cores);
parfor K = 1 : m
    if K == 1
        % Test 1
        [lb,ub] = calc_unc(init_dyn(1,:)',200);
        init_set = Star(lb,ub);
        t1 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp1,st,tf(K),'approx-star',955,1050);
        output(K).tT = toc(t1);
    end
%     if K == 2
%         % Test 2
%         t2 = tic;
%         [lb,ub] = calc_unc(init_dyn(2,:)',10);
%         init_set = Star(lb,ub);
%         output(K).data = reach_TestPoints(init_set,@dyns_tp2,st,tf(K),'approx-star',463,900);
%         output(K).tT = toc(t2);
%     end
    if K == 3
        % Test 3
        [lb,ub] = calc_unc(init_dyn(3,:)',200);
        init_set = Star(lb,ub);
        t3 =tic;
        output(K).data  = reach_TestPoints(init_set,@dyns_tp3,st,tf(K),'approx-star',61.57,150);
        output(K).tT = toc(t3);
    end
    if K == 4
        % Test 4
        [lb,ub] = calc_unc(init_dyn(4,:)',200);
        init_set = Star(lb,ub);
        t4 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp4,st,tf(K),'approx-star',204.76,600);
        output(K).tT = toc(t4);
    end
    if K == 5
        % Test 5
        [lb,ub] = calc_unc(init_dyn(5,:)',200);
        init_set = Star(lb,ub);
        t5 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp5,st,tf(K),'approx-star',362.26,300);
        output(K).tT = toc(t5);
    end
    if K == 6
        % Test 6
        [lb,ub] = calc_unc(init_dyn(6,:)',200);
        init_set = Star(lb,ub);
        t6 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp6,st,tf(K),'approx-star',609,750);
        output(K).tT = toc(t6);
    end
    if K == 7
        % Test 7
        [lb,ub] = calc_unc(init_dyn(7,:)',200);
        init_set = Star(lb,ub);
        t7 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp7,st,tf(K),'approx-star',1145,1145);
        output(K).tT = toc(t7);
    end
    if K == 8
        % Test 8
        [lb,ub] = calc_unc(init_dyn(8,:)',200);
        init_set = Star(lb,ub);
        t8 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp8,st,tf(K),'approx-star',636.2,450);
        output(K).tT = toc(t8);
    end
    if K == 9
        % Test 9
        [lb,ub] = calc_unc(init_dyn(9,:)',200);
        init_set = Star(lb,ub);
        t9 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp9,st,tf(K),'approx-star',497.56,60);
        output(K).tT = toc(t9);
    end
    if K == 10
        % Test 10
        [lb,ub] = calc_unc(init_dyn(10,:)',200);
        init_set = Star(lb,ub);
        t10 = tic;
        output(K).data = reach_TestPoints(init_set,@dyns_tp10,st,tf(K),'approx-star',600,600);
        output(K).tT = toc(t10);
    end
end

save('../data_reach/testPoints.mat','output','-v7.3');
%% Visualize results
plot_all = true;
for i=1:10
    if i==2
        disp('Working on it');
    else
        f = figure;
        hold on;
        if ~plot_all
            Star.plotBoxes_2D_noFill(output(i).data.step_sets,1,2,'r');
            Star.plotBoxes_2D_noFill(output(i).data.step_sets,4,5,'k');
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
        f3 = figure;
        Star.plotBoxes_2D_noFill(output(i).data.int_reachSet,1,2,'r');
        saveas(f3,"../data_reach/TestPoint"+string(i)+"_end.png");
    end
end