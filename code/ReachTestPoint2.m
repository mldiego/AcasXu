%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Choose corners and random points from the edge cases regions
% Initial states for each test point
% init_dyn = [0 0 0 -43736 0 0 43736 pi 0]; % Test point 2
% x_own = [30000 40000 pi/4];
% x_int = [-926.02 9073.98 pi/4];
% [x7,x8,x9] = environment(x_own,x_int);
% init_dyn = [x_own x_int x7 x8 x9]';
init_dyn = [37529.9801128560,47529.9801128562,0.785398163397448,13711.0903705615,23711.0903705615,0.785398163397448,33684.9969142221,-pi,0];
tf = 3; % Final time of simulation
st = 1; % Step size

%% Simulate Test Point 2
% Test 2
t2 = tic;
[lb,ub] = calc_unc(init_dyn',2);
init_set = Star(lb,ub);
data2 = reach_TestPointsb(init_set,@dyns_tp2,1,tf,'exact-star',463,900);
t2 = toc(t2);

save('../data_reach/testPointsOrigin_2.mat','data2','-v7.3');
%% Visualize results
plot_all = false;

f = figure;
hold on;
if ~plot_all
    Star.plotBoxes_2D_noFill(data2.step_sets,1,2,'r');
%     Star.plotBoxes_2D_noFill(data2.step_sets,4,5,'k');
else
    Star.plotBoxes_2D_noFill(data2.int_reachSet,1,2,'r');
    Star.plotBoxes_2D_noFill(data2.int_reachSet,4,5,'k');
end
xlabel('X Position (ft)');
ylabel('Y Position (ft)');
if plot_all
    saveas(f,"../data_reach/TestPoint2all.png");
else
    saveas(f,"../data_reach/TestPoint2.png");
end
