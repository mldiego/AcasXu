%% Run multiple scenarios using NNV reachability analysis
% Execute multiple scenarios in parallel
clc;clear;close all;
% --- Setup scenarios ---
% ----- Scenarios 1 -----
lb1 = [0; 0; pi/2; 0; 25000; -pi/2; 24997; 0; -pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 25000; -pi/2; 25000; 0; -pi];
[lb2,up2] = calc_unc(lb2,3);
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 25000; -pi/2; 25003; 0; -pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 25000; -pi/2; 24994; 0; -pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 25000; -pi/2; 25006; 0; -pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 25000; -pi/2; 24991; 0; -pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 1
Init_Set1 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 2 -----
lb1 = [0; 0; pi/2; 0; 15000; -pi/2; 14997; 0; -pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 15000; -pi/2; 15000; 0; -pi];
[lb2,up2] = calc_unc(lb2,3);
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 15000; -pi/2; 15003; 0; -pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 15000; -pi/2; 14994; 0; -pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 15000; -pi/2; 15006; 0; -pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 15000; -pi/2; 14991; 0; -pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 2
Init_Set2 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenarios 3 ------
lb1 = [0; 0; pi/2; 0; 10000; -pi/2; 9997; 0; -pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 10000; -pi/2; 10000; 0; -pi];
[lb2,up2] = calc_unc(lb2,3);
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 10000; -pi/2; 10003; 0; -pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 10000; -pi/2; 9994; 0; -pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 10000; -pi/2; 10006; 0; -pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 10000; -pi/2; 9991; 0; -pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 3
Init_Set3 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% ----- Scenario 4
lb1 = [0; 0; pi/2; 0; 5000; -pi/2; 4997; 0; -pi];
[lb1,up1] = calc_unc(lb1,3);
init_set1 = Star(lb1,up1);
lb2 = [-3; 0; pi/2; 0; 5000; -pi/2; 5000; 0; -pi];
[lb1,up1] = calc_unc(lb1,3);
init_set2 = Star(lb2,up2);
lb3 = [-6; 0; pi/2; 0; 5000; -pi/2; 5003; 0; -pi];
[lb3,up3] = calc_unc(lb3,3);
init_set3 = Star(lb3,up3);
lb4 = [3; 0; pi/2; 0; 5000; -pi/2; 4994; 0; -pi];
[lb4,up4] = calc_unc(lb4,3);
init_set4 = Star(lb4,up4);
lb5 = [6; 0; pi/2; 0; 5000; -pi/2; 5006; 0; -pi];
[lb5,up5] = calc_unc(lb5,3);
init_set5 = Star(lb5,up5);
lb6 = [-9; 0; pi/2; 0; 5000; -pi/2; 4991; 0; -pi];
[lb6,up6] = calc_unc(lb6,3);
init_set6 = Star(lb6,up6);
% All initial sets scenario 4
Init_Set4 = [init_set1 init_set2 init_set3 init_set4 init_set5 init_set6];

% Number of simulations
init_set = [Init_Set1 Init_Set2 Init_Set3];% Init_Set4];
m = size(init_set,2);
%% Simulate all
Experiments = cell(1,m);
timing = cell(1,m);
% Experiments{1} = ReachACASXuNNCSb(init_set(1),1,1,'approx-star'); % Keep tf=3
% 6 scases at a time
parfor i=1:m
    disp('     Scenario ' + string(i));
    disp('-------------------------');
    t = tic;
    Experiments{i} = ReachACASXuNNCSb(init_set(i),1,3,'approx-star'); % Keep tf=3
    timing{i} = toc(t);
    disp(' ');
end

%% Visualize results
% Colors for plots
pc = ['r', 'b', 'g', 'y', 'c', 'm'];
% Scenarios 1
f1 = figure;
Star.plotBoxes_2D_noFill(Experiments{1}.int_reachSet,4,5,'k')
for i=1:6
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i));
end
grid;
xlabel('X position (ft)');
ylabel('Y position (ft)');

% Scenarios 2
f2 = figure;
Star.plotBoxes_2D_noFill(Experiments{7}.int_reachSet,4,5,'k')
for i=7:12
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i-6));
end
grid;
xlabel('X position (ft)');
ylabel('Y position (ft)');

% Scenarios 3
f3 = figure;
Star.plotBoxes_2D_noFill(Experiments{13}.int_reachSet,4,5,'k')
for i=13:18
    Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i-12));
end
grid;
xlabel('X position (ft)');
ylabel('Y position (ft)');
% Scenarios 4
% f4 = figure;
% Star.plotBoxes_2D_noFill(Experiments{19}.int_reachSet,4,5,'k')
% for i=19:24
%     Star.plotBoxes_2D_noFill(Experiments{i}.int_reachSet,1,2,pc(i-18));
% end
% grid;
% title('ACAS Xu aircraft set trajectories');
% xlabel('X position (ft)');
% ylabel('Y position (ft)');
% Save resutls
if ~exist('../data_reach','dir')
    mkdir('../data_reach')
end
saveas(f1,'../data_reach/StanSets25000.png');
saveas(f2,'../data_reach/StanSets15000.png');
saveas(f3,'../data_reach/StanSets10000.png');
% saveas(f4,'../data_reach/StanSets5000.png');
save('../data_reach/StanSets','Experiments','timing','init_set');


