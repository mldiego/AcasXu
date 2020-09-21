%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Choose corners and random points from the edge cases regions
% Initial states for each test point
x_own = [30000 40000 pi/4];
x_int = [-926.02 9073.98 pi/4];
[x7,x8,x9] = environment(x_own,x_int);
init_dyn = [x_own x_int x7 x8 x9]';
tf = 12; % Final time of simulation
st = 1; % Initial advisory command
output = struct('data',cell(1,2),'t',cell(1,2));
%% Simulate Test Point 2
% [~, cores] = evalc('feature(''numcores'')');
parpool(2);
parfor K = 1:2
    if K==1
        % Test 2
        t1 = tic;
        [lb,ub] = calc_unc2(init_dyn,50);
        init_set = Star(lb,ub);
        output(K).data = reach_TestPointsb(init_set,@dyns_tp2,st,tf,'exact-star',463,900);
        output(K).t = toc(t1);
    end
    if K == 2
        t2 = tic;
        [lb2,ub2] = calc_unc2(init_dyn,-50);
        init_set2 = Star(lb2,ub2);
        output(K).data = reach_TestPointsb(init_set2,@dyns_tp2,st,tf,'approx-star',463,900);
        output(K).t = toc(t2);
    end
end

save('../data_reach/testPointsOrigin_2.mat','output','-v7.3');
%% Visualize results
plot_all = true;
% Right half
f = figure;
hold on;
if ~plot_all
    Star.plotBoxes_2D_noFill(output(1).data.step_sets,1,2,'r');
%     Star.plotBoxes_2D_noFill(data2.step_sets,4,5,'k');
else
    Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,'r');
    Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,4,5,'k');
end
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
if plot_all
    saveas(f,"../data_reach/TestPoint2Rall.png");
else
    saveas(f,"../data_reach/TestPoint2R.png");
end
% Plot end of trajectory
f3 = figure;
Star.plotBoxes_2D_noFill(output(1).data.int_reachSet,1,2,'r');
saveas(f3,'../data_reach/TestPoint2allR_end.png');

%% Visualize results
plot_all = true;

f = figure;
hold on;
if ~plot_all
    Star.plotBoxes_2D_noFill(output(2).data.step_sets,1,2,'r');
%     Star.plotBoxes_2D_noFill(output(2).data.step_sets,4,5,'k');
else
    Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,'r');
    Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,4,5,'k');
end
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
if plot_all
    saveas(f,"../data_reach/TestPoint2Lall.png");
else
    saveas(f,"../data_reach/TestPoint2L.png");
end
% Plot end of trajectory
f3 = figure;
Star.plotBoxes_2D_noFill(output(2).data.int_reachSet,1,2,'r');
saveas(f3,'../data_reach/TestPoint2Lall_end.png');
