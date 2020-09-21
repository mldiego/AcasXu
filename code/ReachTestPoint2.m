%% Reachability analysis of all test points
clc;clear;close all;
%% --- Setup scenarios ---
% Choose corners and random points from the edge cases regions
% Initial states for each test point
x_own = [30000 40000 pi/4];
x_int = [-926.02 9073.98 pi/4];
[x7,x8,x9] = environment(x_own,x_int);
init_dyn = [x_own x_int x7 x8 x9]';
tf = 78; % Final time of simulation
st = 1; % Step size

%% Simulate Test Point 2
% Test 2
t2 = tic;
[lb,ub] = calc_unc2(init_dyn,10);
init_set = Star(lb,ub);
data2 = reach_TestPointsb(init_set,@dyns_tp2,1,tf,'exact-star',463,900);
t2 = toc(t2);

save('../data_reach/testPointsOrigin_2.mat','data2','-v7.3');
%% Visualize results
plot_all = true;

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
% Plot end of trajectory
f3 = figure;
Star.plotBoxes_2D_noFill(data2.int_reachSet(550:end),1,2,'r');
    Star.plotBoxes_2D_noFill(data2.int_reachSet(550:end),4,5,'k');
saveas(f3,'../data_reach/TestPoint2all_end.png');

%% Plot distance
pdSet = [];
reachStep = 0.05;
times = 0:reachStep:tf+reachStep;
for i=1:length(times)-1
    X = Star(times(i),times(i)+1);
    %timeSet= [timeSet X];
    Y = data2.int_reachSet(i).affineMap([0 0 0 0 0 0 1 0 0],[]);
    %distSet = [distSet Y];
    pdSet = [pdSet X.concatenate(Y)];
end
f2 = figure;
Star.plotBoxes_2D(pdSet,1,2,'r')
ylabel('Distance (ft)');
xlabel('Time (s)');
saveas(f2,"../data_reach/TestPoint2all_distance.png");
